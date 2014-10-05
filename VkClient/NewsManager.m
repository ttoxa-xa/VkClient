//
// Created by 1 1 on 22.08.14.
// Copyright (c) 2014 Anton. All rights reserved.
//

#import "NewsManager.h"
#import "User.h"
#import "News.h"
#import "NewsViewController.h"
#import "Picture.h"
#import <AFNetworking.h>

@interface NewsManager ()

@property(nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property(atomic) BOOL newsHaveChanges;
@property(nonatomic, strong) NSString *nextFrom;

@end

@implementation NewsManager

static NSString *const vkRequestURL = @"https://api.vk.com/method/";
static NSString *const getNewsFunc = @"newsfeed.get";
static NSInteger const newsCount = 5;
static NSString *const newsStartFromKey = @"start_from";
static NSString *const newsNextFromKey = @"next_from";
static NSString *const newsCountKey = @"count";
static NSString *const newsFilterKey = @"filters";
static NSString *const newsFilterValue = @"post";
static NSString *const tokenKey = @"access_token";
static NSString *const newsItemsKey = @"items";
static NSString *const newsProfilesKey = @"profiles";
static NSString *const newsGroupsKey = @"groups";
static NSString *const newsIdKey = @"post_id";
static NSString *const newsSourceKey = @"source_id";
static NSString *const newsDateKey = @"date";
static NSString *const newsTextKey = @"text";
static NSString *const newsCopyHistoryKey = @"copy_history";
static NSString *const profileIdKey = @"id";
static NSString *const firstNameKey = @"first_name";
static NSString *const lastNameKey = @"last_name";
static NSString *const groupNameKey = @"name";
static NSString *const newsAttachmentsKey = @"attachments";
static NSString *const attachmentTypeKey = @"type";
static NSString *const photoUrlKey = @"photo_604";
static NSString *const avatarUrlKey = @"photo_100";

NSString *const newsNumberKey = @"newsNumber";
NSString *const attachmentPhotoKey = @"photo";
NSString *const pictureNumberKey = @"pictureNumber";

@synthesize news = _news;

#pragma mark init

- (NewsManager *)init {
    self = [super init];
    if (self) {
        _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:vkRequestURL]];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

- (NewsManager *)initWithUser:(User *)user {
    self = [self init];
    if (self) {
        _user = user;
        [self requestUsersNews];
    }
    return self;
}

#pragma mark getters

- (NSArray *)news {
    @synchronized (self) {
        if (_newsHaveChanges || !_news) {
            _newsHaveChanges = NO;
            NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:newsDateKey ascending:NO];
            _news = [[_user.news allObjects] sortedArrayUsingDescriptors:@[descriptor]];
        }
        return _news;
    }
}

#pragma mark working with news

- (void)requestUsersNews {
    [self requestUsersNewsWithNextFromParameter:@"0"];
}

- (void)requestUsersOldNews {
    [self requestUsersNewsWithNextFromParameter:_nextFrom];
}


- (void)requestUsersNewsWithNextFromParameter:(NSString *)nextFrom {
    NSDictionary *parameters = @{
            newsFilterKey : newsFilterValue,
            newsStartFromKey : nextFrom,
            newsCountKey : @(newsCount),
            tokenKey : _user.token,
            @"v" : @(5.24)
    };
    [_manager GET:getNewsFunc parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response = (NSDictionary *) responseObject[@"response"];
        if (response) {
            NSArray *items = response[newsItemsKey];
            NSArray *profiles = response[newsProfilesKey];
            NSArray *groups = response[newsGroupsKey];
            _nextFrom = response[newsNextFromKey];
            [self processNewsItems:items andProfiles:profiles andGroups:groups];

            if ([nextFrom isEqualToString:@"0"])
                [self removeOldNewsIfNeeded];

            [[NSNotificationCenter defaultCenter] postNotificationName:newsLoadedNotificationName object:nil];
        }
    }     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:newsLoadedNotificationName object:nil];
    }];
}

- (BOOL)newsAlreadyExists:(int)newsId {
    for (News *news in self.news) {
        if ([(NSNumber *) news.id intValue] == newsId)
            return YES;
    }
    return NO;
}

- (void)removeOldNewsIfNeeded {
    while (self.news.count > newsCount) {
        [_user removeNewsObject:_news.lastObject];

        _newsHaveChanges = YES;
    }
}

- (void)processNewsItems:(NSArray *)items andProfiles:(NSArray *)profiles andGroups:(NSArray *)groups {
    for (NSDictionary *item in items) {
        if (![self newsAlreadyExists:[(NSNumber *) item[newsIdKey] intValue]]) {
            _newsHaveChanges = YES;
            News *currentNews = [News createEntity];
            currentNews.id = item[newsIdKey];
            currentNews.owner = item[newsSourceKey];
            double unixTime = [(NSNumber *) item[newsDateKey] doubleValue];
            currentNews.date = [NSDate dateWithTimeIntervalSince1970:unixTime];
            if ([currentNews.owner intValue] < 0) {
                int ownersIndex = [self findProfileById:ABS([currentNews.owner intValue]) inArray:groups];  //load avatar for group async
                NSDictionary *group = groups[ownersIndex];
                currentNews.ownersName = group[groupNameKey];
                [self loadAvatarFromProfileOrGroup:group toNews:currentNews];
            }
            else {
                int ownersIndex = [self findProfileById:[currentNews.owner intValue] inArray:profiles];    //load avatar for user async
                NSDictionary *profile = profiles[ownersIndex];
                currentNews.ownersName = [NSString stringWithFormat:@"%@ %@", profile[firstNameKey], profile[lastNameKey]];
                [self loadAvatarFromProfileOrGroup:profile toNews:currentNews];
            }
            currentNews.text = item[newsTextKey];

            if ([[item allKeys] containsObject:newsCopyHistoryKey]) {                                      //load reposts data
                NSArray *copies = item[newsCopyHistoryKey];
                for (NSDictionary *copy in copies) {
                    currentNews.text = [NSString stringWithFormat:@"%@\nrepost:\n%@", currentNews.text, copy[newsTextKey]];
                    [self loadNewsPicturesFromNewsItems:copy toNews:currentNews];
                }
            }
            [_user addNewsObject:currentNews];

            [self loadNewsPicturesFromNewsItems:item toNews:currentNews];
        }
        else
            break;
    }
}

- (void)loadAvatarFromProfileOrGroup:(NSDictionary *)info toNews:(News *)news {
    Picture *avatar = [Picture createEntity];
    [avatar loadImageFromURL:[NSURL URLWithString:info[avatarUrlKey]] withCompetition:^{        //load image async
        if (avatar.pictureData) {
            [news setAvatar:avatar];
            [self sendAvatarDataToNewsController:avatar.pictureData withNumberOdNews:@([self.news indexOfObject:news])];
        }
    }];
}

- (void)loadNewsPicturesFromNewsItems:(NSDictionary *)item toNews:(News *)news {
    NSArray *attachments = item[newsAttachmentsKey];

    if (attachments) {
        for (int i = 0; i < attachments.count; i++) {
            NSDictionary *attachment = attachments[(NSUInteger) i];

            if (![attachment[attachmentTypeKey] isEqual:attachmentPhotoKey])
                continue;
            news.hasPicture = @(YES);

            NSDictionary *pictureInfo = attachment[attachmentPhotoKey];

            Picture *picture = [Picture createEntity];

            [picture loadImageFromURL:[NSURL URLWithString:pictureInfo[photoUrlKey]] withCompetition:^{   //load image async
                if (picture.pictureData) {
                    [news addPicturesObject:picture];
                    [self sendPictureDataToNewsController:picture.pictureData withNumberOfNews:@([self.news indexOfObject:news]) andNumberOfPicture:@(i)];
                }
            }];
        }
    }

}

- (void)sendAvatarDataToNewsController:(NSData *)avatarData withNumberOdNews:(NSNumber *)newsNumber {
    NSDictionary *pictureInfo = @{
            attachmentPhotoKey : avatarData,
            newsNumberKey : newsNumber,
    };

    [[NSNotificationCenter defaultCenter] postNotificationName:avatarLoadedNotificationName object:nil userInfo:pictureInfo];
}

- (void)sendPictureDataToNewsController:(NSData *)pictureData withNumberOfNews:(NSNumber *)newsNumber andNumberOfPicture:(NSNumber *)pictureNumber {
    NSDictionary *pictureInfo = @{
            attachmentPhotoKey : pictureData,
            newsNumberKey : newsNumber,
            pictureNumberKey : pictureNumber
    };

    [[NSNotificationCenter defaultCenter] postNotificationName:pictureLoadedNotificationName object:nil userInfo:pictureInfo];
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:nil];
}

- (int)findProfileById:(int)id inArray:(NSArray *)profilesOrGroups {
    int index = NSNotFound;
    for (int i = 0; i < profilesOrGroups.count; i++) {
        NSDictionary *item = profilesOrGroups[i];
        if (id == [(NSNumber *) item[profileIdKey] intValue]) {
            index = i;
        }
    }
    return index;
}

@end
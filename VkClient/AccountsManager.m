//
// Created by 1 1 on 06.08.14.
// Copyright (c) 2014 Anton. All rights reserved.
//

#import "AccountsManager.h"
#import "AFNetworking.h"
#import "User.h"
#import "LoginViewController.h"


@interface AccountsManager ()

@property(nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation AccountsManager

static NSString *const vkRequestURL = @"https://api.vk.com/method/";
static NSString *const getUserInfoFunc = @"users.get";
static NSString *const accessTokenKey = @"token";

- (AccountsManager *)init {
    self = [super init];
    if (self) {
        _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:vkRequestURL]];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _users = [[User findAll] mutableCopy];
    }
    return self;
}

/*- (AccountsManager *)initWithUserId:(int)Id andAccessToken:(NSString *)token{
    self = [self init];
    if (self){
        [self addUserWithId:Id andAccessToken:token];
    }
    return self;
}

- (AccountsManager *)initWithUser:(User *)user{
    self = [self init];
    if (self){
        _currentUser = user;
    }
    return self;
}*/

- (void)addUserWithId:(int)Id andAccessToken:(NSString *)token {
    NSDictionary *parameters = @{@"user_id" : @(Id),
            @"fields" : @"photo_medium",
            @"access_token" : token
    };
    [_manager GET:getUserInfoFunc parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *json = (NSDictionary *) responseObject;
        if (json[@"response"] != nil) {
            NSArray *response = json[@"response"];
            NSMutableDictionary *userData = [response[0] mutableCopy];
            userData[accessTokenKey] = token;
            [self userDataReceived:userData];
        }
    }     failure:nil];
}

- (void)userDataReceived:(NSDictionary *)userData {
    _currentUser = [User importFromObject:userData];
    [_users addObject:_currentUser];
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:newUserAddedNotificationName object:nil];
    }];
}

- (NSMutableArray *)users {
    if (!_users) {
        _users = [[NSMutableArray alloc] init];
    }
    return _users;
}

@end
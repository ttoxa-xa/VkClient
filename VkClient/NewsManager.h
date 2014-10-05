//
// Created by 1 1 on 22.08.14.
// Copyright (c) 2014 Anton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

extern NSString *const newsNumberKey;
extern NSString *const attachmentPhotoKey;
extern NSString *const pictureNumberKey;

@interface NewsManager : NSObject

@property(nonatomic, strong) User *user;
@property(atomic, strong, readonly) NSArray *news;

- (NewsManager *)initWithUser:(User *)user;

- (void)requestUsersNews;

- (void)requestUsersOldNews;

@end
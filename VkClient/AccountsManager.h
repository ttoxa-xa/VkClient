//
// Created by 1 1 on 06.08.14.
// Copyright (c) 2014 Anton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

extern NSString *const userKey;

@interface AccountsManager : NSObject

@property(nonatomic, strong) User *currentUser;
@property(nonatomic, strong) NSMutableArray *users;

- (void)addUserWithId:(int)Id andAccessToken:(NSString *)token;

@end
//
// Created by 1 1 on 04.08.14.
// Copyright (c) 2014 Anton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AccountsManager;

@interface OauthViewController : UIViewController <UIWebViewDelegate>

@property(nonatomic, strong) AccountsManager *accountsManager;

@end
//
//  NewsViewController.h
//  VkClient
//
//  Created by 1 1 on 22.08.14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const newsLoadedNotificationName;
extern NSString *const pictureLoadedNotificationName;
extern NSString *const avatarLoadedNotificationName;

@class User;

@interface NewsViewController : UITableViewController <UIScrollViewDelegate>

@property(nonatomic, strong) User *user;

@end

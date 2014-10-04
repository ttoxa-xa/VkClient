//
//  NewsDetailsViewController.h
//  VkClient
//
//  Created by 1 1 on 21.09.14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;

@interface NewsDetailsViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong)News *news;

@end

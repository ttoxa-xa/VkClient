//
//  NewsDetailsViewController.m
//  VkClient
//
//  Created by 1 1 on 21.09.14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "NewsDetailsViewController.h"
#import "ImageCell.h"
#import "News.h"
#import "Picture.h"

@interface NewsDetailsViewController ()
@property(weak, nonatomic) IBOutlet UICollectionView *imagesCollectionView;
@property(weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property(weak, nonatomic) IBOutlet UILabel *ownersNameLabel;
@property(weak, nonatomic) IBOutlet UILabel *newsTextLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imagesCollectionViewHeight;

@end

@implementation NewsDetailsViewController

static NSString *const reuseIdentifier = @"imageCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _newsTextLabel.text = _news.text;
    _avatarImageView.image = [UIImage imageWithData:_news.avatar.pictureData];
    _ownersNameLabel.text = _news.ownersName;
    if (![_news hasPictureValue]){
        _imagesCollectionViewHeight.constant = 0.0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark CollectionView data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _news.pictures.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    Picture *attachedPicture = _news.pictures.allObjects[indexPath.row];
    UIImage *attachedImage = [UIImage imageWithData:attachedPicture.pictureData];
    imageCell.imageView.image = attachedImage;
    return imageCell;
}

@end

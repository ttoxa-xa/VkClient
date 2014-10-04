//
//  NewsCell.h
//  VkClient
//
//  Created by 1 1 on 22.08.14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell

@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *dateLabel;
@property(weak, nonatomic) IBOutlet UIImageView *ownersPhotoView;
@property(strong, nonatomic) IBOutletCollection(UIImageView) NSArray *attachedImages;
@property(weak, nonatomic) IBOutlet UILabel *newsTextLabel;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *attachedImagesContraints;

- (void)hideImageViews;
- (void)setAttachedImageWithPictureData:(NSData *)pictureData andNumber:(NSUInteger)pictureNumber;
- (void)setAvatarWithData:(NSData *)avatarData;
- (void)setImageViewsHeight:(CGFloat)height;

@end

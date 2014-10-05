//
//  NewsCell.m
//  VkClient
//
//  Created by 1 1 on 22.08.14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "NewsCell.h"

@interface NewsCell ()

@end

@implementation NewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)hideImageViews {
    for (UIImageView *imageView in _attachedImages) {
        imageView.image = nil;
        imageView.hidden = YES;
    }
}

- (void)setAttachedImageWithPictureData:(NSData *)pictureData andNumber:(NSUInteger)pictureNumber {
    UIImageView *imageView = self.attachedImages[pictureNumber];
    imageView.image = [UIImage imageWithData:pictureData];
    imageView.hidden = NO;
}

- (void)setAvatarWithData:(NSData *)avatarData {
    UIImageView *imageView = self.ownersPhotoView;
    imageView.image = [UIImage imageWithData:avatarData];
}

- (void)setImageViewsHeight:(CGFloat)height {
    for (NSLayoutConstraint *imageConstraint in _attachedImagesContraints) {
        imageConstraint.constant = height;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  TSLCollectionViewCell.m
//  TSLogistics
//
//  Created by erpapa on 15/11/11.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLCollectionViewCell.h"

@interface TSLCollectionViewCell()
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation TSLCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)setImage:(NSString *)image
{
    _image = [image copy];
    UIImage *originImage = [UIImage imageNamed:image];
    self.imageView.image = originImage;
    self.imageView.highlightedImage = [originImage imageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.35] rect:CGRectMake(0, 0, originImage.size.width, originImage.size.height * 0.65)];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}
@end

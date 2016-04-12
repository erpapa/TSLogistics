//
//  TSLTopButton.m
//  TSLogistics
//
//  Created by erpapa on 15/11/13.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLTopButton.h"

@implementation TSLTopButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    [super setTitleColor:color forState:state];
    if (state == UIControlStateNormal) {
        [self setImage:[UIImage imageWithColor:self.backgroundColor] forState:state];
    } else if (state == UIControlStateSelected){
        [self setImage:[UIImage imageWithColor:color] forState:state];
    }
}

- (void)setHighlighted:(BOOL)highlighted{};

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = contentRect.size.height - 2;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = 2;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - 2;
    return CGRectMake(titleX, titleY, titleW, titleH);
}


@end

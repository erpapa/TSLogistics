//
//  UIImage+MJ.h
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SW)

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
/**
 *  颜色转换为背景图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 *  缩放图片
 */
+ (UIImage*)imageFromOrigin:(UIImage *)image scaleToSize:(CGSize)size;
/**
 *  改变图片颜色
 */
- (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect;

/**
 *  旋转图片
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
@end

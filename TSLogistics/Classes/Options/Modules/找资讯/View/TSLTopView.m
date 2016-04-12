//
//  TSLTopView.m
//  TSLogistics
//
//  Created by erpapa on 15/11/27.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLTopView.h"
#import "TSLTopButton.h"
#import "UIView+MJExtension.h"

@interface TSLTopView()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) TSLTopButton *currentButton;
@end

@implementation TSLTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.backgroundColor = self.foregroundColor;
        self.scrollView.bounces = NO;
        // 一定要都设置为NO，它将移除自带的两个滑块，此时没有子控件了
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.scrollView];
    }
    return self;
}

/**
 *  设置内容
 */
- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    for (NSInteger index = 0; index < titleArray.count; index++) {
        TSLTopButton *btn = [self buttonWithTitle:self.titleArray[index] tag:index];
        [self.scrollView addSubview:btn];
        if (index == 0) {
            btn.selected = YES;
            self.currentButton = btn;
        }
    }
}

/**
 *  @return 资讯标题button
 */
- (TSLTopButton *)buttonWithTitle:(NSString *)title tag:(NSInteger)tag
{
    TSLTopButton *btn = [[TSLTopButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    return btn;
}

/**
 *  点击资讯标题
 */
- (void)btnClick:(TSLTopButton *)sender
{
    if (sender == self.currentButton) {
        return;
    } else {
        BOOL animated = YES;
        if (labs(sender.tag - self.currentButton.tag) > 2) {// 如果相隔太多，就不用动画
            animated = NO;
        }
        if ([self.delegate respondsToSelector:@selector(topView:scrollToPage:animated:)]) {
            [self.delegate topView:self scrollToPage:sender.tag animated:animated];
        }
        self.currentButton.selected = NO;
        sender.selected = YES;
        self.currentButton = sender;
    }
}

/**
 *  设置前景色
 */
- (void)setForegroundColor:(UIColor *)foregroundColor
{
    _foregroundColor = foregroundColor;
    self.scrollView.backgroundColor = foregroundColor;
    for (TSLTopButton *btn in self.scrollView.subviews){
        [btn setTitleColor:foregroundColor forState:UIControlStateSelected];
    }
}
/**
 *  设置标题按钮宽度
 */
- (void)setTitleWidth:(CGFloat)titleWidth
{
    _titleWidth = titleWidth;
    for (NSInteger index = 0; index < self.titleArray.count; index++){
        TSLTopButton *btn = [self.scrollView.subviews objectAtIndex:index];
        btn.frame = CGRectMake(titleWidth * index, 0, titleWidth, self.mj_h - 1);
    }
    self.scrollView.contentSize = CGSizeMake(self.titleArray.count * titleWidth, self.mj_h);
}

/**
 *  设置页数
 */
- (void)setPage:(NSInteger)page
{
    _page = page;
    TSLTopButton *button = [self.scrollView.subviews objectAtIndex:page];
    if (button == self.currentButton) return;
    CGPoint offset;
    if (button.tag <= 1) {
        offset = CGPointZero;;
    } else if (button.tag >= self.titleArray.count - 2) {
        offset = CGPointMake(self.scrollView.contentSize.width - self.scrollView.bounds.size.width, 0);
    } else {
        offset = CGPointMake(button.mj_w * (button.tag - 1), 0);
    }
    self.scrollView.contentOffset = offset;
    self.currentButton.selected = NO;
    button.selected = YES;
    self.currentButton = button;
}
@end

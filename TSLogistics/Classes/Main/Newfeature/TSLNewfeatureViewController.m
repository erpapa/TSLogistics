//
//  TSLNewfeatureViewController.m
//  TSLogistics
//
//  Created by erpapa on 15/12/3.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLNewfeatureViewController.h"
#import "TSLTool.h"

@interface TSLNewfeatureViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIPageControl *pageControl;
@end

@implementation TSLNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollView];
    [self setupPageControl];
}
/**
 *  设置滚动视图
 */
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    CGFloat imageW = self.view.bounds.size.width;
    CGFloat imageH = self.view.bounds.size.height;
    for (int i = 0; i < imageCount; i++) {
        CGFloat imageX = imageW * i;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, 0, imageW, imageH)];
        NSString *imageStr = [NSString stringWithFormat:@"引导页%d", i+1];
//        if (ScreenH == 568) { // 加载568h图片
//            imageStr = [NSString stringWithFormat:@"new_feature_%d-568h", i+1];
//        }
        imageView.image = [UIImage imageNamed:imageStr];
        [scrollView addSubview:imageView];
        if (i == imageCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    // 3.设置滚动的内容尺寸
    scrollView.contentSize = CGSizeMake(imageW * imageCount, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;//代理
    [self.view addSubview:scrollView];
}
/**
 *  pageControl
 */
- (void)setupPageControl
{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 140) / 2, self.view.bounds.size.height - 30, 140, 20)];
    self.pageControl.pageIndicatorTintColor = TSLColor(189, 189, 189);
    self.pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    self.pageControl.numberOfPages = imageCount;
    [self.view addSubview:self.pageControl];
}
/**
 *  立即体验
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;// 允许与用户交互
    
    CGFloat checkBoxX = (self.view.bounds.size.width - 120) / 2;
    CGFloat checkBoxY = self.view.bounds.size.height * 0.75;
    UIButton *checkBox = [[UIButton alloc] initWithFrame:CGRectMake(checkBoxX, checkBoxY, 132, 34)];
    [checkBox setImage:[UIImage imageNamed:@"按钮_03"] forState:UIControlStateNormal];

    checkBox.selected = YES;
    [checkBox addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:checkBox];
}

- (void)startBtnClick
{
    // 保存新版本
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[CFBundleVersion];
    [defaults setObject:currentVersion forKey:CFBundleVersion];
    [defaults synchronize];
    // 设置根控制器
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = [storyboard instantiateInitialViewController];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double pageDouble = scrollView.contentOffset.x / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

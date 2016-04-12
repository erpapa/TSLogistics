//
//  TSLInformationController.m
//  TSLogistics
//
//  Created by erpapa on 15/11/26.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLInformationController.h"
#import "TSLInformationCell.h"
#import "TSLTopView.h"
#import "UIView+MJExtension.h"
#define reuseID @"InformationCell"

@interface TSLInformationController()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, TSLTopViewDelegate>
@property (strong, nonatomic) TSLTopView *topView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *offsetArray;// 偏移
@property (strong, nonatomic) NSArray *infoArray;// 数据，里边包含了7个数组
@property (strong, nonatomic) NSArray *paramArray;// 参数数组，里边包含了7个字典数组
@end

@implementation TSLInformationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCollectionView];
    [self setupTopView];
}

- (void)setupCollectionView
{
    // 1.流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 2.水平滑动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 3.每个cell的尺寸
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    // 4.设置cell之间的水平间距
    layout.minimumInteritemSpacing = 0;
    // 5.设置cell之间的垂直间距
    layout.minimumLineSpacing = 0;
    // CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.collectionView registerClass:[TSLInformationCell class] forCellWithReuseIdentifier:reuseID];
    self.collectionView.pagingEnabled = YES; // 开启分页
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}
- (void)setupTopView
{
    self.topView = [[TSLTopView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, 41)];
    self.topView.titleArray = [NSArray arrayWithObjects:@"政策法规", @"通知公告", @"物流资讯", @"物流会议", @"物流信息化", @"物流自动化", @"物流新技术",nil];
    self.topView.titleWidth = 100;
    self.topView.foregroundColor = TSLColor(28, 128, 243);
    self.topView.delegate = self;
    [self.view addSubview:self.topView];
}

#pragma mark - topViewDelegate
- (void)topView:(TSLTopView *)topView scrollToPage:(NSInteger)page animated:(BOOL)animated
{
    NSIndexPath *indexPath=[NSIndexPath indexPathForItem:page inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:animated];
}

#pragma mark - collectionView数据源方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.infoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TSLInformationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    // 将字典传递到cell，如果分开传递属性可能会导致数据错乱
    cell.infoDict = [NSDictionary dictionaryWithObjectsAndKeys:self.infoArray[indexPath.item], @"infoArray", self.paramArray[indexPath.item], @"param", self.offsetArray[indexPath.item], @"contentOffset", nil];
    return cell;
}

#pragma mark - UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.isDragging) { // 如果正在拖拽
        NSInteger page = roundf(scrollView.contentOffset.x / scrollView.frame.size.width);// 四舍五入
        page = MAX(page, 0); // 最小page为0
        page = MIN(page, self.infoArray.count - 1); // 最大page为button个数-1
        self.topView.page = page;
    }
}

/**
 *  偏移
 */
- (NSArray *)offsetArray
{
    if (_offsetArray == nil) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger index = 0; index < self.paramArray.count; index++) {
            NSValue *offset = [NSValue valueWithCGPoint:CGPointZero];
            [array addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:offset, @"offset", nil]];
        }
        _offsetArray = array;
    }
    return _offsetArray;
}

/**
 *  资讯数组
 */
- (NSArray *)infoArray
{
    if (_infoArray == nil) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger index = 0; index < self.paramArray.count; index++) {
            NSMutableArray *info = [NSMutableArray array];
            [array addObject:info];
        }
        _infoArray = array;
    }
    return _infoArray;
}
/**
 *  Get参数
 */
- (NSArray *)paramArray
{
    if (_paramArray == nil) {
        // NSDictionary所声明的对象再被创建后不能被修改。所以在这里用NSMultableDictionary
        // 方便更改keys值和page值
        NSMutableDictionary *dict0 = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@(2),@"keys":[NSNull null],@"page":[NSNull null], @"level":@(3)}];
        NSMutableDictionary *dict1 = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@(8),@"keys":[NSNull null],@"page":[NSNull null], @"level":@(2)}];
        NSMutableDictionary *dict2 = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@(3),@"keys":[NSNull null],@"page":[NSNull null], @"level":@(1)}];
        NSMutableDictionary *dict3 = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@(4),@"keys":[NSNull null],@"page":[NSNull null], @"level":@(1)}];
        NSMutableDictionary *dict4 = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@(5),@"keys":[NSNull null],@"page":[NSNull null], @"level":@(1)}];
        NSMutableDictionary *dict5 = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@(6),@"keys":[NSNull null],@"page":[NSNull null], @"level":@(1)}];
        NSMutableDictionary *dict6 = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@(7),@"keys":[NSNull null],@"page":[NSNull null], @"level":@(1)}];
        
        _paramArray = [NSArray arrayWithObjects:dict0,dict1,dict2,dict3,dict4,dict5,dict6,nil];
    }
    return _paramArray;
}

@end

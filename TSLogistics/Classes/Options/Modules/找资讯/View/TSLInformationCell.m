//
//  TSLInformationCell.m
//  TSLogistics
//
//  Created by erpapa on 15/11/26.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLInformationCell.h"
#import "TSLInformationTableViewCell.h"
#import "TSLInformationRecommendDetailVC.h"
#import "TSLUtil.h"
#import "MJRefresh.h"

@interface TSLInformationCell()<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *offset;
@property (strong, nonatomic) NSMutableArray *infoArray;
@property (strong, nonatomic) NSMutableDictionary *param;
@end

@implementation TSLInformationCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topViewHeight, self.bounds.size.width, self.bounds.size.height - topViewHeight)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundView = nil;
        self.tableView.backgroundColor = TSLBackgroundColor;
        self.tableView.rowHeight = InformationTableViewCellHeight;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.contentView addSubview:self.tableView];
        [self setupRefresh];
    }
    return self;
}
/**
 *  刷新控件
 */
- (void)setupRefresh
{
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.header = header;
    
    // 上拉刷新
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.refreshingTitleHidden = YES;
    self.tableView.footer = footer;
    
}
- (void)loadNewData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:self.param];
    param[@"page"] = [NSNull null];
    [TSLHttpTool GET:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_Information] parameters:param success:^(id json) {
        NSDictionary *firstDict = [json firstObject];
        TSLInformationInfo *firstInfo = [self.infoArray firstObject];
        if ([[firstDict valueForKey:@"Identifier"] integerValue] != firstInfo.Identifier) {
            [self.infoArray removeAllObjects];
            [self.infoArray addObjectsFromArray:[TSLInformationInfo objectArrayWithKeyValuesArray:json]];
            [self.tableView reloadData];
            self.param[@"page"] = @(1);// 在这里设置page为1
        }
        [self.tableView.header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.header endRefreshing];
    }];
}

- (void)loadMoreData
{
    NSInteger page = [self.param[@"page"] integerValue];
    self.param[@"page"] = @(page + 1);
    [TSLHttpTool GET:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_Information] parameters:self.param success:^(id json) {
        NSArray *array = [TSLInformationInfo objectArrayWithKeyValuesArray:json];
        [self.infoArray addObjectsFromArray:array];
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.footer endRefreshing];
    }];
}

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSLInformationTableViewCell *cell = [TSLInformationTableViewCell cellWithTableView:tableView];
    cell.info = self.infoArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TSLInformationRecommendDetailVC *detailVC = [[TSLInformationRecommendDetailVC alloc] init];
    detailVC.info = self.infoArray[indexPath.item];
    [[[[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers lastObject] navigationController] pushViewController:detailVC animated:YES];
}

#pragma mark -scrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.offset[@"offset"] = [NSValue valueWithCGPoint:scrollView.contentOffset];
    
}

- (void)setInfoDict:(NSDictionary *)infoDict
{
    _infoDict = infoDict;
    _infoArray = [infoDict objectForKey:@"infoArray"];
    _param = [infoDict objectForKey:@"param"];
    _offset = [infoDict objectForKey:@"contentOffset"];
    self.tableView.contentOffset = [_offset[@"offset"] CGPointValue];
    [self.tableView reloadData]; // 如果没有数据，reloadData将清空前一个tableView的数据
    if (_infoArray.count == 0) { // 如果没有数据，联网加载数据
        [self.tableView.header beginRefreshing];
    }
}

@end

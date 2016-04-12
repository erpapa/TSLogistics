//
//  TSLInformationRecommendVC.m
//  TSLogistics
//
//  Created by erpapa on 15/11/17.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLInformationRecommendVC.h"
#import "TSLInformationRecommendDetailVC.h"
#import "TSLRecommendCell.h"

@interface TSLInformationRecommendVC ()
@end

@implementation TSLInformationRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热点关注";
    self.tableView.rowHeight = RecommendCellHeight;
    
}

- (void)loadNewData
{
    // 发起GET请求
    [TSLHttpTool GET:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_RECOMMEND] parameters:nil success:^(id json) {
        NSDictionary *firstDict = [json firstObject];
        TSLRecommendInfo *firstInfo = [self.infoArray firstObject];
        if ([[firstDict valueForKey:@"Identifier"] integerValue] != firstInfo.Identifier) {
            self.infoArray = [TSLRecommendInfo objectArrayWithKeyValuesArray:json];
            [self.tableView reloadData];
            self.page = 1;
        }
        [self.tableView.header endRefreshing];// 停止刷新
    } failure:^(NSError *error) {
        [self.tableView.header endRefreshing];// 停止刷新
    }];
}

- (void)loadMoreData
{
    [super loadMoreData];
    // 发起GET请求
    [TSLHttpTool GET:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_RECOMMEND] parameters:@{@"page":@(self.page)} success:^(id json) {
        NSArray *array = [TSLRecommendInfo objectArrayWithKeyValuesArray:json];
        [self.infoArray addObjectsFromArray:array];
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];// 停止刷新
    } failure:^(NSError *error) {
        [self.tableView.footer endRefreshing];// 停止刷新
    }];
}
#pragma mark - tableView数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSLRecommendCell *cell = [TSLRecommendCell cellWithTableView:tableView];
    cell.info = self.infoArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TSLInformationRecommendDetailVC *vc = [[TSLInformationRecommendDetailVC alloc] init];
    vc.info = self.infoArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

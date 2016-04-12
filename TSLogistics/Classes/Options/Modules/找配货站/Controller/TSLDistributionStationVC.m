//
//  TSLDistributionStationVC.m
//  TSLogistics
//
//  Created by erpapa on 15/12/15.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLDistributionStationVC.h"
#import "TSLDistributionStationDetailVC.h"
#import "TSLDistributionStationCell.h"

@interface TSLDistributionStationVC ()

@end

@implementation TSLDistributionStationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = TSLDistributionStationCellHeight;
    
}

- (void)loadNewData
{
    [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_DistributionStation] parameters:nil success:^(id json) {
        NSDictionary *firstDict = [json firstObject];
        TSLDistributionStationInfo *firstInfo = [self.infoArray firstObject];
        if ([[firstDict valueForKey:@"Identifier"] integerValue] != firstInfo.Identifier) {
            self.infoArray = [TSLDistributionStationInfo objectArrayWithKeyValuesArray:json];
            [self.tableView reloadData];
            self.page = 1;
        }
        [self.tableView.header endRefreshing];// 停止刷新
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"未知错误"];
        [self.tableView.header endRefreshing];// 停止刷新
    }];
}

- (void)loadMoreData
{
    [super loadMoreData];
    [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_DistributionStation] parameters:@{@"page":@(self.page)} success:^(id json) {
        NSArray *array = [TSLDistributionStationInfo objectArrayWithKeyValuesArray:json];
        [self.infoArray addObjectsFromArray:array];
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];// 停止刷新
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"未知错误"];
        [self.tableView.footer endRefreshing];// 停止刷新
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSLDistributionStationCell*cell = [TSLDistributionStationCell cellWithTableView:tableView];
    cell.info = self.infoArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TSLDistributionStationDetailVC *detailVC = [[TSLDistributionStationDetailVC alloc] init];
    detailVC.info = self.infoArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  TSLDistributionCenterVC.m
//  TSLogistics
//
//  Created by erpapa on 15/12/30.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLDistributionCenterVC.h"
#import "TSLDistributionCenterCell.h"
#import "TSLDistributionCenterDetailVC.h"

@interface TSLDistributionCenterVC ()

@end

@implementation TSLDistributionCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = DistributionCenterCellHeight;
}

- (void)loadNewData
{
    TSLUser *user = [TSLUser sharedUser];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (user.Identifier) {
        param[@"collectid"] = @(user.Identifier);
    } else {
        param = nil;
    }
    [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@",TSLAPI_PREFIX, TSLAPI_DistributionCenter] parameters:param success:^(id json) {
        NSDictionary *firstDict = [json firstObject];
        TSLDistributionCenterInfo *firstInfo = [self.infoArray firstObject];
        if ([[firstDict valueForKey:@"Identifier"] integerValue] != firstInfo.Identifier) {
            self.infoArray = [TSLDistributionCenterInfo objectArrayWithKeyValuesArray:json];
            [self.tableView reloadData];
            self.page = 1;
        }
        [self.tableView.header endRefreshing];// 停止刷新
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"未知错误"];
        [self.tableView.header endRefreshing];
    }];
}

- (void)loadMoreData
{
    [super loadMoreData];
    TSLUser *user = [TSLUser sharedUser];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = @(self.page);
    if (user.Identifier) {
        param[@"collectid"] = @(user.Identifier);
    }
    [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@",TSLAPI_PREFIX, TSLAPI_DistributionCenter] parameters:param success:^(id json) {
        NSArray *array = [TSLDistributionCenterInfo objectArrayWithKeyValuesArray:json];
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
    TSLDistributionCenterCell *cell = [TSLDistributionCenterCell cellWithTableView:tableView];
    cell.info = self.infoArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TSLDistributionCenterDetailVC *detailVC = [[TSLDistributionCenterDetailVC alloc] init];
    detailVC.info = self.infoArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

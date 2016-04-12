//
//  TSLMyContactsController.m
//  TSLogistics
//
//  Created by erpapa on 15/11/14.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLMyContactController.h"
#import "TSLMyContactDetailController.h"
#import "TSLContacts.h"
#import "TSLUtil.h"

@interface TSLMyContactController ()
@property (strong, nonatomic) UIActivityIndicatorView *activityView;
@property (strong, nonatomic) NSMutableArray *contacts;
@end

@implementation TSLMyContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 60;
    [self setupActivityView];// 指示器
    [self getCollectionList];// 获取数据
}

- (void)setupActivityView
{
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.center = CGPointMake(self.view.center.x, self.view.center.y - 64);
    self.activityView.color = [UIColor grayColor];
    self.activityView.hidesWhenStopped = YES;
    [self.view insertSubview:self.activityView atIndex:0];
    [self.activityView startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.contacts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TSLContacts *contact = self.contacts[section];
    return contact.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // static修饰局部变量:可以保证局部变量只分配一次存储空间(只初始化一次)
    static NSString *ID = @"contact";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    // 获取model
    TSLContacts *contact = self.contacts[indexPath.section];
    TSLCollectInfo *info = contact.infoArray[indexPath.row];
    // 设置cell的数据
    cell.textLabel.text = info.Compellation;
    cell.detailTextLabel.text = info.Company;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TSLContacts *contact = self.contacts[section];
    return contact.title;
}

/**
 *  返回索引数组
 */
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *array = [NSMutableArray array];
    for(char c = 'A'; c <= 'Z'; c++)
    {
        NSString *str = [NSString stringWithFormat:@"%c",c];
        [array addObject:str];
    }
    return array;
}

/**
 *  索引列点击事件
 *
 *  @return 返回tableView索引
 */
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger section = 0;
    for (NSInteger i = 0; i < self.contacts.count; i++) {
        TSLContacts *contact = [self.contacts objectAtIndex:i];
        if ([contact.title isEqualToString:title]) {
            section = i;
            break;
        }
    }
    return section;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 获取model
    TSLContacts *contact = self.contacts[indexPath.section];
    TSLCollectInfo *info = contact.infoArray[indexPath.row];
    [self performSegueWithIdentifier:@"contact" sender:info];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TSLMyContactDetailController *destVC = [segue destinationViewController];
    destVC.info = sender;
}

/**
 *  联网获得通讯录数据
 */
- (void)getCollectionList
{
    NSDictionary *param = @{@"pageSize":@(100000), @"savetype":@(1), @"userId":@([TSLUser sharedUser].Identifier)};
    [TSLHttpTool GET:[NSString stringWithFormat:@"%@%@",TSLAPI_PREFIX, User_CollectionList] parameters:param success:^(id json) {
        NSArray *infoArray = [TSLCollectInfo objectArrayWithKeyValuesArray:json];
        for (TSLCollectInfo *info in infoArray) {
            [self addConllectInfo:info]; // 将数据添加到模型数组
        }
        [self sortWithContacts]; // 排序
        [self.tableView reloadData];// 刷新
        [self.activityView stopAnimating];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"获取通讯录数据失败"];
    }];
}

/**
 *  将数据添加到数组里边
 */
- (void)addConllectInfo:(TSLCollectInfo *)info
{
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, (__bridge CFStringRef)info.Compellation);
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);// 拼音
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);// 没有音标
    NSString *name = (__bridge NSString *)string;// 姓名拼音
    NSArray *letterArray = [name componentsSeparatedByString:@" "];
    NSString *firstLetterStr = [NSString string];
    for (NSString *str in letterArray) {
        firstLetterStr =[firstLetterStr stringByAppendingString:[[str substringToIndex:1] uppercaseString]];// 截取首字母(并转换为大写)
    }
    info.firstLetterStr = firstLetterStr; // 首字母字符串
    NSString *firstLetter = [firstLetterStr substringToIndex:1];// 截取首字母(并转换为大写)
    NSInteger count = self.contacts.count;
    if (count == 0) {
        TSLContacts *contact = [[TSLContacts alloc] init];
        contact.title = firstLetter;
        [contact.infoArray addObject:info];
        [self.contacts addObject:contact];
    } else {
        for (NSInteger index = 0; index < count; index++) {
            TSLContacts *contact = [self.contacts objectAtIndex:index];
            if ([contact.title isEqualToString:firstLetter]) {// 如果title相同，添加到该组
                [contact.infoArray addObject:info];
                break;// 跳出循环
            }
            if (index == count - 1) {
                TSLContacts *con = [[TSLContacts alloc] init];
                con.title = firstLetter;
                [con.infoArray addObject:info];
                [self.contacts addObject:con];
            }
        }
    }
}
/**
 *  数组排序
 */
- (void)sortWithContacts
{
    // 1.首字母排序
    NSArray *array = [self.contacts sortedArrayUsingComparator:^NSComparisonResult(TSLContacts *obj1, TSLContacts *obj2) {
        return [obj1.title compare:obj2.title];
    }];
    // 2.数组内排序
    for (TSLContacts *contact in array) {
        NSArray *infoArray = [contact.infoArray sortedArrayUsingComparator:^NSComparisonResult(TSLCollectInfo *obj1, TSLCollectInfo *obj2) {
            return [obj1.firstLetterStr compare:obj2.firstLetterStr];
        }];
        contact.infoArray = [NSMutableArray arrayWithArray:infoArray];
    }
    self.contacts = [NSMutableArray arrayWithArray:array];
}

- (NSMutableArray *)contacts
{
    if (_contacts == nil) {
        _contacts = [NSMutableArray array];
    }
    return _contacts;
}
@end

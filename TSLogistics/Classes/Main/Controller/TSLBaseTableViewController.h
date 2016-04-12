//
//  TSLBaseTableViewController.h
//  TSLogistics
//
//  Created by erpapa on 15/11/17.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//
/*
 继承的使用注意
 
 （1）编译器从上往下执行，所以在子类前面至少应该要有父类的声明；
 
 （2）OC中不允许子类和父类拥有相同名称的成员变量名；
 
 （3）OC中的子类可以拥有和父类相同名称的方法，在子类调用时，优先去自己的内部寻找，如果没有则一层一层的往上找；
 
 提示：重写即子类重新实现了父类中的某个方法，覆盖了父类以前的实现。
 */
#import <UIKit/UIKit.h>
#import "TSLUtil.h"
#import "MJRefresh.h"

@interface TSLBaseTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *infoArray;
@property (assign, nonatomic) NSInteger page;
/**
 *  下拉刷新
 */
- (void)loadNewData;
/**
 *  上拉刷新
 */
- (void)loadMoreData;
/**
 *  搜索
 */
- (void)search;
@end

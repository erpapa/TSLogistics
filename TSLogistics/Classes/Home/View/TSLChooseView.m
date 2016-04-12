//
//  TSLChooseView.m
//  TSLogistics
//
//  Created by erpapa on 15/11/29.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLChooseView.h"
#import "TSLChooseViewCell.h"
#import "TSLTool.h"

@interface TSLChooseView()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *chooseButton;
@property (strong, nonatomic) NSArray *typeArray;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *imageArray;
@end

@implementation TSLChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContentView];
        self.typeArray = @[@(8),@(9),@(3),@(6),@(10),@(2),@(11),@(4),@(25),@(0)];
        self.titleArray = @[@"货源",@"车源",@"库源",@"园区",@"专线",@"配货站点",@"配送中心",@"快递网点",@"末端网点",@"全部类型"];
        self.imageArray = @[@"hy_03",@"cy_03",@"ky_03",@"yq_03",@"zx_03",@"ph_03",@"ps_03",@"kd_03",@"md_03",@"qb_03"];
    }
    return self;
}

- (void)setupContentView
{
    // 1.tableview
    self.tableView = [[UITableView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // 2.chooseButton
    self.chooseButton = [[UIButton alloc] init];
    [self.chooseButton setImage:[UIImage imageNamed:@"chooseUp"] forState:UIControlStateNormal];
    [self.chooseButton setImage:[UIImage imageNamed:@"chooseDown"] forState:UIControlStateSelected];
    [self.chooseButton addTarget:self action:@selector(chooseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.chooseButton];
    [self addSubview:self.tableView];
    
    // 3.添加轻扫手势
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)];
    recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:recognizer];
    
}

#pragma mark - datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.typeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSLChooseViewCell *cell = [TSLChooseViewCell cellWithTableView:tableView];
    cell.icon = self.imageArray[indexPath.row];
    cell.text = self.titleArray[indexPath.row];
    cell.showLine = indexPath.row == (self.typeArray.count - 1) ? YES:NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(chooseView:didSelectedRowWithType:)]) {
        NSInteger type = [self.typeArray[indexPath.row] integerValue];
        [self.delegate chooseView:self didSelectedRowWithType:type];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.typeArray.count - 1) {
        return TSLChooseViewCellHeight;
    }
    return TSLChooseViewCellHeight + 2;
}

/**
 *  点击选中按钮
 */
- (void)chooseButtonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [UIView animateWithDuration:0.35f animations:^{
            self.transform = CGAffineTransformMakeTranslation(self.bounds.size.width , 0);
        }];
    } else {
        [self goBack];
    }
}
/**
 *  回去
 */
- (void)goBack
{
    self.chooseButton.selected = NO;
    [UIView animateWithDuration:0.35f animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.typeArray.count - 1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    self.chooseButton.frame = CGRectMake(self.bounds.size.width, self.bounds.size.height * 0.5 - 30, 30, 61);
}
/**
 *  拦截响应
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (CGRectContainsPoint(self.chooseButton.frame, point)) {
        return YES;
    }
    return [super pointInside:point withEvent:event];
}

@end

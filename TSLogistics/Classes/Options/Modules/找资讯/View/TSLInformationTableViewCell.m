//
//  TSLInformationTableViewCell.m
//  TSLogistics
//
//  Created by erpapa on 15/11/26.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLInformationTableViewCell.h"
#import <CoreText/CoreText.h>
#define labelHeight 25

@interface TSLInformationTableViewCell()
@property (strong, nonatomic) UIButton *titleButton;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UIView *line;
@end

@implementation TSLInformationTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // static修饰局部变量:可以保证局部变量只分配一次存储空间(只初始化一次)
    static NSString *ID = @"InformationTableViewCell";
    // 1.通过一个标识去缓存池中寻找可循环利用的cell
    TSLInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果没有可循环利用的cell
    if (cell == nil){
        cell = [[TSLInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleButton = [[UIButton alloc] init];
        [self.titleButton setImage:[UIImage imageNamed:@"dian"] forState:UIControlStateNormal];
        [self.titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        self.titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.titleButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;// 超出显示省略号
        self.titleButton.userInteractionEnabled = NO;
        [self.contentView addSubview:self.titleButton];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:16];
        self.contentLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.contentLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.numberOfLines = 0;
        self.timeLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.timeLabel];
    }
    return self;
}

- (void)setInfo:(TSLInformationInfo *)info
{
    _info = info;
    [self.titleButton setTitle:info.NameCHN forState:UIControlStateNormal];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 20, labelHeight * 2)];
    label.font = [UIFont systemFontOfSize:16];
    label.text = info.ContentString;
    NSArray *textArray = [self getSeparatedLinesFromLabel:label];
    NSString *text = [textArray firstObject];// 得到第一行文字
    if (textArray.count > 1) {
        NSString *line2 = [textArray objectAtIndex:1];
        line2 = [[line2 substringToIndex:line2.length * 0.6] stringByAppendingString:@"..."];// 第二行文字取一部分然后拼接...
        text = [text stringByAppendingString:line2];
    }
    self.contentLabel.text = text;
    self.timeLabel.text = [NSString stringWithFormat:@"\n%@", info.ReleaseTime];
}

- (void)layoutSubviews
{
    CGFloat x = 10;
    CGFloat y = 10;
    self.titleButton.frame = CGRectMake(x, y, ScreenW - x * 2, labelHeight);
    self.contentLabel.frame = CGRectMake(x, CGRectGetMaxY(self.titleButton.frame), ScreenW - x * 2, labelHeight * 2);
    self.timeLabel.frame = CGRectMake(ScreenW - 88 - x, CGRectGetMaxY(self.titleButton.frame), 88, labelHeight * 2);
    // cell高度 ：10 + 25 + 50 + 10 + 3 (3是cell之间的间隔)
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 3;
    [super setFrame:frame];
}

/**
 *  获得label各行的文字
 */
- (NSArray *)getSeparatedLinesFromLabel:(UILabel *)label
{
    NSString *text = [label text];
    UIFont   *font = [label font];
    CGRect    rect = [label frame];
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return (NSArray *)linesArray;
}
@end

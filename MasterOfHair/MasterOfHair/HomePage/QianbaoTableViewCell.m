//
//  QianbaoTableViewCell.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/30.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "QianbaoTableViewCell.h"

@implementation QianbaoTableViewCell

- (instancetype )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.month = [[UILabel alloc] init];
    self.month.font = [UIFont systemFontOfSize:13];
    self.month.text = @"今天";
//    self.month.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.month];
    
    self.time = [[UILabel alloc] init];
    self.time.font = [UIFont systemFontOfSize:13];
    self.time.text = @"10:10";
    [self.contentView addSubview:self.time];
    
    self.money = [[UILabel alloc] init];
    self.money.font = [UIFont systemFontOfSize:15];
    self.money.textColor = [UIColor orangeColor];
    self.money.text = @"¥ 100.00";
//    self.money.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.money];
    
    self.type = [[UILabel alloc] init];
    self.type.font = [UIFont systemFontOfSize:15];
    self.type.textAlignment = NSTextAlignmentRight;
    self.type.text = @"处理中";
    [self.contentView addSubview:self.type];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.month.frame = CGRectMake(15, 10, 60, 15);
    
    self.time.frame = CGRectMake(15, 25, 60, 15);
    
    self.money.frame = CGRectMake(CGRectGetMaxX(self.month.frame) , 15, SCREEN_WIDTH - CGRectGetMaxX(self.month.frame) - 80, 20);
    
    self.type.frame = CGRectMake(SCREEN_WIDTH - 15 - 55, 15, 55, 20);
}







@end

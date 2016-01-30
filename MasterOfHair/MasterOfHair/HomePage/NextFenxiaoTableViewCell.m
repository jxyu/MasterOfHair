//
//  NextFenxiaoTableViewCell.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/29.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "NextFenxiaoTableViewCell.h"

@interface NextFenxiaoTableViewCell ()

@property (nonatomic, strong) UIImageView * view_bg;

@property (nonatomic, strong) UILabel * label_1;
@property (nonatomic, strong) UILabel * label_2;
@property (nonatomic, strong) UILabel * label_3;
@end

@implementation NextFenxiaoTableViewCell

- (instancetype )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.view_bg = [[UIImageView alloc] init];
    self.view_bg.image = [UIImage imageNamed:@"gary_bg"];
    [self.contentView addSubview:self.view_bg];
    
    self.image = [[UIImageView alloc] init];
    self.image.layer.masksToBounds = YES;
    self.image.layer.cornerRadius = 40;
    self.image.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.image];
    
    
    self.label_1 = [[UILabel alloc] init];
    self.label_1.text = @"账号:";
//    self.label_1.backgroundColor = [UIColor orangeColor];
    self.label_1.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.label_1];
    
    self.account = [[UILabel alloc] init];
    self.account.text = @"10000000000";
    self.account.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.account];
    
    
    self.label_2 = [[UILabel alloc] init];
    self.label_2.text = @"订单数量:";
    self.label_2.font = [UIFont systemFontOfSize:11];
    self.label_2.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.label_2];
    
    self.number = [[UILabel alloc] init];
    self.number.text = @"100单";
    self.number.font = [UIFont systemFontOfSize:11];
    self.number.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.number];
    
    
    self.label_3 = [[UILabel alloc] init];
    self.label_3.text = @"提成金额:";
    self.label_3.font = [UIFont systemFontOfSize:11];
    self.label_3.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.label_3];
    
    self.price = [[UILabel alloc] init];
    self.price.text = @"¥ 1000.00";
    self.price.font = [UIFont systemFontOfSize:11];
    self.price.textColor = [UIColor orangeColor];
    [self.contentView addSubview:self.price];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.view_bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
    
    self.image.frame = CGRectMake(15, 20, 80, 80);
    
    self.label_1.frame = CGRectMake(CGRectGetMaxX(self.image.frame) + 10, CGRectGetMinY(self.image.frame), 40, 25);
    
    self.account.frame = CGRectMake(CGRectGetMaxX(self.label_1.frame) + 5, CGRectGetMinY(self.label_1.frame), SCREEN_WIDTH - CGRectGetMaxX(self.label_1.frame) - 20, 25);
    
    self.label_2.frame = CGRectMake(CGRectGetMinX(self.label_1.frame), CGRectGetMaxY(self.label_1.frame) + 10, 50, 20);
    
    self.number.frame = CGRectMake(CGRectGetMaxX(self.label_2.frame) + 5, CGRectGetMinY(self.label_2.frame), SCREEN_WIDTH - CGRectGetMaxX(self.label_2.frame) - 20, 20);
    
    self.label_3.frame = CGRectMake(CGRectGetMinX(self.label_2.frame), CGRectGetMaxY(self.label_2.frame), 50, 20);
    
    self.price.frame = CGRectMake(CGRectGetMaxX(self.label_3.frame) + 5, CGRectGetMinY(self.label_3.frame), SCREEN_WIDTH - CGRectGetMaxX(self.label_3.frame) - 20, 20);
}




@end

//
//  WenxiulanmengdingdanTableViewCell.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/3/16.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "WenxiulanmengdingdanTableViewCell.h"

@interface WenxiulanmengdingdanTableViewCell ()

@property (nonatomic, strong) UIView * view_bg;

@property (nonatomic, strong) UIImageView * image_dian;

@property (nonatomic, strong) UIView * line;

@property (nonatomic, strong) UIView * lind2;

@end

@implementation WenxiulanmengdingdanTableViewCell

- (instancetype )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        [self p_setupView];
    }
    
    return self;
}

- (void )p_setupView
{
    self.view_bg = [[UIView alloc] init];
    self.view_bg.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:1];
    [self.contentView addSubview:self.view_bg];
    
    self.number = [[UILabel alloc] init];
    self.number.font = [UIFont systemFontOfSize:15];
    self.number.textAlignment = NSTextAlignmentLeft;
    self.number.text = @"订单编号:11111111111111";
    [self.view_bg addSubview:self.number];
    
    self.date = [[UILabel alloc] init];
    self.date.font = [UIFont systemFontOfSize:15];
    self.date.textAlignment = NSTextAlignmentRight;
    self.date.textColor = [UIColor grayColor];
    self.date.text = @"2012-22-22";
    [self.view_bg addSubview:self.date];
    
    //
    self.image_dian = [[UIImageView alloc] init];
    self.image_dian.image = [UIImage imageNamed:@"01dian_07"];
    [self.contentView addSubview:self.image_dian];
    
    //
    self.name = [[UILabel alloc] init];
    self.name.text = @"很大声的解释道";
    self.name.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.name];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:self.line];
    
    
    self.taocan_name = [[UILabel alloc] init];
    self.taocan_name.font = [UIFont systemFontOfSize:15];
    self.taocan_name.textAlignment = NSTextAlignmentLeft;
    self.taocan_name.text = @"订单编号";
    self.taocan_name.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.taocan_name];
    
    
    self.teacher_name = [[UILabel alloc] init];
    self.teacher_name.font = [UIFont systemFontOfSize:15];
    self.teacher_name.textAlignment = NSTextAlignmentLeft;
    self.teacher_name.text = @"技师:wolaji";
    self.teacher_name.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.teacher_name];
    
    
    self.price = [[UILabel alloc] init];
    self.price.font = [UIFont systemFontOfSize:15];
    self.price.textAlignment = NSTextAlignmentRight;
    self.price.textColor = [UIColor grayColor];
    self.price.text = @"￥ 200";
    [self.view_bg addSubview:self.price];
    
    
    self.sell = [[UILabel alloc] init];
    self.sell.font = [UIFont systemFontOfSize:15];
    self.sell.textAlignment = NSTextAlignmentRight;
    self.sell.textColor = [UIColor orangeColor];
    self.sell.text = @"实际支付：￥ 200";
    [self.view_bg addSubview:self.sell];
    
    self.lind2 = [[UIView alloc] init];
    
    self.lind2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view_bg addSubview:self.lind2];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.view_bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    
    self.number.frame = CGRectMake(10, 5, (SCREEN_WIDTH - 25) / 3 * 2, 30);
    
    self.date.frame = CGRectMake(CGRectGetMaxX(self.number.frame) + 5, 5, (SCREEN_WIDTH - 25) / 3, 30);
    
    self.image_dian.frame = CGRectMake(10, CGRectGetMaxY(self.view_bg.frame) + 5, 20, 20);
    
    self.name.frame = CGRectMake(CGRectGetMaxX(self.image_dian.frame) + 10, CGRectGetMaxY(self.view_bg.frame) + 5, SCREEN_WIDTH - CGRectGetMaxX(self.image_dian.frame) - 20, 20);
    
    self.line.frame = CGRectMake(0, CGRectGetMaxY(self.image_dian.frame) + 5, SCREEN_WIDTH, 1);
    
    self.taocan_name.frame = CGRectMake(10, CGRectGetMaxY(self.line.frame) + 5, (SCREEN_WIDTH - 25) / 3 * 2, 25);

    self.price.frame = CGRectMake(CGRectGetMaxX(self.taocan_name.frame) + 5, CGRectGetMaxY(self.line.frame) + 5, (SCREEN_WIDTH - 25) / 3, 30);

    self.teacher_name.frame = CGRectMake(10, CGRectGetMaxY(self.taocan_name.frame) + 5, (SCREEN_WIDTH - 25) / 3, 25);

    self.sell.frame = CGRectMake(CGRectGetMaxX(self.teacher_name.frame) + 5, CGRectGetMaxY(self.taocan_name.frame) + 5, (SCREEN_WIDTH - 25) / 3 * 2, 30);

    self.lind2.frame = CGRectMake(0, CGRectGetMaxY(self.teacher_name.frame) + 5, SCREEN_WIDTH, 10);

}














@end

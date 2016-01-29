//
//  FenxiaozhongxinTableViewCell.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/29.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "FenxiaozhongxinTableViewCell.h"

@implementation FenxiaozhongxinTableViewCell

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
    self.image = [[UIImageView alloc] init];
//    self.image.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.image];
    
    self.name = [[UILabel alloc] init];
    self.name.text = @"好好好好好好好好好好";
//    self.name.backgroundColor = [UIColor orangeColor];
    self.name.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.name];
    
    self.image_icon = [[UIImageView alloc] init];
    self.image_icon.image = [UIImage imageNamed:@"iconfont-fanhuiyou"];
    [self.contentView addSubview:self.image_icon];
    
    self.number = [[UILabel alloc] init];
    self.number.font = [UIFont systemFontOfSize:15];
    self.number.textColor = [UIColor orangeColor];
    self.number.textAlignment = NSTextAlignmentRight;
//    self.number.backgroundColor = [UIColor orangeColor];
    self.number.text = @"10人";
    [self.contentView addSubview:self.number];
    
    
    self.price = [[UILabel alloc] init];
    self.price.font = [UIFont systemFontOfSize:15];
    self.price.textColor = [UIColor orangeColor];
    self.price.textAlignment = NSTextAlignmentRight;
    self.price.text = @"¥ 1999";
    [self.contentView addSubview:self.price];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.image.frame = CGRectMake(15, 10, 30, 30);
    
    self.name.frame = CGRectMake(CGRectGetMaxX(self.image.frame) + 10, 10, 150, 30);
    self.image_icon.frame = CGRectMake(SCREEN_WIDTH - 5 - 15, 17.5, 15, 15);
    
    self.number.frame = CGRectMake(SCREEN_WIDTH - 20 - 5 - 70, 10, 70, 30);
    
    self.price.frame = CGRectMake(SCREEN_WIDTH - 13 - 75, 10, 75, 30);
}





@end

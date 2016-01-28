//
//  JCMineTableViewCell.m
//  xitoujiang1_geren
//
//  Created by 鞠超 on 16/1/19.
//  Copyright © 2016年 JC. All rights reserved.
//

#import "JCMineTableViewCell.h"

@interface JCMineTableViewCell ()

@end

@implementation JCMineTableViewCell

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
    self.name.text = @"拉萨了带上来看到了";
//    self.name.backgroundColor = [UIColor orangeColor];
    self.name.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.name];
    
    self.arrows = [[UIImageView alloc] init];
    self.arrows.image = [UIImage imageNamed:@"iconfont-fanhuiyou"];
    [self.contentView addSubview:self.arrows];
    
    self.arrows_switch = [[UISwitch alloc] init];
//    [self.contentView addSubview:self.arrows_switch];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.image.frame = CGRectMake(15, 10, 30, 30);
    
    self.name.frame = CGRectMake(CGRectGetMaxX(self.image.frame) + 15, 10, self.contentView.frame.size.width - CGRectGetMaxX(self.image.frame) - 15 - 3 - 60, 30);
    
    self.arrows.frame = CGRectMake(self.contentView.frame.size.width - 33, 12.5, 25, 25);
    
    self.arrows_switch.frame = CGRectMake(self.contentView.frame.size.width - 7 - 50, 10, 50, 30);
}










@end

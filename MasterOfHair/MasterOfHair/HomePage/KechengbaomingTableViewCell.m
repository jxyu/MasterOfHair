
//
//  KechengbaomingTableViewCell.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/28.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "KechengbaomingTableViewCell.h"

@interface KechengbaomingTableViewCell ()

@property (nonatomic, strong) UIImageView * image_icon;

@property (nonatomic, strong) UIView * view_bg;

@end


@implementation KechengbaomingTableViewCell

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
    self.image.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.image];
    
    self.name = [[UILabel alloc] init];
    self.name.text = @"查看详情 报名";
    self.name.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.name];
    
    self.image_icon = [[UIImageView alloc] init];
    self.image_icon.image = [UIImage imageNamed:@"01fanhui_07"];
    [self.contentView addSubview:self.image_icon];
    
    
    self.view_bg = [[UIView alloc] init];
    self.view_bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:self.view_bg];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.image.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    
    self.name.frame = CGRectMake(50, CGRectGetMaxY(self.image.frame) + 13, SCREEN_WIDTH - 100, 30);
    
    self.image_icon.frame = CGRectMake(SCREEN_WIDTH - 10 - 30, CGRectGetMaxY(self.image.frame) + 13, 30, 30);
    
    self.view_bg.frame = CGRectMake(0, 250, SCREEN_WIDTH, 10);
}



@end


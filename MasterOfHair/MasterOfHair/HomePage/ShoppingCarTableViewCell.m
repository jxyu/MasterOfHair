//
//  ShoppingCarTableViewCell.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/23.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "ShoppingCarTableViewCell.h"

@interface ShoppingCarTableViewCell ()

@property (nonatomic, strong) UIImageView * bg_image;

@property (nonatomic, strong) UIImageView * white_view;

@property (nonatomic, strong) UILabel * label_X;

@end

@implementation ShoppingCarTableViewCell

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
    
    self.bg_image = [[UIImageView alloc] init];
    self.bg_image.image = [UIImage imageNamed:@"gary_bg"];
    [self.contentView addSubview:self.bg_image];
    
    self.btn_select = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    self.btn_select.backgroundColor = [UIColor orangeColor];
    [self.btn_select setImage:[UIImage imageNamed:@"iconfont-iconquanxuan"] forState:(UIControlStateNormal)];
    [self.btn_select setImageEdgeInsets:UIEdgeInsetsMake(55, 7.5, 55, 7.5)];
    [self.contentView addSubview:self.btn_select];
    
    //背景底
    self.white_view = [[UIImageView alloc] init];
    self.white_view.image = [UIImage imageNamed:@"white_bg"];
    self.white_view.layer.cornerRadius = 5;
    self.white_view.layer.masksToBounds = YES;
    [self.contentView addSubview:self.white_view];
    
    
    self.image = [[UIImageView alloc] init];
    self.image.backgroundColor = [UIColor orangeColor];
    [self.white_view addSubview:self.image];
    
    
    self.title = [[UILabel alloc] init];
    self.title.text = @"VS沙宣 修护水养洗发水/露";
    self.title.font = [UIFont systemFontOfSize:14];
    self.title.numberOfLines = 2;
//    self.title.backgroundColor = [UIColor orangeColor];
    [self.white_view addSubview:self.title];
    
    
    self.detail = [[UILabel alloc] init];
    self.detail.text = @"VS沙宣 修护水养洗发水/露 VS沙宣 修护水养洗发水/露";
    self.detail.font = [UIFont systemFontOfSize:11];
    self.detail.numberOfLines = 2;
//    self.detail.backgroundColor = [UIColor orangeColor];
    [self.white_view addSubview:self.detail];
    
    
    self.price = [[UILabel alloc] init];
    self.price.text = @"¥2000.00";
    self.price.textAlignment = NSTextAlignmentCenter;
    self.price.font = [UIFont systemFontOfSize:12];
//    self.price.backgroundColor = [UIColor cyanColor];
    self.price.textColor = [UIColor orangeColor];
    [self.white_view addSubview:self.price];
    
    
    self.label_X = [[UILabel alloc] init];
    self.label_X.text = @"X";
    self.label_X.font = [UIFont systemFontOfSize:9];
    [self.white_view addSubview:self.label_X];
    
    
    self.btn_Subtract = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_Subtract.backgroundColor = [UIColor orangeColor];
//    [self.btn_Subtract setTitle:@"-" forState:(UIControlStateNormal)];
//    [self.btn_Subtract setTintColor:[UIColor grayColor]];
//    self.btn_Subtract.titleLabel.font = [UIFont systemFontOfSize:35];
//    self.btn_Subtract.layer.borderWidth = 1;
//    self.btn_Subtract.layer.borderColor = [UIColor grayColor].CGColor;
    [self.white_view addSubview:self.btn_Subtract];
    
    
    self.number = [[UILabel alloc] init];
    self.number.text = @"11";
    self.number.textAlignment = NSTextAlignmentCenter;
//    self.number.backgroundColor = [UIColor blackColor];
    self.number.font = [UIFont systemFontOfSize:15];
    [self.white_view addSubview:self.number];
    
    
    self.btn_Add = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_Add.backgroundColor = [UIColor orangeColor];
    [self.white_view addSubview:self.btn_Add];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bg_image.frame = self.contentView.frame;
    
    self.btn_select.frame = CGRectMake(0, 10, 35, 130);
    
    self.white_view.frame = CGRectMake(CGRectGetMaxX(self.btn_select.frame), 10, SCREEN_WIDTH - CGRectGetMaxX(self.btn_select.frame) - 10, 130);
    
    self.image.frame = CGRectMake(10, 10, 110, 110);
    
    self.title.frame = CGRectMake(CGRectGetMaxX(self.image.frame) + 10, 10, self.white_view.frame.size.width - 20 - CGRectGetMaxX(self.image.frame), 35);
    
    self.detail.frame = CGRectMake(CGRectGetMinX(self.title.frame), CGRectGetMaxY(self.title.frame) + 5, CGRectGetWidth(self.title.frame), 30);
    
    self.price.frame = CGRectMake(CGRectGetMinX(self.title.frame) - 10, CGRectGetMaxY(self.detail.frame) + 8, 70, 30);
    
    self.label_X.frame = CGRectMake(CGRectGetMaxX(self.price.frame) + 1, CGRectGetMaxY(self.detail.frame) + 8.5, 10, 30);
    
    
    self.btn_Subtract.frame = CGRectMake(CGRectGetMaxX(self.label_X.frame) + 1, CGRectGetMaxY(self.detail.frame) + 10, 25, 25);
    
    self.number.frame = CGRectMake(CGRectGetMaxX(self.btn_Subtract.frame), CGRectGetMinY(self.btn_Subtract.frame), 25, 25);
    
    self.btn_Add.frame = CGRectMake(CGRectGetMaxX(self.number.frame), CGRectGetMinY(self.btn_Subtract.frame), 25, 25);
    
}




@end

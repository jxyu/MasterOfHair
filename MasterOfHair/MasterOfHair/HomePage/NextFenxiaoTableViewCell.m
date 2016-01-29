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
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.view_bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
    
    self.image.frame = CGRectMake(15, 20, 80, 80);
}




@end

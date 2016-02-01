
//
//  wenxiuPeopleTableViewCell.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/25.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "wenxiuPeopleTableViewCell.h"

@interface wenxiuPeopleTableViewCell ()

@property (nonatomic, strong) UIImageView * white_bg;

@property (nonatomic, strong) UIImageView * image_iocn;
@end

@implementation wenxiuPeopleTableViewCell

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
    self.white_bg = [[UIImageView alloc] init];
    self.white_bg.backgroundColor = [UIColor whiteColor];
    self.white_bg.image = [UIImage imageNamed:@"white_bg"];
    [self.contentView addSubview:self.white_bg];
    
    self.image = [[UIImageView alloc] init];
//    self.image.backgroundColor = [UIColor orangeColor];
    self.image.layer.masksToBounds = YES;
    [self.white_bg addSubview:self.image];
    
    self.name = [[UILabel alloc] init];
    self.name.text = @"知名美发师";
    self.name.font = [UIFont systemFontOfSize:20];
//    self.name.backgroundColor = [UIColor orangeColor];
    [self.white_bg addSubview:self.name];
    
    
    self.detail = [[UILabel alloc] init];
    self.detail.text = @"知名美发师 知名美发师 知名美发师 知名美发师";
    self.detail.font = [UIFont systemFontOfSize:13];
//    self.detail.backgroundColor = [UIColor orangeColor];
    self.detail.numberOfLines = 2;
    [self.white_bg addSubview:self.detail];
    
    
    self.image_iocn = [[UIImageView alloc] init];
    self.image_iocn.image = [UIImage imageNamed:@"iconfont-fanhuiyou"];
//    self.image_iocn.backgroundColor = [UIColor orangeColor];
    [self.white_bg addSubview:self.image_iocn];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.white_bg.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, 90);
    
    self.image.frame = CGRectMake(0, 0, 90, 90);
    
    self.name.frame = CGRectMake(CGRectGetMaxX(self.image.frame) + 10, 15, self.white_bg.frame.size.width - CGRectGetMaxX(self.image.frame) - 15 - 40, 25);
    
    self.detail.frame = CGRectMake(CGRectGetMinX(self.name.frame), CGRectGetMaxY(self.name.frame) + 5, CGRectGetWidth(self.name.frame), 40);
    
    self.image_iocn.frame = CGRectMake(self.white_bg.frame.size.width - 25, 40, 20, 20);
    
}





@end

//
//  wenxiuFactoryTableViewCell.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/25.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "wenxiuFactoryTableViewCell.h"

@implementation wenxiuFactoryTableViewCell


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
    self.image.layer.masksToBounds = YES;
    self.image.layer.cornerRadius = 40;
    [self.contentView addSubview:self.image];
    
    
    
    self.image_pic = [[UIImageView alloc] init];
    self.image_pic.layer.masksToBounds = YES;
    self.image_pic.image = [UIImage imageNamed:@"wenxiaodian"];
//    [self.contentView addSubview:self.image_pic];
    
    
    self.name = [[UILabel alloc] init];
    
    self.name.textAlignment = NSTextAlignmentLeft;
    self.name.font = [UIFont systemFontOfSize:17];
    self.name.textColor = [UIColor blackColor];
    self.name.text = @"时间的快速健康的精神科";
    [self.contentView addSubview:self.name];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame=CGRectMake(10, 10, SCREEN_WIDTH-20, 100);
    self.image.frame = CGRectMake(10, 10, 80, 80);
    
    self.image_pic.frame = CGRectMake(100, 30, SCREEN_WIDTH - 110, 40);
    
    self.name.frame = self.image_pic.frame;
}




@end

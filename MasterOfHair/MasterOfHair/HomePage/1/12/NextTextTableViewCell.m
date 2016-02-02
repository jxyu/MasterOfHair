
//
//  NextTextTableViewCell.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/2.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "NextTextTableViewCell.h"

@implementation NextTextTableViewCell

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
    self.image.layer.cornerRadius = 25;
    self.image.layer.masksToBounds = YES;
    [self.contentView addSubview:self.image];
    
    
    self.name = [[UILabel alloc] init];
    self.name.textColor = [UIColor grayColor];
    self.name.text = @"哈哈和还好";
//    self.name.backgroundColor = [UIColor orangeColor];
    self.name.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.name];
    
    
    self.time = [[UILabel alloc] init];
    self.time.textColor = [UIColor grayColor];
    self.time.text = @"2016-03-01 22:20:11";
    //    self.time.backgroundColor = [UIColor orangeColor];
    self.time.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.time];
    
    
    self.detail = [[UILabel alloc] init];
    self.detail.font = [UIFont systemFontOfSize:14];
    self.detail.text = @"手机打开手机的空间设计的款式简单款式简单款就是看的就是空间打开手机看的就是宽带接口设计的";
    self.detail.numberOfLines = 0;
    [self.contentView addSubview:self.detail];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.image.frame = CGRectMake(80, 10, 50, 50);
    
    self.name.frame = CGRectMake(CGRectGetMaxX(self.image.frame) + 10, CGRectGetMinY(self.image.frame) + 5, SCREEN_WIDTH - 15 - CGRectGetMaxX(self.image.frame) - 10, 20);
    
    self.time.frame = CGRectMake(CGRectGetMaxX(self.image.frame) + 10, CGRectGetMaxY(self.name.frame) + 5, SCREEN_WIDTH - 15 - CGRectGetMaxX(self.image.frame) - 10, 20);
    
    self.detail.frame = CGRectMake(CGRectGetMaxX(self.image.frame) + 10, CGRectGetMaxY(self.image.frame) + 5, SCREEN_WIDTH - CGRectGetMaxX(self.image.frame) - 20, self.contentView.frame.size.height - CGRectGetMaxY(self.image.frame) - 15);

}


@end

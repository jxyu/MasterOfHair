
//
//  shouhudizhiTableViewCell.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/26.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "shouhudizhiTableViewCell.h"

@implementation shouhudizhiTableViewCell

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
    self.name = [[UILabel alloc] init];
    self.name.text = @"哈啊哈";
    self.name.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:self.name];
    
    
    self.tel = [[UILabel alloc] init];
    self.tel.text = @"1888888888888";
    self.tel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.tel];
    
    
    self.moren = [[UILabel alloc] init];
    self.moren.text = @"[默认]";
//    self.moren.backgroundColor = [UIColor orangeColor];
    self.moren.font = [UIFont systemFontOfSize:13];
//    [self.contentView addSubview:self.moren];
    
    self.address = [[UILabel alloc] init];
    self.address.text = @"山东省临沂市山东省临沂市山东省临沂市山东省临沂市";
    self.address.font = [UIFont systemFontOfSize:14];
    self.address.numberOfLines = 2;
//    self.address.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.address];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat length_x = (self.contentView.frame.size.width - 50) / 2;
    
    self.name.frame = CGRectMake(20, 10, length_x, 25);
    
    self.tel.frame = CGRectMake(CGRectGetMaxX(self.name.frame) + 10, 10, length_x, 25);
    
    self.moren.frame = CGRectMake(20, CGRectGetMaxY(self.name.frame) + 15, 40, 17);
    
    self.address.frame = CGRectMake(20, CGRectGetMaxY(self.name.frame) + 15, SCREEN_WIDTH - 40, 34);

}


@end

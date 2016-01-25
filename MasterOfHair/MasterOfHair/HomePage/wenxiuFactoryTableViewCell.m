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
    self.image.backgroundColor = [UIColor orangeColor];
    self.image.layer.cornerRadius = 10;
    [self.contentView addSubview:self.image];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.image.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, 180);
}




@end

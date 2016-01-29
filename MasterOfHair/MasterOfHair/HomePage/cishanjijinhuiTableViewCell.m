//
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/29.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "cishanjijinhuiTableViewCell.h"

@implementation cishanjijinhuiTableViewCell

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
    
    self.date = [[UILabel alloc] init];
    self.date.text = @"2015-11-23";
    self.date.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.date];
    
    
    self.detail = [[UILabel alloc] init];
    self.detail.text = @"买东西买东西买东西买东西";
    self.detail.font = [UIFont systemFontOfSize:11];
    self.detail.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.detail];
    
    
    self.price = [[UILabel alloc] init];
    self.price.text = @"¥ 300";
    self.price.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.price];
    
    
    self.finish = [[UILabel alloc] init];
    self.finish.text = @"已完成";
    self.finish.textAlignment = NSTextAlignmentRight;
    self.finish.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.finish];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.date.frame = CGRectMake(10, 5, SCREEN_WIDTH - 30, 15);
    
    self.detail.frame = CGRectMake(10, CGRectGetMaxY(self.date.frame) + 3, SCREEN_WIDTH - 30, 15);
    
    self.price.frame = CGRectMake(10, CGRectGetMaxY(self.detail.frame) + 5, (SCREEN_WIDTH - 20) / 2, 15);
    
    self.finish.frame = CGRectMake(CGRectGetMaxX(self.price.frame), CGRectGetMinY(self.price.frame), (SCREEN_WIDTH - 20) / 2, 15);
}












@end

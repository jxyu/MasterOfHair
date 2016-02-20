//
//  WebStroeCollectionViewCell.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/21.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "WebStroeCollectionViewCell.h"

@implementation WebStroeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height / 7 * 4)];
//    self.image.backgroundColor = [UIColor orangeColor];
    self.image.layer.masksToBounds = YES;
    [self.contentView addSubview:self.image];
    
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.image.frame) + 3, (self.contentView.frame.size.width - 10) / 2 + 5, 17)];
//        self.price.backgroundColor = [UIColor blackColor];
    self.price.text = @"￥ 1111.11";
    self.price.textColor = [UIColor orangeColor];
    self.price.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:self.price];
    
    self.old_price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.price.frame), CGRectGetMaxY(self.image.frame) + 3, (self.contentView.frame.size.width - 10) / 2 - 5, 17)];
//    self.old_price.backgroundColor = [UIColor orangeColor];
    self.old_price.text = @"￥ 1111.11";
    self.old_price.textColor = [UIColor grayColor];
    self.old_price.font = [UIFont systemFontOfSize:9];
    [self.contentView addSubview:self.old_price];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.old_price.frame), CGRectGetMidY(self.price.frame) , (self.contentView.frame.size.width - 10) / 2 - 15, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:line];
    
    
    
    self.detail = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.price.frame) + 3, self.contentView.frame.size.width - 10, 30)];
    //    self.detail.backgroundColor = [UIColor orangeColor];
    self.detail.text = @"VS沙宣VS沙宣VS沙宣VS沙宣VS";
    self.detail.font = [UIFont systemFontOfSize:10];
    self.detail.numberOfLines = 0;
    [self.contentView addSubview:self.detail];
    
    
    self.image_class = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 40, 0, 40, 40)];
//    self.image_class.backgroundColor = [UIColor blackColor];
    self.image_class.image = [UIImage imageNamed:@"changjiazhitongche"];
    [self.contentView addSubview:self.image_class];
    
    
    
}


@end

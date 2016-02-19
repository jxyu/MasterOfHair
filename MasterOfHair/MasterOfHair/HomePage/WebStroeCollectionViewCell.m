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
    
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.image.frame) + 3, self.contentView.frame.size.width - 10, 17)];
    //    self.price.backgroundColor = [UIColor blackColor];
    self.price.text = @"￥ 1111.11";
    self.price.textColor = [UIColor orangeColor];
    self.price.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:self.price];
    
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

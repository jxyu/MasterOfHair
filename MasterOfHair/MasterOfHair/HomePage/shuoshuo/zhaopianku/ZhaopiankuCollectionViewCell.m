//
//  ZhaopiankuCollectionViewCell.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/16.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "ZhaopiankuCollectionViewCell.h"

@implementation ZhaopiankuCollectionViewCell

- (instancetype )initWithFrame:(CGRect)frame
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
    self.image = [[UIImageView alloc] initWithFrame:self.contentView.frame];
    self.image.layer.masksToBounds = YES;
//    self.image.backgroundColor = [UIColor orangeColor];
//    self.image.image = [UIImage imageNamed:@"shuoshuo98765"];
    [self.contentView addSubview:self.image];
    
    self.btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn.frame = CGRectMake(self.contentView.frame.size.width - 15, - 3, 20, 20);
    [self.btn setBackgroundImage:[UIImage imageNamed:@"30px"] forState:(UIControlStateNormal)];
    [self.contentView addSubview:self.btn];
    
}




@end

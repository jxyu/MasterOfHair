//
//  FenleiCollectionViewCell.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/31.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "FenleiCollectionViewCell.h"

@implementation FenleiCollectionViewCell

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
    self.name = [[UILabel alloc] initWithFrame:self.contentView.frame];
    self.name.textAlignment = NSTextAlignmentCenter;
    self.name.text = @"品牌产品";
    self.name.font = [UIFont systemFontOfSize:13];
    self.name.layer.borderWidth = 1;
    self.name.layer.borderColor = [UIColor blackColor].CGColor;
    self.name.layer.cornerRadius = 5;
    [self.contentView addSubview:self.name];
    
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(self.name.frame.size.width - 15, self.name.frame.size.height - 15, 15, 15)];
    self.image.image = [UIImage imageNamed:@"01sdjsidjisjdijsidjs_03"];
    [self.name addSubview:self.image];
    self.image.hidden = YES;
    
    
}


@end

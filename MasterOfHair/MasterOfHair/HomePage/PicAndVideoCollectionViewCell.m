//
//  PicAndVideoCollectionViewCell.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/20.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "PicAndVideoCollectionViewCell.h"

@implementation PicAndVideoCollectionViewCell

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
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height / 3 * 2.1)];
//    self.image.backgroundColor = [UIColor orangeColor];
    self.image.layer.masksToBounds = YES;
    [self.contentView addSubview:self.image];
    
    self.detail = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.image.frame) + 3, self.contentView.frame.size.width - 10, 30)];
    //    self.detail.backgroundColor = [UIColor orangeColor];
    self.detail.text = @"VS沙宣VS沙宣VS沙宣VS沙宣VS";
    self.detail.font = [UIFont systemFontOfSize:14];
    self.detail.numberOfLines = 1;
    [self.contentView addSubview:self.detail];
    
    
    
    
    self.image_iocn = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 15, self.contentView.frame.size.height - 15, 15, 15)];
    self.image_iocn.image = [UIImage imageNamed:@"01sdjjdijsidjs_03"];
    self.image_iocn.hidden = YES;
    [self.contentView addSubview:self.image_iocn];
}


@end

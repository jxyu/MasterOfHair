//
//  JCVideoCollectionViewCell.m
//  xitoujiang_ceshi
//
//  Created by 鞠超 on 16/1/18.
//  Copyright © 2016年 JC. All rights reserved.
//

#import "JCVideoCollectionViewCell.h"

@interface JCVideoCollectionViewCell ()

@property (nonatomic, strong) UIImageView * play;

@end

@implementation JCVideoCollectionViewCell

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
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    self.image.layer.masksToBounds = YES;
    self.image.layer.cornerRadius = 8;
    [self.contentView addSubview:self.image];
    
    self.isFree = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 40, 0, 40, 30)];
    self.isFree.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.isFree];
    
    UIView * view_bg = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 25, self.contentView.frame.size.width, 25)];
    view_bg.backgroundColor = [UIColor blackColor];
    view_bg.alpha = 0.2;
    [self.contentView addSubview:view_bg];
    
    self.play = [[UIImageView alloc] initWithFrame:CGRectMake(3, self.contentView.frame.size.height - 22.5, 20, 20)];
    self.play.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.play];
    
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.play.frame) + 5, CGRectGetMinY(self.play.frame), self.contentView.frame.size.width - CGRectGetMaxX(self.play.frame) - 15, 20)];
    self.name.text = @"美容美发美容美发";
    self.name.textColor = [UIColor whiteColor];
    self.name.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.name];
    
    self.image_iocn = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 25, self.contentView.frame.size.height - 25, 25, 25)];
    self.image_iocn.image = [UIImage imageNamed:@"01sdjjdijsidjs_03"];
    self.image_iocn.hidden = YES;
    [self.contentView addSubview:self.image_iocn];
}



@end

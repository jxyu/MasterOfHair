//
//  JCCollectionViewCell.m
//  UI-21-01
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 wolaji. All rights reserved.
//

#import "JCCollectionViewCell.h"

@implementation JCCollectionViewCell

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
{//同样也有contentView
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.contentView.frame.size.width - 10, self.contentView.frame.size.width - 10)];
    self.imageView.layer.cornerRadius = (self.contentView.frame.size.width - 10) / 2;
    self.imageView.backgroundColor = [UIColor orangeColor];
//    self.imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.imageView];
    
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxX(self.imageView.frame), self.contentView.frame.size.width, 20)];
    self.name.text = @"文秀联盟";
    self.name.font = [UIFont systemFontOfSize:12];
    self.name.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.name];
    
    
    self.image_iocn = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 17, self.contentView.frame.size.height - 17, 17, 17)];
    self.image_iocn.image = [UIImage imageNamed:@"01sdjjdijsidjs_03"];
    [self.contentView addSubview:self.image_iocn];
    self.image_iocn.hidden = YES;
    
    
    
    
    
}
















@end

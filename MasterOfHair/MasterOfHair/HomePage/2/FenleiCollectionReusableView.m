//
//  FenleiCollectionReusableView.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/31.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "FenleiCollectionReusableView.h"

@implementation FenleiCollectionReusableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self p_setupView];
        
    }
    return self;
}

- (void)p_setupView
{
    self.name = [[UILabel alloc] init];
    self.name.frame = CGRectMake(10, 0, self.frame.size.width - 10, self.frame.size.height);
    self.name.textAlignment = NSTextAlignmentLeft;
    self.name.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.name];
}

@end


//
//  VCollectionReusableView.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/1.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "VCollectionReusableView.h"

@implementation VCollectionReusableView

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
    self.type_all = [FL_Button fl_shareButton];
    
    self.type_all.frame = CGRectMake(10, 5, 65, 30);
    [self.type_all setImage:[UIImage imageNamed:@"select_down"] forState:UIControlStateNormal];
    [self.type_all setTitle:@"全部" forState:UIControlStateNormal];
    [self.type_all setTitleColor:navi_bar_bg_color forState:UIControlStateNormal];
    self.type_all.status = FLAlignmentStatusCenter;
    self.type_all.titleLabel.font = [UIFont systemFontOfSize:14];
    self.type_all.layer.masksToBounds=YES;
    self.type_all.layer.borderWidth= 1;
    self.type_all.layer.borderColor=navi_bar_bg_color.CGColor;
    self.type_all.layer.cornerRadius=8;
        
    [self addSubview:self.type_all];
    
    
    
    
    
    self.all = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.all.frame = CGRectMake(SCREEN_WIDTH - 135, 5, 40, 30);
    [self.all setTitle:@"全部" forState:(UIControlStateNormal)];
    self.all.titleLabel.font = [UIFont systemFontOfSize:16];
//    [self.all setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    [self addSubview:self.all];
    
    if (get_Bsp(@"IsShowVIP")) {
        self.vip = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.vip.frame = CGRectMake(SCREEN_WIDTH - 5 - 40, 5, 40, 30);
        [self.vip setTitle:@"会员" forState:(UIControlStateNormal)];
        self.vip.titleLabel.font = [UIFont systemFontOfSize:16];
        //    [self.vip setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [self addSubview:self.vip];
        
        self.free = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.free.frame = CGRectMake(SCREEN_WIDTH - 90, 5, 40, 30);
        [self.free setTitle:@"免费" forState:(UIControlStateNormal)];
        self.free.titleLabel.font = [UIFont systemFontOfSize:16];
        //    [self.free setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [self addSubview:self.free];
        UIView * line_1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.all.frame) + 2, 13, 1, 14)];
        line_1.backgroundColor = [UIColor grayColor];
        [self addSubview:line_1];
        
        UIView * line_2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.free.frame) + 2, 13, 1, 14)];
        line_2.backgroundColor = [UIColor grayColor];
        [self addSubview:line_2];
    }
    
    
    
    
    //
    self.search = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.search.frame = CGRectMake(CGRectGetMaxX(self.type_all.frame) + 5, 5, SCREEN_WIDTH - CGRectGetMaxX(self.type_all.frame) - 145, 30);
    self.search.layer.cornerRadius = 16;
    self.search.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.search.layer.borderWidth = 1;
    self.search.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.search];
    
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(2.5, 2.5, 25, 25)];
    image.image = [UIImage imageNamed:@"iconfont-sousuo"];
    [self.search addSubview:image];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame), 5, 80, 20)];
    label.text = @"输入关键字";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    [self.search addSubview:label];
    
}


@end

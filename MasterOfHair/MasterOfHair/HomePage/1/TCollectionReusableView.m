
//
//  TCollectionReusableView.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/1.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "TCollectionReusableView.h"

@implementation TCollectionReusableView

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
    
    
    
    self.all_text = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.all_text.frame = CGRectMake(SCREEN_WIDTH - 5 - 50, 5, 50, 30);
    [self.all_text setTitle:@"全部" forState:(UIControlStateNormal)];
    self.all_text.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.all_text setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    [self addSubview:self.all_text];
    
    
    
    //
    self.search = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.search.frame = CGRectMake(CGRectGetMaxX(self.type_all.frame) + 10, 5, SCREEN_WIDTH - CGRectGetMaxX(self.type_all.frame) - 90, 30);
    self.search.layer.cornerRadius = 16;
    self.search.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.search.layer.borderWidth = 1;
    self.search.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.search];
    
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2.5, 25, 25)];
    image.image = [UIImage imageNamed:@"iconfont-sousuo"];
    [self.search addSubview:image];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame) + 5, 5, 80, 20)];
    label.text = @"输入关键字";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    [self.search addSubview:label];
    
    

}







@end

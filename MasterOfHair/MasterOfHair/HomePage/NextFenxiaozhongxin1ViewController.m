//
//  NextFenxiaozhongxin1ViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/29.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "NextFenxiaozhongxin1ViewController.h"

#import "NextFenxiaoTableViewCell.h"
@interface NextFenxiaozhongxin1ViewController ()

@end

@implementation NextFenxiaozhongxin1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_navi];
    
    [self p_setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navi
- (void)p_navi
{
    _lblTitle.text = [NSString stringWithFormat:@"二级分销会员"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
}

//返回
- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

#pragma mark - 布局

- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}


@end

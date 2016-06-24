//
//  wenxiulanmengdingdandetailViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/4/2.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "wenxiulanmengdingdandetailViewController.h"

@interface wenxiulanmengdingdandetailViewController ()

@end

@implementation wenxiulanmengdingdandetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    _lblTitle.text = @"订单详情";
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    _lblLeft.text=@"返回";
    _lblLeft.textAlignment=NSTextAlignmentLeft;
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

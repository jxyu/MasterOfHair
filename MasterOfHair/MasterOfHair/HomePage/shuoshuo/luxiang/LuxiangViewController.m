//
//  LuxiangViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/17.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "LuxiangViewController.h"

@interface LuxiangViewController ()
//
@property (nonatomic, strong) UIView * view_white;
@property (nonatomic, strong) UIButton * btn_return;
//
@property (nonatomic, strong) UIView * bottom_view;
@property (nonatomic, strong) UIButton * btn_ok;

@end

@implementation LuxiangViewController

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
    _topView.hidden = YES;
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

//返回
- (void)btn_returnAction:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    CGFloat length_x = SCREEN_HEIGHT / 2;
    self.view_white = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, length_x)];
    self.view_white.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.view_white];
    
    
    self.btn_return = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_return.frame = CGRectMake(15, 20 + 10, 30, 30);
    [self.btn_return setBackgroundImage:[UIImage imageNamed:@"return101010"] forState:(UIControlStateNormal)];
    [self.view_white addSubview:self.btn_return];
    
    [self.btn_return addTarget:self action:@selector(btn_returnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.bottom_view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view_white.frame), SCREEN_WIDTH, length_x)];
    self.bottom_view.backgroundColor = navi_bar_bg_color;
    [self.view addSubview:self.bottom_view]; 
}






@end

//
//  JinkahuiyuanViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/2.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "JinkahuiyuanViewController.h"

@interface JinkahuiyuanViewController ()

@property (nonatomic, strong) UILabel * price;
//账号
@property (nonatomic, strong) UILabel * accent;

@property (nonatomic, strong) UIButton * btn_zhifubo;
@property (nonatomic, strong) UIButton * btn_weixin;

//开通
@property (nonatomic, strong) UIButton * btn_zhifu;

@end

@implementation JinkahuiyuanViewController

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
    _lblTitle.text = [NSString stringWithFormat:@"开通金卡会员"];
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
    
    
    
    UIView * view_1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 10, SCREEN_WIDTH, 50)];
    view_1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_1];
    
    UILabel * label_1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 30)];
    label_1.text = @"金卡会员";
    [view_1 addSubview:label_1];
    
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_1.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(label_1.frame) - 20, 30)];
    self.price.text = @"199元";
    self.price.textAlignment = NSTextAlignmentRight;
    [view_1 addSubview:self.price];
    
    
    UIView * view_2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_1.frame) + 2, SCREEN_WIDTH, 50)];
    view_2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_2];
    
    UILabel * label_3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 30)];
    label_3.text = @"账号:";
    [view_2 addSubview:label_3];
    
    self.accent = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_3.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(label_3.frame) - 20, 30)];
    self.accent.text = @"1888888888888";
    self.accent.textAlignment = NSTextAlignmentRight;
    [view_2 addSubview:self.accent];

    
    
    UIView * view_3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_2.frame) + 15, SCREEN_WIDTH, 70)];
    view_3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_3];
    
    UILabel * label_2 = [[UILabel alloc] initWithFrame:CGRectMake(13, 10, SCREEN_WIDTH - 15, 15)];
    label_2.text = @"选择支付方式";
    label_2.textColor = [UIColor grayColor];
    label_2.font = [UIFont systemFontOfSize:13];
    [view_3 addSubview:label_2];
    
    CGFloat length_x = SCREEN_WIDTH / 3;
    //支付宝支付
    self.btn_zhifubo = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.btn_zhifubo.frame = CGRectMake(15, CGRectGetMaxY(label_2.frame) + 10, 25, 25);
    //    self.btn_zhifubo.backgroundColor = [UIColor orangeColor];
    self.btn_zhifubo.selected = 0;
    [view_3 addSubview:self.btn_zhifubo];
    [self.btn_zhifubo addTarget:self action:@selector(btn_zhifuboAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.btn_zhifubo setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
    
    UILabel * label_myPurse = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.btn_zhifubo.frame) + 5, CGRectGetMaxY(label_2.frame) + 7.5, length_x - CGRectGetMaxX(self.btn_zhifubo.frame) - 5, 30)];
    //    label_myPurse.backgroundColor = [UIColor orangeColor];
    label_myPurse.text = @"支付宝支付";
    label_myPurse.font = [UIFont systemFontOfSize:12];
    [view_3 addSubview:label_myPurse];
    
    //微信支付
    self.btn_weixin = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.btn_weixin.frame = CGRectMake(30 + length_x, CGRectGetMaxY(label_2.frame) + 10, 25, 25);
    //    self.btn_weixin.backgroundColor = [UIColor orangeColor];
    self.btn_weixin.selected = 0;
    [view_3 addSubview:self.btn_weixin];
    [self.btn_weixin addTarget:self action:@selector(btn_weixinAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.btn_weixin setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
    
    UILabel * label_zhifubo = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.btn_weixin.frame) + 5, CGRectGetMaxY(label_2.frame) + 7.5, length_x - CGRectGetMaxX(self.btn_zhifubo.frame) , 30)];
    //    label_zhifubo.backgroundColor = [UIColor orangeColor];
    label_zhifubo.text = @"微信支付";
    label_zhifubo.font = [UIFont systemFontOfSize:12];
    [view_3 addSubview:label_zhifubo];
    
    
    self.btn_zhifu = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_zhifu.frame = CGRectMake(15, SCREEN_HEIGHT - 55, SCREEN_WIDTH - 30, 45);
    self.btn_zhifu.backgroundColor = navi_bar_bg_color;
    [self.btn_zhifu setTitle:@"立即开通" forState:(UIControlStateNormal)];
    [self.btn_zhifu setTintColor:[UIColor whiteColor]];
    self.btn_zhifu.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.btn_zhifu];
    
    [self.btn_zhifu addTarget:self action:@selector(btn_zhifuAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

#pragma mark - 开通
- (void)btn_zhifuAction:(UIButton *)sender
{
    if(self.btn_zhifubo.selected == 0 && self.btn_weixin.selected == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择支付方式" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else
    {
        NSLog(@"走支付流程, 获得权限");
        
    }
    
}

#pragma mark - 微信 和 支付宝
- (void)btn_zhifuboAction:(UIButton *)sender
{
    if(sender.selected == 0)
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_06"] forState:(UIControlStateNormal)];
        sender.selected = 1;
        
        self.btn_weixin.selected = 0;
        [self.btn_weixin setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
        sender.selected = 0;
    }
}

- (void)btn_weixinAction:(UIButton *)sender
{
    if(sender.selected == 0)
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_06"] forState:(UIControlStateNormal)];
        sender.selected = 1;
        
        self.btn_zhifubo.selected = 0;
        [self.btn_zhifubo setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
        sender.selected = 0;
    }
}





@end

//
//  ZhifuViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/29.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "ZhifuViewController.h"

@interface ZhifuViewController ()

@property (nonatomic, strong) UIButton * btn_zhifu;

@property (nonatomic, strong) UIButton * btn_zhifubo;
@property (nonatomic, strong) UIButton * btn_weixin;
@property (nonatomic, strong) UIButton * btn_myPurse;

@end

@implementation ZhifuViewController

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
    _lblTitle.text = [NSString stringWithFormat:@"支付"];
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
    
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 30)];
    self.name.text = @"课程名称";
    [view_1 addSubview:self.name];
    

    UIView * view_2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_1.frame) + 2, SCREEN_WIDTH, 50)];
    view_2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_2];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 50, 30)];
    label.text = @"总价:";
    [view_2 addSubview:label];
    
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(label.frame) - 20, 30)];
    self.price.text = @"5000元";
    self.price.textColor = [UIColor orangeColor];
    self.price.textAlignment = NSTextAlignmentRight;
    [view_2 addSubview:self.price];
    
    
    UIView * view_3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_2.frame) + 10, SCREEN_WIDTH, 60)];
    view_3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_3];
    
    UILabel * label_2 = [[UILabel alloc] initWithFrame:CGRectMake(13, 5, SCREEN_WIDTH - 15, 15)];
    label_2.text = @"选择支付方式";
    label_2.textColor = [UIColor grayColor];
    label_2.font = [UIFont systemFontOfSize:13];
    [view_3 addSubview:label_2];
    
    CGFloat length_x = SCREEN_WIDTH / 3;
    //我的钱包
    self.btn_myPurse = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.btn_myPurse.frame = CGRectMake(15, CGRectGetMaxY(label_2.frame) + 7.5, 25, 25);
    //    self.btn_myPurse.backgroundColor = [UIColor orangeColor];
    self.btn_myPurse.selected = 0;
    [view_3 addSubview:self.btn_myPurse];
    [self.btn_myPurse addTarget:self action:@selector(btn_myPurseAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.btn_myPurse setImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
    
    UILabel * label_myPurse = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.btn_myPurse.frame) + 5, CGRectGetMaxY(label_2.frame) + 5, length_x - CGRectGetMaxX(self.btn_myPurse.frame) - 5, 30)];
    //    label_myPurse.backgroundColor = [UIColor orangeColor];
    label_myPurse.text = @"我的钱包";
    label_myPurse.font = [UIFont systemFontOfSize:12];
    [view_3 addSubview:label_myPurse];
    
    //支付宝
    self.btn_zhifubo = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.btn_zhifubo.frame = CGRectMake(10 + length_x, CGRectGetMaxY(label_2.frame) + 7.5, 25, 25);
    //    self.btn_zhifubo.backgroundColor = [UIColor orangeColor];
    self.btn_zhifubo.selected = 0;
    [view_3 addSubview:self.btn_zhifubo];
    [self.btn_zhifubo addTarget:self action:@selector(btn_zhifuboAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.btn_zhifubo setImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
    
    
    UILabel * label_zhifubo = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.btn_zhifubo.frame) + 5, CGRectGetMaxY(label_2.frame) + 5, length_x - CGRectGetMaxX(self.btn_myPurse.frame) , 30)];
    //    label_zhifubo.backgroundColor = [UIColor orangeColor];
    label_zhifubo.text = @"支付宝支付";
    label_zhifubo.font = [UIFont systemFontOfSize:12];
    [view_3 addSubview:label_zhifubo];
    
    //微信
    self.btn_weixin = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.btn_weixin.frame = CGRectMake(15 + length_x * 2, CGRectGetMaxY(label_2.frame) + 7.5, 25, 25);
    //    self.btn_weixin.backgroundColor = [UIColor orangeColor];
    self.btn_weixin.selected = 0;
    [view_3 addSubview:self.btn_weixin];
    [self.btn_weixin addTarget:self action:@selector(btn_weixinAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.btn_weixin setImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
    
    UILabel * label_weixin = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.btn_weixin.frame) + 5, CGRectGetMaxY(label_2.frame) + 5, length_x - CGRectGetMaxX(self.btn_myPurse.frame) - 5, 30)];
    //    label_weixin.backgroundColor = [UIColor orangeColor];
    label_weixin.text = @"微信支付";
    label_weixin.font = [UIFont systemFontOfSize:12];
    [view_3 addSubview:label_weixin];

    
    
    self.btn_zhifu = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_zhifu.frame = CGRectMake(15, SCREEN_HEIGHT - 55, SCREEN_WIDTH - 30, 45);
    self.btn_zhifu.backgroundColor = navi_bar_bg_color;
    [self.btn_zhifu setTitle:@"确认支付" forState:(UIControlStateNormal)];
    [self.btn_zhifu setTintColor:[UIColor whiteColor]];
    self.btn_zhifu.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.btn_zhifu];
    
    [self.btn_zhifu addTarget:self action:@selector(btn_zhifuAction:) forControlEvents:(UIControlEventTouchUpInside)];

}

#pragma mark - 支付
- (void)btn_zhifuAction:(UIButton *)sender
{
    if(self.btn_zhifubo.selected == 0 && self.btn_weixin.selected == 0 && self.btn_myPurse.selected == 0)
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
        NSLog(@"走支付流程");
    }
    
}

- (void)btn_myPurseAction:(UIButton *)sender
{
    if(sender.selected == 0)
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_06"] forState:(UIControlStateNormal)];
        sender.selected = 1;
        
        self.btn_zhifubo.selected = 0;
        [self.btn_zhifubo setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
        
        self.btn_weixin.selected = 0;
        [self.btn_weixin setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
        sender.selected = 0;
    }
}

- (void)btn_zhifuboAction:(UIButton *)sender
{
    if(sender.selected == 0)
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_06"] forState:(UIControlStateNormal)];
        sender.selected = 1;
        
        self.btn_myPurse.selected = 0;
        [self.btn_myPurse setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
        
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
        
        self.btn_myPurse.selected = 0;
        [self.btn_myPurse setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
        sender.selected = 0;
    }
}















@end

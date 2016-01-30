//
//  NextqianbaoViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/30.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "NextqianbaoViewController.h"

@interface NextqianbaoViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;
//
@property (nonatomic, strong) UITextField * text_account;

@property (nonatomic, strong) UIButton * btn_50;
@property (nonatomic, strong) UIButton * btn_100;
@property (nonatomic, strong) UIButton * btn_200;
@property (nonatomic, strong) UIButton * btn_500;
@property (nonatomic, strong) UIButton * btn_1000;

//
@property (nonatomic, strong) UIButton * btn_zhifu;

@end

@implementation NextqianbaoViewController

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
    _lblTitle.text = [NSString stringWithFormat:@"我的余额"];
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
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 60)];
    self.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.scrollView];
    
    
    self.btn_zhifu = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_zhifu.frame = CGRectMake(15, SCREEN_HEIGHT - 50, SCREEN_WIDTH - 30, 40);
    self.btn_zhifu.backgroundColor = navi_bar_bg_color;
    [self.btn_zhifu setTitle:@"提现申请" forState:(UIControlStateNormal)];
    [self.btn_zhifu setTintColor:[UIColor whiteColor]];
    self.btn_zhifu.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.btn_zhifu];
    
    [self.btn_zhifu addTarget:self action:@selector(btn_zhifuAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self p_scrollView];
}

#pragma mark - btn-提现申请

- (void)btn_zhifuAction:(UIButton *)sender
{
    NSLog(@"提现申请");
    
    if([self.text_account.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入支付宝账号" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else if(self.btn_50.isSelected == 0 && self.btn_100.isSelected == 0 && self.btn_200.isSelected == 0 && self.btn_500.isSelected == 0 && self.btn_1000.isSelected == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择提现金额" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else
    {
        if(self.btn_50.isSelected == 1)
        {
            NSLog(@"提现50");
        }
        
        if(self.btn_100.isSelected == 1)
        {
            
        }
        
        if(self.btn_200.isSelected == 1)
        {
            
        }
        
        if(self.btn_500.isSelected == 1)
        {
            
        }
        
        if(self.btn_1000.isSelected == 1)
        {
            
        }
    }
}

#pragma mark - scrollView布局
- (void)p_scrollView
{
    UIView * view_white = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 50)];
    view_white.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white];
    
    UILabel * label_1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 30)];
    label_1.text = @"到账支付宝";
    label_1.font = [UIFont systemFontOfSize:15];
//    label_1.backgroundColor = [UIColor orangeColor];
    [view_white addSubview:label_1];
    
    self.text_account = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_1.frame) + 15, 10, SCREEN_WIDTH - CGRectGetMaxX(label_1.frame) - 25, 30)];
    self.text_account.delegate = self;
    self.text_account.placeholder = @"请输入支付宝账号";
    self.text_account.font = [UIFont systemFontOfSize:15];
    self.text_account.clearButtonMode = UITextFieldViewModeAlways;
    [view_white addSubview:self.text_account];
    
    
    UILabel * lable_2 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(view_white.frame) + 10, 100, 15)];
    lable_2.text = @"选择提现金额";
    lable_2.font = [UIFont systemFontOfSize:13];
    [self.scrollView addSubview:lable_2];
    
    
    UIView * view_white1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lable_2.frame) + 8, SCREEN_WIDTH, 240)];
    view_white1.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white1];
    
    
    self.btn_50 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_50.frame = CGRectMake(15, 10, SCREEN_WIDTH - 30, 40);
    self.btn_50.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.btn_50.layer.cornerRadius = 5;
    [self.btn_50 setTitle:@"50元" forState:(UIControlStateNormal)];
    [self.btn_50 setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    [view_white1 addSubview:self.btn_50];
    [self.btn_50 addTarget:self action:@selector(btn_50Action:) forControlEvents:(UIControlEventTouchUpInside)];
    self.btn_50.selected = 0;
    
    
    self.btn_100 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_100.frame = CGRectMake(15, CGRectGetMaxY(self.btn_50.frame) + 5, SCREEN_WIDTH - 30, 40);
    self.btn_100.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.btn_100.layer.cornerRadius = 5;
    [self.btn_100 setTitle:@"100元" forState:(UIControlStateNormal)];
    [self.btn_100 setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    [view_white1 addSubview:self.btn_100];
    [self.btn_100 addTarget:self action:@selector(btn_100Action:) forControlEvents:(UIControlEventTouchUpInside)];
    self.btn_100.selected = 0;

    
    self.btn_200 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_200.frame = CGRectMake(15, CGRectGetMaxY(self.btn_100.frame) + 5, SCREEN_WIDTH - 30, 40);
    self.btn_200.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.btn_200.layer.cornerRadius = 5;
    [self.btn_200 setTitle:@"200元" forState:(UIControlStateNormal)];
    [self.btn_200 setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    [view_white1 addSubview:self.btn_200];
    [self.btn_200 addTarget:self action:@selector(btn_200Action:) forControlEvents:(UIControlEventTouchUpInside)];
    self.btn_200.selected = 0;

    
    self.btn_500 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_500.frame = CGRectMake(15, CGRectGetMaxY(self.btn_200.frame) + 5, SCREEN_WIDTH - 30, 40);
    self.btn_500.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.btn_500.layer.cornerRadius = 5;
    [self.btn_500 setTitle:@"500元" forState:(UIControlStateNormal)];
    [self.btn_500 setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    [view_white1 addSubview:self.btn_500];
    [self.btn_500 addTarget:self action:@selector(btn_500Action:) forControlEvents:(UIControlEventTouchUpInside)];
    self.btn_500.selected = 0;

    
    self.btn_1000 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_1000.frame = CGRectMake(15, CGRectGetMaxY(self.btn_500.frame) + 5, SCREEN_WIDTH - 30, 40);
    self.btn_1000.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.btn_1000.layer.cornerRadius = 5;
    [self.btn_1000 setTitle:@"1000元" forState:(UIControlStateNormal)];
    [self.btn_1000 setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    [view_white1 addSubview:self.btn_1000];
    [self.btn_1000 addTarget:self action:@selector(btn_1000Action:) forControlEvents:(UIControlEventTouchUpInside)];
    self.btn_1000.selected = 0;

    
    UILabel * label_3 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(view_white1.frame) + 10, 100, 15)];
    label_3.text = @"申请提现说明";
    label_3.font = [UIFont systemFontOfSize:13];
    [self.scrollView addSubview:label_3];
    
#warning 这个不确定
    UIView * view_white2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label_3.frame) + 8, SCREEN_WIDTH, 100)];
    view_white2.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white2];
    
    
    self.scrollView.contentSize = CGSizeMake(0, 500);

}

#pragma mark - 5中金额
- (void)btn_50Action:(UIButton *)sender
{
    if(sender.isSelected == 0)
    {
        sender.selected = 1;
        
        self.btn_100.selected = 0;
        self.btn_200.selected = 0;
        self.btn_500.selected = 0;
        self.btn_1000.selected = 0;
    }
    else
    {
        sender.selected = 0;
    }
}

- (void)btn_100Action:(UIButton *)sender
{
    if(sender.isSelected == 0)
    {
        sender.selected = 1;
        
        self.btn_50.selected = 0;
        self.btn_200.selected = 0;
        self.btn_500.selected = 0;
        self.btn_1000.selected = 0;
    }
    else
    {
        sender.selected = 0;
    }
}

- (void)btn_200Action:(UIButton *)sender
{
    if(sender.isSelected == 0)
    {
        sender.selected = 1;
        
        self.btn_100.selected = 0;
        self.btn_50.selected = 0;
        self.btn_500.selected = 0;
        self.btn_1000.selected = 0;
    }
    else
    {
        sender.selected = 0;
    }
}

- (void)btn_500Action:(UIButton *)sender
{
    if(sender.isSelected == 0)
    {
        sender.selected = 1;
        
        self.btn_100.selected = 0;
        self.btn_200.selected = 0;
        self.btn_50.selected = 0;
        self.btn_1000.selected = 0;
    }
    else
    {
        sender.selected = 0;
    }
}

- (void)btn_1000Action:(UIButton *)sender
{
    if(sender.isSelected == 0)
    {
        sender.selected = 1;
        
        self.btn_100.selected = 0;
        self.btn_200.selected = 0;
        self.btn_500.selected = 0;
        self.btn_50.selected = 0;
    }
    else
    {
        sender.selected = 0;
    }
}

#pragma mark - textField代理
- (BOOL )textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void )touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.text_account resignFirstResponder];
}





@end

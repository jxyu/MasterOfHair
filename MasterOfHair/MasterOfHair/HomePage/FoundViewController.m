//
//  FoundViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/22.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "FoundViewController.h"

#import "AppDelegate.h"
@interface FoundViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

//电话
@property (nonatomic, strong) UITextField * text_tel;
//验证码
@property (nonatomic, strong) UITextField * text_captcha;
//密码
@property (nonatomic, strong) UITextField * text_pass;
//再次密码
@property (nonatomic, strong) UITextField * text_password;

@end

@implementation FoundViewController

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
    _lblTitle.text = [NSString stringWithFormat:@"重置密码"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    
    _btnRight.hidden = YES;
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
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.scrollView];
    
    [self p_setupView1];
}

- (void)p_setupView1
{
    //电话
    UIView * view_1 = [[UIView alloc] initWithFrame:CGRectMake(10,  10, self.view.frame.size.width - 20, 50)];
    view_1.backgroundColor = [UIColor whiteColor];
    view_1.layer.cornerRadius = 5;
    view_1.layer.borderColor = navi_bar_bg_color.CGColor;
    view_1.layer.borderWidth = 1;
    [self.scrollView addSubview:view_1];
    
    self.text_tel = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, view_1.frame.size.width - 30, 40)];
    self.text_tel.placeholder = @"请填写手机号";
    self.text_tel.keyboardType = UIKeyboardTypeNumberPad;
    self.text_tel.delegate = self;
    [view_1 addSubview:self.text_tel];
    
    //验证码
    UIView * view_2 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(view_1.frame) + 10, 200, 50)];
    view_2.backgroundColor = [UIColor whiteColor];
    view_2.layer.cornerRadius = 5;
    view_2.layer.borderColor = navi_bar_bg_color.CGColor;
    view_2.layer.borderWidth = 1;
    [self.scrollView addSubview:view_2];
    
    self.text_captcha = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, view_2.frame.size.width - 30, 40)];
    self.text_captcha.placeholder = @"请输入验证码";
    self.text_captcha.delegate = self;
    [view_2 addSubview:self.text_captcha];
    
    UIButton * btn_captcha = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn_captcha.frame = CGRectMake(CGRectGetMaxX(view_2.frame) + 5, CGRectGetMaxY(view_1.frame) + 10, self.view.frame.size.width - CGRectGetMaxX(view_2.frame) - 15, 50);
    [btn_captcha setTitle:@"免费获取" forState:(UIControlStateNormal)];
    [btn_captcha setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    btn_captcha.backgroundColor = navi_bar_bg_color;
    btn_captcha.layer.cornerRadius = 5;
    [self.scrollView addSubview:btn_captcha];
    [btn_captcha addTarget:self action:@selector(btnbtn_captchaAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //密码1
    UIView * view_3 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(view_2.frame) + 10, self.view.frame.size.width - 20, 50)];
    view_3.backgroundColor = [UIColor whiteColor];
    view_3.layer.cornerRadius = 5;
    view_3.layer.borderColor = navi_bar_bg_color.CGColor;
    view_3.layer.borderWidth = 1;
    [self.scrollView addSubview:view_3];
    
    self.text_pass = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, view_1.frame.size.width - 20, 40)];
    self.text_pass.placeholder = @"请输入6位以上数字或字母组合密码";
    self.text_pass.delegate = self;
    self.text_pass.secureTextEntry = YES;
    [view_3 addSubview:self.text_pass];
    
    //密码2
    UIView * view_4 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(view_3.frame) + 10, self.view.frame.size.width - 20, 50)];
    view_4.backgroundColor = [UIColor whiteColor];
    view_4.layer.cornerRadius = 5;
    view_4.layer.borderColor = navi_bar_bg_color.CGColor;
    view_4.layer.borderWidth = 1;
    [self.scrollView addSubview:view_4];
    
    self.text_password = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, view_1.frame.size.width - 30, 40)];
    self.text_password.placeholder = @"请再次输入密码";
    self.text_password.delegate = self;
    self.text_password.secureTextEntry = YES;
    [view_4 addSubview:self.text_password];
    
    
    //btn注册
    UIButton * btn_change = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn_change.frame = CGRectMake(20, CGRectGetMaxY(view_4.frame) + 20, self.view.frame.size.width - 40 , 40);
    [btn_change setTitle:@"立 即 重 置" forState:(UIControlStateNormal)];
    [btn_change setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    btn_change.layer.cornerRadius = 4;
    btn_change.backgroundColor = navi_bar_bg_color;
    [self.scrollView addSubview:btn_change];
    [btn_change addTarget:self action:@selector(btn_changeAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

#pragma mark - btn重置, 验证二维码
- (void)btnbtn_captchaAction:(UIButton *)sender
{
    [self.text_tel resignFirstResponder];
    [self.text_password resignFirstResponder];
    [self.text_pass resignFirstResponder];
    [self.text_captcha resignFirstResponder];
    
    NSLog(@"点击验证二维码");
}

- (void)btn_changeAction:(UIButton *)sender
{
    [self.text_tel resignFirstResponder];
    [self.text_password resignFirstResponder];
    [self.text_pass resignFirstResponder];
    [self.text_captcha resignFirstResponder];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    
    NSLog(@"立即重置");
}


#pragma mark - textField代理
- (BOOL )textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.text_tel resignFirstResponder];
    [self.text_password resignFirstResponder];
    [self.text_pass resignFirstResponder];
    [self.text_captcha resignFirstResponder];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if([textField isEqual:self.text_pass])
    {
        [UIView animateWithDuration:0.7 animations:^{
            
            self.scrollView.contentOffset = CGPointMake(0, 100);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if([textField isEqual:self.text_password])
    {
        [UIView animateWithDuration:0.7 animations:^{
            
            self.scrollView.contentOffset = CGPointMake(0, 150);
            
        } completion:^(BOOL finished) {
            
        }];
    }
}





















@end

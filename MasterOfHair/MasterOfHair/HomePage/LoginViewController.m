//
//  LoginViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/22.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "LoginViewController.h"

#import "AppDelegate.h"
#import "RegistViewController.h"
#import "FoundViewController.h"
@interface LoginViewController () <UITextFieldDelegate>

//账号
@property (nonatomic, strong) UITextField * text_account;
//密码
@property (nonatomic, strong) UITextField * text_password;

@end

@implementation LoginViewController

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
    _lblTitle.text = [NSString stringWithFormat:@"登录"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    
    _lblLeft.text=@"返回";
    _lblLeft.textAlignment=NSTextAlignmentLeft;
    [self addRightbuttontitle:@"注册"];
}

//返回
- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//注册
- (void)clickRightButton:(UIButton *)sender
{
    [self.text_account resignFirstResponder];
    [self.text_password resignFirstResponder];
    
    RegistViewController * registViewController = [[RegistViewController alloc] init];
    [self showViewController:registViewController sender:nil];
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

#pragma mark - textField代理

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
//touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.text_account resignFirstResponder];
    [self.text_password resignFirstResponder];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView * view_account = [[UIView alloc] initWithFrame:CGRectMake(10, 64 + 10, self.view.frame.size.width - 20, 50)];
    view_account.backgroundColor = [UIColor whiteColor];
    view_account.layer.cornerRadius = 5;
    view_account.layer.borderColor = navi_bar_bg_color.CGColor;
    view_account.layer.borderWidth = 1;
    [self.view addSubview:view_account];
    
    UILabel * label_account = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 60, 40)];
    label_account.text = @"手机号";
    label_account.font = [UIFont systemFontOfSize:17];
    label_account.textColor = navi_bar_bg_color;
    [view_account addSubview:label_account];
    
    self.text_account = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_account.frame) + 15, 5, 170, 40)];
    //    self.text_account.backgroundColor = [UIColor orangeColor];
    self.text_account.placeholder = @"请输入手机号";
    self.text_account.keyboardType = UIKeyboardTypeNumberPad;
    [view_account addSubview:self.text_account];
    self.text_account.delegate = self;
    
    
    UIView * view_password = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(view_account.frame ) + 10, self.view.frame.size.width - 20, 50)];
    view_password.backgroundColor = [UIColor whiteColor];
    view_password.layer.cornerRadius = 5;
    view_password.layer.borderColor = navi_bar_bg_color.CGColor;
    view_password.layer.borderWidth = 1;
    [self.view addSubview:view_password];
    
    UILabel * label_password = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 60, 40)];
    label_password.text = @"密  码";
    label_password.textColor = navi_bar_bg_color;
    label_password.font = [UIFont systemFontOfSize:17];
    [view_password addSubview:label_password];
    
    self.text_password = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_password.frame) + 10, 5, 170, 40)];
    self.text_password.placeholder = @"请输入密码";
    self.text_password.secureTextEntry = YES;
    [view_password addSubview:self.text_password];
    self.text_password.delegate = self;
    
    //登陆
    UIButton * btn_login = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn_login.frame = CGRectMake(20, CGRectGetMaxY(view_password.frame) + 50, self.view.frame.size.width - 40 , 40);
    [btn_login setTitle:@"确认登录" forState:(UIControlStateNormal)];
    [btn_login setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    btn_login.layer.cornerRadius = 4;
    btn_login.titleLabel.font = [UIFont systemFontOfSize:17];
    btn_login.backgroundColor = navi_bar_bg_color;
    [self.view addSubview:btn_login];
    [btn_login addTarget:self action:@selector(btn_loginAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //找回密码
    UIButton * btn_found = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn_found.frame = CGRectMake(CGRectGetMaxX(view_password.frame) - 20 - 25, 15, 20, 20);
//    btn_found.backgroundColor = [UIColor orangeColor];
    [btn_found setImage:[UIImage imageNamed:@"06wenhao_03"] forState:(UIControlStateNormal)];
    [btn_found setTintColor:navi_bar_bg_color];
    [view_password addSubview:btn_found];
    [btn_found addTarget:self action:@selector(btn_foundAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

#pragma mark - 登陆按钮
- (void)btn_loginAction:(UIButton *)sender
{
//    NSLog(@"登陆");
    [self.text_account resignFirstResponder];
    [self.text_password resignFirstResponder];
    
    if([self.text_account.text length] == 0 || [self.text_password.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号或密码不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        [self presentViewController:alert animated:YES completion:^{
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
    }
    
    if([self.text_account.text length] != 0 && [self.text_password.text length] != 0)
    {
        DataProvider * dataprovider=[[DataProvider alloc] init];
        [dataprovider setDelegateObject:self setBackFunctionName:@"login_register:"];
        [dataprovider loginWithMember_username:self.text_account.text member_password:self.text_password.text];        
    }
}

#pragma mark - 接口部分
- (void)login_register:(id )dict
{
    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        }
        @catch (NSException *exception)
        {
        }
        @finally
        {
            NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
            
            //保存用户名和密码
            [userdefault setObject:self.text_account.text forKey:@"account"];
            [userdefault setObject:self.text_password.text forKey:@"password"];
            //保存登陆的状态
            [userdefault setObject:@"1" forKey:@"Login_Success"];
            
            //保存用户信息（后期可能更多）
            [userdefault setObject:[NSString stringWithFormat:@"%@",dict[@"data"][@"member_phone"]] forKey:@"member_phone"];
            [userdefault setObject:[NSString stringWithFormat:@"%@",dict[@"data"][@"member_headpic"]] forKey:@"member_headpic"];
            [userdefault setObject:[NSString stringWithFormat:@"%@",dict[@"data"][@"member_id"]] forKey:@"member_id"];
            [userdefault setObject:[NSString stringWithFormat:@"%@",dict[@"data"][@"member_nickname"]] forKey:@"member_nickname"];
            [userdefault setObject:[NSString stringWithFormat:@"%@",dict[@"data"][@"member_type"]] forKey:@"member_type"];
            [userdefault setObject:[NSString stringWithFormat:@"%@",dict[@"data"][@"member_username"]] forKey:@"member_username"];


            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] ];
    }
    
}

#pragma mark - 找回密码
- (void)btn_foundAction:(UIButton *)sender
{
    NSLog(@"找回密码");
    [self.text_account resignFirstResponder];
    [self.text_password resignFirstResponder];
    
    FoundViewController * foundViewController = [[FoundViewController alloc] init];
    
    [self showViewController:foundViewController sender:nil];
}









@end

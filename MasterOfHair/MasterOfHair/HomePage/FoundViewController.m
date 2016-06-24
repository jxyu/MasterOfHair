//
//  FoundViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/22.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "FoundViewController.h"

#import "AppDelegate.h"
#import <SMS_SDK/SMSSDK.h>

@interface FoundViewController () <UITextFieldDelegate , UIScrollViewDelegate>

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
    _lblLeft.text=@"返回";
    _lblLeft.textAlignment=NSTextAlignmentLeft;
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
    
    self.scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT + 20);
    self.scrollView.delegate = self;
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
    btn_captcha.titleLabel.font = [UIFont systemFontOfSize:17];
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
    
    NSLog(@"点击验证码");
    if (self.text_tel.text.length == 11)
    {
        [SVProgressHUD showWithStatus:@"正在发送" maskType:SVProgressHUDMaskTypeBlack];
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.text_tel.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (!error)
            {
                [SVProgressHUD dismiss];
            }
            else
            {
                [SVProgressHUD dismiss];
                
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"该号码不存在" preferredStyle:(UIAlertControllerStyleAlert)];
                [self presentViewController:alert animated:YES completion:^{
                }];
                
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:action];
            }
        }];
    }
    else
    {
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确手机号" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)btn_changeAction:(UIButton *)sender
{
    //    NSLog(@"立即重置");

    [self.text_tel resignFirstResponder];
    [self.text_password resignFirstResponder];
    [self.text_pass resignFirstResponder];
    [self.text_captcha resignFirstResponder];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    //多次判断
    if([self.text_tel.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入手机号" preferredStyle:(UIAlertControllerStyleAlert)];
        [self presentViewController:alert animated:YES completion:^{
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
    }
    
    if([self.text_tel.text length] != 11)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确手机号" preferredStyle:(UIAlertControllerStyleAlert)];
        [self presentViewController:alert animated:YES completion:^{
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        
    }
    
    if([self.text_captcha.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入验证码" preferredStyle:(UIAlertControllerStyleAlert)];
        [self presentViewController:alert animated:YES completion:^{
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        
    }
    
    if([self.text_pass.text length] < 6 || [self.text_password.text length] < 6)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入6位以上数字或字母组合密码" preferredStyle:(UIAlertControllerStyleAlert)];
        [self presentViewController:alert animated:YES completion:^{
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        
    }
    
    if(![self.text_pass.text isEqualToString:self.text_password.text])
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次输入的密码不相同" preferredStyle:(UIAlertControllerStyleAlert)];
        [self presentViewController:alert animated:YES completion:^{
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
    }
    
    
    if([self.text_tel.text length] == 11 && [self.text_captcha.text length] != 0 && [self.text_pass.text isEqualToString:self.text_password.text] && [self.text_pass.text length] >= 6 && [self.text_password.text length] >= 6)
    {
        [SMSSDK commitVerificationCode:self.text_captcha.text phoneNumber:self.text_tel.text zone:@"86" result:^(NSError *error) {
            
            if(error)
            {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入的验证码错误" preferredStyle:(UIAlertControllerStyleAlert)];
                [self presentViewController:alert animated:YES completion:^{
                }];
                
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:action];
            }
            else
            {//验证成功
                DataProvider * dataprovider=[[DataProvider alloc] init];
                [dataprovider setDelegateObject:self setBackFunctionName:@"resetPassword:"];
                
                [dataprovider resetPasswordWithMember_username:self.text_tel.text member_password:self.text_pass.text];
            }
        }];
    }
    
//    DataProvider * dataprovider=[[DataProvider alloc] init];
//    [dataprovider setDelegateObject:self setBackFunctionName:@"resetPassword:"];
//    
//    [dataprovider resetPasswordWithMember_username:self.text_tel.text member_password:self.text_pass.text];
    
}

#pragma mark - 找回接口
- (void)resetPassword:(id )dict
{
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"重置密码成功"];
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] maskType:SVProgressHUDMaskTypeBlack];
    }
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

#pragma mark - scrollView代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.text_tel resignFirstResponder];
    [self.text_password resignFirstResponder];
    [self.text_pass resignFirstResponder];
    [self.text_captcha resignFirstResponder];
}




















@end

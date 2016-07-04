//
//  SetPayPwdViewController.m
//  ChengJiaXiaoChi
//
//  Created by 于金祥 on 16/5/11.
//  Copyright © 2016年 于金祥. All rights reserved.
//

#import "SetPayPwdViewController.h"
#import "TXTradePasswordView.h"
#import "DataProvider.h"

@interface SetPayPwdViewController ()<TXTradePasswordViewDelegate>

@end

@implementation SetPayPwdViewController
{
    NSString * firstPWD;
    NSString * secondPWD;
    TXTradePasswordView *TXView1 ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLeftButton:@"iconfont-fanhui"];
    _lblLeft.text=@"返回";
    _lblLeft.textAlignment=NSTextAlignmentLeft;
    self.view.backgroundColor=[UIColor whiteColor];
    _lblTitle.text=@"设置支付密码";
    TXView1 = [[TXTradePasswordView alloc]initWithFrame:CGRectMake(0, 100,SCREEN_WIDTH, 200) WithTitle:@"请输入支付密码"];
    TXView1.tag=1;
    TXView1.TXTradePasswordDelegate = self;
    if (![TXView1.TF becomeFirstResponder])
    {
        //成为第一响应者。弹出键盘
        [TXView1.TF becomeFirstResponder];
    }
    
    
    [self.view addSubview:TXView1];
}
#pragma mark  密码输入结束后调用此方法
-(void)TXTradePasswordView:(TXTradePasswordView *)view WithPasswordString:(NSString *)Password
{
    NSLog(@"密码 = %@",Password);
    if (view.tag==1) {
        [TXView1 removeFromSuperview];
        firstPWD=Password;
        TXTradePasswordView *TXView = [[TXTradePasswordView alloc]initWithFrame:CGRectMake(0, 100,SCREEN_WIDTH, 200) WithTitle:@"请再次输入支付密码"];
        TXView.tag=2;
        TXView.TXTradePasswordDelegate = self;
        if (![TXView.TF becomeFirstResponder])
        {
            //成为第一响应者。弹出键盘
            [TXView.TF becomeFirstResponder];
        }
        
        
        [self.view addSubview:TXView];
    }
    else
    {
        secondPWD=Password;
        
        if (firstPWD&&secondPWD) {
            if ([firstPWD isEqualToString:secondPWD]) {
                [SVProgressHUD showWithStatus:@"正在保存。。" ];
                DataProvider * dataprovider=[[DataProvider alloc] init];
                [dataprovider setDelegateObject:self setBackFunctionName:@"SetPWDCallBack:"];
                [dataprovider setPasswordWithmember_id:get_sp(@"member_id") andwallet_password:secondPWD];
            }
        }
    }
    
}
-(void)SetPWDCallBack:(id)dict
{
    [SVProgressHUD dismiss];
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        [SVProgressHUD showSuccessWithStatus:@"支付密码保存成功" ];
        [self.navigationController popToViewController:self.fatherVC animated:YES];
        set_sp(@"wallet_password", secondPWD);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

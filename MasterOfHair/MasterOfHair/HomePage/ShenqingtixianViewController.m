
//
//  ShenqingtixianViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/29.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "ShenqingtixianViewController.h"

@interface ShenqingtixianViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextField * text_account;
@property (nonatomic, strong) UITextField * text_money;
@property (strong, nonatomic)  UITextView *TextV;
@property (nonatomic, strong) UILabel *fankuiLabel;
@property (nonatomic, strong) UIButton * btn_zhifu;

@end

@implementation ShenqingtixianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewAction:) ];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.view addGestureRecognizer:tapGesture];
    [self p_navi];
    
    [self p_setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tapViewAction:(id)sender
{
    [self.view endEditing:YES];
}

#pragma mark - navi
- (void)p_navi
{
    _lblTitle.text = [NSString stringWithFormat:@"申请提现"];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.text_money resignFirstResponder];
    
    [self.text_account resignFirstResponder];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView * view_1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 5, SCREEN_WIDTH, 50)];
    view_1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_1];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 30)];
    label1.text = @"到账支付宝";
    //    label1.backgroundColor = [UIColor orangeColor];
    [view_1 addSubview:label1];
    
    self.text_account = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(label1.frame) - 25, 30)];
    self.text_account.placeholder = @"请输入银行卡或支付宝账号";
    self.text_account.clearButtonMode = UITextFieldViewModeAlways;
    [view_1 addSubview:self.text_account];
    
    
    
    UIView * view_2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_1.frame) + 10, SCREEN_WIDTH, 50)];
    view_2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_2];
    
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 30)];
    label2.text = @"输入金额";
    //    label1.backgroundColor = [UIColor orangeColor];
    [view_2 addSubview:label2];
    
    self.text_money = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(label2.frame) - 25, 30)];
    self.text_money.placeholder = @"请输入提现金额";
    self.text_money.clearButtonMode = UITextFieldViewModeAlways;
    self.text_money.keyboardType = UIKeyboardTypeDecimalPad;
    [view_2 addSubview:self.text_money];
    
    UILabel * label_3 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(view_2.frame) + 10, 100, 20)];
    label_3.text = @"银行卡信息";
    label_3.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label_3];
    
    self.TextV=[[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label_3.frame) + 8, SCREEN_WIDTH, 100)];
    self.TextV.delegate=self;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH-10, 20)];
    
    label.enabled = NO;
    
    label.text = @"在此输入开户名、银行名称、开户行地址(支付宝账户无需填写本内容)...";
    
    label.font =  [UIFont systemFontOfSize:11];
    
    
    label.textColor = [UIColor lightGrayColor];
    
    self.fankuiLabel = label;
    
    [self.TextV addSubview:label];
    [self.view addSubview:self.TextV];
    
    self.btn_zhifu = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_zhifu.frame = CGRectMake(15, SCREEN_HEIGHT - 55, SCREEN_WIDTH - 30, 45);
    self.btn_zhifu.backgroundColor = navi_bar_bg_color;
    [self.btn_zhifu setTitle:@"申请提现" forState:(UIControlStateNormal)];
    [self.btn_zhifu setTintColor:[UIColor whiteColor]];
    self.btn_zhifu.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.btn_zhifu];
    
    [self.btn_zhifu addTarget:self action:@selector(btn_zhifuAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

#pragma mark textView 的代理方法
-(void) textViewDidChange:(UITextView *)textView {
    
    if (self.TextV.text.length == 0 ) {
        
        [self.fankuiLabel setHidden:NO];
        
    } else {
        
        [self.fankuiLabel setHidden:YES];
    }
}

#pragma mark - btn申请提现
- (void)btn_zhifuAction:(UIButton *)sender
{
    [self.text_money resignFirstResponder];
    [self.text_account resignFirstResponder];
    
    if([self.text_account.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入支付宝账号" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else if([self.text_money.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入提现金额" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else
    {
//        NSLog(@"走提现流程");
        
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        
        DataProvider * dataprovider=[[DataProvider alloc] init];
        
        [dataprovider setDelegateObject:self setBackFunctionName:@"create:"];
        if ([self JudgeIsPhoneNo:self.text_account.text]) {
            [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] record_type:@"2" change_type:@"2" alipay_account:self.text_account.text change_amount:self.text_money.text andremark:self.TextV.text andbank_account:@"" andwallet_password:@""];
        }
        else
        {
            [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] record_type:@"2" change_type:@"2" alipay_account:@"" change_amount:self.text_money.text andremark:self.TextV.text andbank_account:self.text_account.text andwallet_password:@""];
        }
        
        
        [SVProgressHUD showWithStatus:@"请稍等..." ];

    }
}

// 数据
- (void)create:(id )dict
{
    //    NSLog(@"%@",dict);
    [SVProgressHUD dismiss];
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"提现操作成功"  ];
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] ];
    }
}
-(BOOL)JudgeIsPhoneNo:(NSString *)str
{
    NSRange  range=[str rangeOfString:@"1"];
    if (range.length==1) {
        return YES;
    }
    range=[str rangeOfString:@"@"];
    if (range.length==1) {
        return YES;
    }
    return NO;
}

@end

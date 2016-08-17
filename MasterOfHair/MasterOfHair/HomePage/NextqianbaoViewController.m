//
//  NextqianbaoViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/30.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "NextqianbaoViewController.h"
#import "SetPayPwdViewController.h"
#import "TXTradePasswordView.h"

@interface NextqianbaoViewController () <UITextFieldDelegate,TXTradePasswordViewDelegate,UITextViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;
//
@property (nonatomic, strong) UITextField * text_account;

@property (nonatomic, strong) UIButton * btn_50;
@property (nonatomic, strong) UIButton * btn_100;
@property (nonatomic, strong) UIButton * btn_200;
@property (nonatomic, strong) UIButton * btn_500;
@property (nonatomic, strong) UIButton * btn_1000;

@property (nonatomic, strong) UIImageView * image_1;
@property (nonatomic, strong) UIImageView * image_2;
@property (nonatomic, strong) UIImageView * image_3;
@property (nonatomic, strong) UIImageView * image_4;
@property (nonatomic, strong) UIImageView * image_5;
@property (strong, nonatomic)  UITextView *TextV;
@property (nonatomic, strong) UILabel *fankuiLabel;


//
@property (nonatomic, strong) UIButton * btn_zhifu;

@end

@implementation NextqianbaoViewController
{
    NSArray * jine_array;
    UIView * view_white1;
    NSString *quxianJine;
    TXTradePasswordView *TXView;
    UIButton *btn_back;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    jine_array=[[NSArray alloc] initWithObjects:@"50",@"100",@"200",@"500",@"1000",@"2500",@"5000",@"10000",@"25000",@"50000", nil];
    quxianJine=@"";
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewAction:) ];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.view addGestureRecognizer:tapGesture];

    [self p_navi];
    
    [self p_setupView];
}

-(void)tapViewAction:(id)sender
{
    [self.view endEditing:YES];
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
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入银行卡或支付宝账号" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else if(quxianJine.length==0)
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
        
        if (get_sp(@"wallet_password")==nil) {
            SetPayPwdViewController * setPayPWD=[[SetPayPwdViewController alloc] init];
            setPayPWD.fatherVC=self;
            [self.navigationController pushViewController:setPayPWD animated:YES];
            return;
        }
        //输入支付密码
        TXView = [[TXTradePasswordView alloc]initWithFrame:CGRectMake(0, 100,SCREEN_WIDTH, 200) WithTitle:@"请再次输入支付密码"];
        TXView.tag=1;
        TXView.backgroundColor=[UIColor whiteColor];
        TXView.TXTradePasswordDelegate = self;
        if (![TXView.TF becomeFirstResponder])
        {
            //成为第一响应者。弹出键盘
            [TXView.TF becomeFirstResponder];
        }
        btn_back=[[UIButton alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
        btn_back.backgroundColor=[UIColor lightGrayColor];
        [self.view addSubview:btn_back];
        
        [self.view addSubview:TXView];
        
        return;
        
        

    }
}


-(void)TXTradePasswordView:(TXTradePasswordView *)view WithPasswordString:(NSString *)Password
{
    [btn_back removeFromSuperview];
    [TXView removeFromSuperview];
    if ([Password isEqualToString:get_sp(@"wallet_password")]) {
        
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        
        DataProvider * dataprovider=[[DataProvider alloc] init];
        
        [dataprovider setDelegateObject:self setBackFunctionName:@"create:"];
        if ([self JudgeIsPhoneNo:self.text_account.text]) {
            [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] record_type:@"1" change_type:@"2" alipay_account:self.text_account.text change_amount:quxianJine andremark:self.TextV.text andbank_account:@"" andwallet_password:Password];
        }
        else
        {
            [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] record_type:@"1" change_type:@"2" alipay_account:@"" change_amount:quxianJine andremark:self.TextV.text andbank_account:self.text_account.text andwallet_password:Password];
        }
        
        
        
        
        
        [SVProgressHUD showWithStatus:@"请稍等..." ];
    }
    else
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付密码不正确" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
        return;
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
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] ];
    }
}



#pragma mark - scrollView布局
- (void)p_scrollView
{
    UIView * view_white = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 50)];
    view_white.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white];
    
    UILabel * label_1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 60, 30)];
    label_1.text = @"到账账户";
    label_1.font = [UIFont systemFontOfSize:15];
//    label_1.backgroundColor = [UIColor orangeColor];
    [view_white addSubview:label_1];
    
    self.text_account = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_1.frame) + 15, 10, SCREEN_WIDTH - CGRectGetMaxX(label_1.frame) - 25, 30)];
    self.text_account.delegate = self;
    self.text_account.placeholder = @"请输入银行卡或支付宝账号";
    self.text_account.font = [UIFont systemFontOfSize:15];
    self.text_account.clearButtonMode = UITextFieldViewModeAlways;
    [view_white addSubview:self.text_account];
    
    
    
    UILabel * label_3 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(view_white.frame) + 10, 100, 15)];
    label_3.text = @"银行卡信息";
    label_3.font = [UIFont systemFontOfSize:13];
    [self.scrollView addSubview:label_3];
    
    self.TextV=[[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label_3.frame) + 8, SCREEN_WIDTH, 100)];
    self.TextV.delegate=self;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH-10, 20)];
    
    label.enabled = NO;
    
    label.text = @"在此输入开户名、银行名称、开户行地址(支付宝账户无需填写本内容)...";
    
    label.font =  [UIFont systemFontOfSize:11];
    
    
    label.textColor = [UIColor lightGrayColor];
    
    self.fankuiLabel = label;
    
    [self.TextV addSubview:label];
    
    
//#warning 这个不确定
//    UIView * view_white2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label_3.frame) + 8, SCREEN_WIDTH, 100)];
//    view_white2.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.TextV];
    
    
    UILabel * lable_2 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.TextV.frame) + 10, 100, 15)];
    lable_2.text = @"选择提现金额";
    lable_2.font = [UIFont systemFontOfSize:13];
    [self.scrollView addSubview:lable_2];
    
    
    view_white1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lable_2.frame) + 8, SCREEN_WIDTH, 260)];
    view_white1.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white1];
    
    CGFloat btn_with=(SCREEN_WIDTH-30)/2;
    for (int i=0; i<jine_array.count; i++) {
        UIButton* btn_50 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        btn_50.bounds = CGRectMake(0, 0, btn_with, 40);
        btn_50.backgroundColor = [UIColor groupTableViewBackgroundColor];
        btn_50.center=CGPointMake((i%2)==0?SCREEN_WIDTH/4:SCREEN_WIDTH/4*3, 30+50*(i/2));
        btn_50.layer.cornerRadius = 5;
        [btn_50 setTitle:[NSString stringWithFormat:@"%@元",jine_array[i]] forState:(UIControlStateNormal)];
        [btn_50 setTitle:[NSString stringWithFormat:@"%@元",jine_array[i]] forState:(UIControlStateSelected)];
        [btn_50 setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [btn_50 setTitleColor:_topView.backgroundColor forState:(UIControlStateSelected)];
        [btn_50 setBackgroundImage:[UIImage imageNamed:@"xuankuang-0"] forState:UIControlStateSelected];
        [view_white1 addSubview:btn_50];
        [btn_50 addTarget:self action:@selector(btn_50Action:) forControlEvents:(UIControlEventTouchUpInside)];
        btn_50.selected = NO;
        btn_50.tag=i;

    }
    
    
    
    
    self.scrollView.contentSize = CGSizeMake(0, 500);

}

#pragma mark - 5中金额
- (void)btn_50Action:(UIButton *)sender
{
    [self.text_account resignFirstResponder];

    [sender setTintColor:[UIColor groupTableViewBackgroundColor]];
    
    if(sender.isSelected == 0)
    {
        sender.selected = 1;
        for (id item in view_white1.subviews) {
            if ([item isKindOfClass:[UIButton class]]&&![item isEqual:sender]) {
                UIButton * btn_item=(UIButton *)item;
                btn_item.selected=NO;
            }
        }
        quxianJine=jine_array[sender.tag];
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

#pragma mark textView 的代理方法
-(void) textViewDidChange:(UITextView *)textView {
    
    if (self.TextV.text.length == 0 ) {
        
        [self.fankuiLabel setHidden:NO];
        
    } else {
        
        [self.fankuiLabel setHidden:YES];
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

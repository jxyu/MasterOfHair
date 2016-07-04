//
//  WenxiulianmengDetailViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/3/17.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "WenxiulianmengDetailViewController.h"
#import "Pingpp.h"
@interface WenxiulianmengDetailViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton * btn_zhifu;

@property (nonatomic, strong) UIButton * btn_zhifubo;
@property (nonatomic, strong) UIButton * btn_weixin;

@property (nonatomic, strong) UILabel * name;

@property (nonatomic, strong) UILabel * price;

@property (nonatomic, strong) UILabel * old_price;

@property (nonatomic, strong) UITextField * text_money;

@end

@implementation WenxiulianmengDetailViewController

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
    
    UIView * view_1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 10, SCREEN_WIDTH, 50)];
    view_1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_1];
    
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, (SCREEN_WIDTH - 30) / 3 * 2, 30)];
    self.name.text = @"课程名称";
    [view_1 addSubview:self.name];
    
    self.old_price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.name.frame) + 5, 10, (SCREEN_WIDTH - 30) / 3, 30)];
    self.old_price.textAlignment = NSTextAlignmentRight;
    self.old_price.text = @"100元";
    [view_1 addSubview:self.old_price];
    
    
    
    UIView * view_2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_1.frame) + 2, SCREEN_WIDTH, 50)];
    view_2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_2];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 50, 30)];
    label.text = @"技师:";
    [view_2 addSubview:label];
    
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(label.frame) - 20, 30)];
    self.price.text = @"5000元";
//    self.price.textColor = [UIColor orangeColor];
    self.price.textAlignment = NSTextAlignmentLeft;
    [view_2 addSubview:self.price];
    
    UIView * view_4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_2.frame) + 5, SCREEN_WIDTH, 50)];
    view_4.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_4];
    
    UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 70, 30)];
    label3.text = @"实际支付";
    [view_4 addSubview:label3];
    
    self.text_money = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(label3.frame) - 20, 30)];
    self.text_money.placeholder = @"请输入实际支付金额";
    self.text_money.delegate = self;
    [view_4 addSubview:self.text_money];
    
    
    UIView * view_3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_4.frame) + 10, SCREEN_WIDTH, 70)];
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
    [self.btn_zhifu setTitle:@"确认支付" forState:(UIControlStateNormal)];
    [self.btn_zhifu setTintColor:[UIColor whiteColor]];
    self.btn_zhifu.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.btn_zhifu];
    
    [self.btn_zhifu addTarget:self action:@selector(btn_zhifuAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //赋值
    self.name.text = self.model_baocun2.product_name;
    self.old_price.text = [NSString stringWithFormat:@"%@元",self.model_baocun2.product_price];
    
    self.price.text = self.model_baocun1.technician_name;
}

#pragma mark - 支付
- (void)btn_zhifuAction:(UIButton *)sender
{
    if([self.text_money.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"实际支付金额不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else if(self.btn_zhifubo.selected == 0 && self.btn_weixin.selected == 0)
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
//        NSLog(@"走支付流程");
                
        //调接口，
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        
        if(self.btn_weixin.selected == 0)
        {
            DataProvider * dataprovider=[[DataProvider alloc] init];
            [dataprovider setDelegateObject:self setBackFunctionName:@"create:"];
            
            [dataprovider createWithStore_id:self.model_baocun2.store_id member_id:[userdefault objectForKey:@"member_id"] product_id:self.model_baocun2.product_id technician_id:self.model_baocun1.technician_id order_payable:self.model_baocun2.product_price order_realpay:self.text_money.text union_order_status:@"1" pay_method:@"2"];
            [SVProgressHUD showWithStatus:@"请稍等..." ];

        }
        else
        {
            DataProvider * dataprovider=[[DataProvider alloc] init];
            [dataprovider setDelegateObject:self setBackFunctionName:@"create:"];
            
            [dataprovider createWithStore_id:self.model_baocun2.store_id member_id:[userdefault objectForKey:@"member_id"] product_id:self.model_baocun2.product_id technician_id:self.model_baocun1.technician_id order_payable:self.model_baocun2.product_price order_realpay:self.text_money.text union_order_status:@"1" pay_method:@"3"];
            [SVProgressHUD showWithStatus:@"请稍等..." ];

        }
    }
}

#pragma mark - 支付
- (void)create:(id )dict
{
    //    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];
    
    if (dict[@"charge"] != nil)
    {
        @try
        {
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict[@"charge"] options:NSJSONWritingPrettyPrinted error:nil];
            NSString* str_data = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            [Pingpp createPayment:str_data
                   viewController:self
                     appURLScheme:@"MasterOfHair.zykj"
                   withCompletion:^(NSString *result, PingppError *error) {
                       if ([result isEqualToString:@"success"]) {
                           // 支付成功
                           [self.navigationController popViewControllerAnimated:YES];
                           [SVProgressHUD showSuccessWithStatus:@"支付成功~" ];
                       } else {
                           // 支付失败或取消
                           NSLog(@"Error: code=%lu msg=%@", (unsigned long)error.code, [error getMsg]);
                           [SVProgressHUD showErrorWithStatus:@"支付失败~" ];
                       }
                   }];
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
//        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] ];
    }
}



- (void)btn_zhifuboAction:(UIButton *)sender
{
    [self.text_money resignFirstResponder];

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
    [self.text_money resignFirstResponder];

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



#pragma mark - 点击
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.text_money resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end

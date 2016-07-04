//
//  JinkahuiyuanViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/2.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "JinkahuiyuanViewController.h"
#import "Pingpp.h"
#import <StoreKit/StoreKit.h>
#import "SvUDIDTools.h"
@interface JinkahuiyuanViewController ()<SKPaymentTransactionObserver,SKProductsRequestDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UILabel * price;
//账号
@property (nonatomic, strong) UILabel * accent;

@property (nonatomic, strong) UIButton * btn_zhifubo;
@property (nonatomic, strong) UIButton * btn_weixin;

//开通
@property (nonatomic, strong) UIButton * btn_zhifu;

@end

@implementation JinkahuiyuanViewController
{
    NSString * productIdentifier;//内付费购买凭证
    
    NSString *buyprice;
    
    NSString *uuid;
    
    BOOL islogin;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    uuid= [SvUDIDTools UDID];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    islogin=YES;
    if ([get_sp(@"member_id") length] == 0) {
        islogin=NO;
        UIAlertView * alertview=[[UIAlertView alloc] initWithTitle:@"活动期间开通金卡会员" message:@"登录剃头匠账号购买，可跨平台享受会员权益，直接购买，会为当前设备开通会员" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"直接购买",@"登录剃头匠账号购买", nil];
        [alertview show];
    }
    
    
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
    
    UILabel * label_1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 30)];
    label_1.text = @"金卡会员";
    [view_1 addSubview:label_1];
    
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_1.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(label_1.frame) - 20, 30)];
    self.price.text = @"¥98.00";
    self.price.textAlignment = NSTextAlignmentRight;
    [view_1 addSubview:self.price];
    
    
    UIView * view_2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_1.frame) + 2, SCREEN_WIDTH, 50)];
    view_2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_2];
    
    UILabel * label_3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 30)];
    label_3.text = @"账号:";
    [view_2 addSubview:label_3];
    
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];

    self.accent = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_3.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(label_3.frame) - 20, 30)];
    self.accent.text = [userdefault objectForKey:@"member_username"];
    self.accent.textAlignment = NSTextAlignmentRight;
    [view_2 addSubview:self.accent];

    
    
//    UIView * view_3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_2.frame) + 15, SCREEN_WIDTH, 70)];
//    view_3.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:view_3];
//    
//    UILabel * label_2 = [[UILabel alloc] initWithFrame:CGRectMake(13, 10, SCREEN_WIDTH - 15, 15)];
//    label_2.text = @"选择支付方式";
//    label_2.textColor = [UIColor grayColor];
//    label_2.font = [UIFont systemFontOfSize:13];
//    [view_3 addSubview:label_2];
//    
//    CGFloat length_x = SCREEN_WIDTH / 3;
//    //支付宝支付
//    self.btn_zhifubo = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    self.btn_zhifubo.frame = CGRectMake(15, CGRectGetMaxY(label_2.frame) + 10, 25, 25);
//    //    self.btn_zhifubo.backgroundColor = [UIColor orangeColor];
//    self.btn_zhifubo.selected = 0;
//    [view_3 addSubview:self.btn_zhifubo];
//    [self.btn_zhifubo addTarget:self action:@selector(btn_zhifuboAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.btn_zhifubo setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
//    
//    UILabel * label_myPurse = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.btn_zhifubo.frame) + 5, CGRectGetMaxY(label_2.frame) + 7.5, length_x - CGRectGetMaxX(self.btn_zhifubo.frame) - 5, 30)];
//    //    label_myPurse.backgroundColor = [UIColor orangeColor];
//    label_myPurse.text = @"支付宝支付";
//    label_myPurse.font = [UIFont systemFontOfSize:12];
//    [view_3 addSubview:label_myPurse];
//    
//    //微信支付
//    self.btn_weixin = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    self.btn_weixin.frame = CGRectMake(30 + length_x, CGRectGetMaxY(label_2.frame) + 10, 25, 25);
//    //    self.btn_weixin.backgroundColor = [UIColor orangeColor];
//    self.btn_weixin.selected = 0;
//    [view_3 addSubview:self.btn_weixin];
//    [self.btn_weixin addTarget:self action:@selector(btn_weixinAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.btn_weixin setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
//    
//    UILabel * label_zhifubo = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.btn_weixin.frame) + 5, CGRectGetMaxY(label_2.frame) + 7.5, length_x - CGRectGetMaxX(self.btn_zhifubo.frame) , 30)];
//    //    label_zhifubo.backgroundColor = [UIColor orangeColor];
//    label_zhifubo.text = @"微信支付";
//    label_zhifubo.font = [UIFont systemFontOfSize:12];
//    [view_3 addSubview:label_zhifubo];
//    
    
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
//    if(self.btn_zhifubo.selected == 0 && self.btn_weixin.selected == 0)
//    {
//        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择支付方式" preferredStyle:(UIAlertControllerStyleAlert)];
//        
//        [self presentViewController:alert animated:YES completion:^{
//            
//        }];
//        
//        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        
//        [alert addAction:action];
//    }
//    else
//    {
////        NSLog(@"走支付流程, 获得权限");
//        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
//        
//        DataProvider * dataprovider=[[DataProvider alloc] init];
//        [dataprovider setDelegateObject:self setBackFunctionName:@"dingdanzhifu:"];
//        
//        if(self.btn_weixin.selected == 1)
//        {
//            [dataprovider upgradeRecordWithMember_id:[userdefault objectForKey:@"member_id"] pay_total:@"199" pay_method:@"2"];
//        }
//        else
//        {
//            [dataprovider upgradeRecordWithMember_id:[userdefault objectForKey:@"member_id"] pay_total:@"199" pay_method:@"1"];
//        }
//        
//        [SVProgressHUD showWithStatus:@"请稍等..." ];
//    }
    [self getProductInfo];
}


#pragma mark - 支付
- (void)dingdanzhifu:(id )dict
{
    //    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict[@"data"][@"charge"] options:NSJSONWritingPrettyPrinted error:nil];
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
            
            NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
            [userdefault setObject:@"2" forKey:@"member_type"];

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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        if ([SKPaymentQueue canMakePayments]) {
            // 执行下面提到的第5步：
            [self getProductInfo];
        } else {
            NSLog(@"失败，用户禁止应用内付费购买.");
        }
    }
    else if (buttonIndex==2)
    {
        LoginViewController * loginViewController = [[LoginViewController alloc] init];
        
        [self showViewController:loginViewController sender:nil];
    }
}

#pragma mark 内付费开始
// 下面的ProductId应该是事先在itunesConnect中添加好的，已存在的付费项目。否则查询会失败。
- (void)getProductInfo {
        [SVProgressHUD showWithStatus:@"正在请求产品数据.." ];
//        NSSet * set = [NSSet setWithArray:@[@"titoujiang_jinkahuiyuan"]];（正常金卡会员）
    NSSet * set = [NSSet setWithArray:@[@"huodongjinkahuiyuan"]];//活动期间金卡会员
        SKProductsRequest * request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
        request.delegate = self;
        [request start];
}
// 以上查询的回调函数
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    [SVProgressHUD dismiss];
    NSArray *myProduct = response.products;
    if (myProduct.count == 0) {
        NSLog(@"无法获取产品信息，购买失败。");
        return;
    }
    SKPayment * payment = [SKPayment paymentWithProduct:myProduct[0]];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    [SVProgressHUD showWithStatus:@"正在进行验证.." ];
}
- (void)viewDidUnload {
    [super viewDidUnload];
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    [SVProgressHUD dismiss];
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased://交易完成
                NSLog(@"transactionIdentifier = %@", transaction.transactionIdentifier);
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed://交易失败
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored://已经购买过该商品
                [self restoreTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchasing:      //商品添加进列表
                NSLog(@"商品添加进列表");
                break;
            default:
                break;
        }
    }
}
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    // Your application should implement these two methods.
    productIdentifier = transaction.payment.productIdentifier;
    if ([productIdentifier length] > 0) {
        
        [SVProgressHUD dismiss];
        // 向自己的服务器验证购买凭证
        [self JumpToPaySuccess:transaction];
    }
    // Remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    [SVProgressHUD dismiss];
    if(transaction.error.code != SKErrorPaymentCancelled) {
        NSLog(@"购买失败");
    } else {
        NSLog(@"用户取消交易");
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    // 对于已购商品，处理恢复购买的逻辑
    [SVProgressHUD dismiss];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}
#pragma mark 内付费结束

-(void)JumpToPaySuccess:(SKPaymentTransaction *)transaction
{
    [SVProgressHUD showWithStatus:@"正在等待服务器验证" ];
    DataProvider *dataProvider = [[DataProvider alloc] init];
    [dataProvider setDelegateObject:self setBackFunctionName:@"becomeVipCallBack:"];
    if (uuid.length<=0) {
        uuid=[[NSUUID UUID] UUIDString];
    }
    [dataProvider AppleVerifyWithmenber_id:get_sp(@"menber_id")==nil?@"0":get_sp(@"menber_id")andverify_code:transaction.transactionReceipt anduuid:uuid andtype:@"2"];
    
    /// [self popoverPresentationController];
}
-(void)becomeVipCallBack:(id)dict
{
    [SVProgressHUD dismiss];
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        set_sp(@"member_type", @"2");
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"恭喜您，已成为金卡会员" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action_cancel=[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action_cancel];
    }
    else
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"抱歉，由于网络原因服务器对您的购买凭证验证失败，请耐心等待" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action_cancel=[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action_cancel];
    }
}

@end

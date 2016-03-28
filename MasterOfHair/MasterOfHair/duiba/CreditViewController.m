//
//  CreditViewController.m
//  duiba-sdk
//
//  Created by xuhengfei on 14-6-13.
//  Copyright (c) 2014年 duiba. All rights reserved.
//

#import "CreditViewController.h"
#import "CreditWebViewController.h"
#import "CreditNavigationController.h"
@interface CreditViewController ()<UIAlertViewDelegate>

@property (nonatomic,strong) NSDictionary *loginData;

@end

@implementation CreditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title=@"个人中心";
    
    //添加分享按钮的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDuibaShareClick:) name:@"duiba-share-click" object:nil];
    //添加登录按钮的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDuibaLoginClick:) name:@"duiba-login-click" object:nil];
}
-(void)viewDidAppear:(BOOL)animated{
    
    
    if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars =NO;
    }
    if([self respondsToSelector:@selector(setModalPresentationCapturesStatusBarAppearance:)]){
        self.modalPresentationCapturesStatusBarAppearance =NO;
    }
    if([self respondsToSelector:@selector(navigationController)]){
        if([self.navigationController.navigationBar respondsToSelector:@selector(setTranslucent:)]){
            self.navigationController.navigationBar.translucent =NO;
        }
    }
    
    
    
    UIImage *image=[UIImage imageNamed:@"snapshot"];
    UIImageView *imageView=[[UIImageView alloc]initWithImage:image];
    [self.view addSubview:imageView];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"enter"] forState:UIControlStateNormal];
    btn.frame=CGRectMake(320-40-70, 60, 70, 27);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
    [btn.layer setBorderColor:colorref];
    [btn.layer setBorderWidth:2.0];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    
}

-(void)enter{
    
    //
    //  PushViewController的方式
    //  如果已经有UINavigationContoller了，就 创建出一个 CreditWebViewController 然后 push 进去
    //
    //
    CreditWebViewController *web=[[CreditWebViewController alloc]initWithUrl:@"http://www.duiba.com.cn/test/demoRedirectSAdfjosfdjdsa"];//实际中需要改为开发者服务器的地址，开发者服务器再重定向到一个带签名的自动登录地址
    [self.navigationController pushViewController:web animated:YES];
    
    //
    //  PresentViewController 的方式
    //  如果没有UINavigationController，就创建一个 CreditNavigationController 然后 present 出来
    //
    /*
     CreditWebViewController *web=[[CreditWebViewController alloc]initWithUrlByPresent:@"http://www.duiba.com.cn/test/demoRedirectSAdfjosfdjdsa"]
     CreditNavigationController *nav=[[CreditNavigationController alloc]initWithRootViewController:web];
     [nav setNavColorStyle:[UIColor colorWithRed:195/255.0 green:0 blue:19/255.0 alpha:1]];
     [self presentViewController:nav animated:YES completion:nil];
     */
    
    
    
}
//当兑吧页面内点击登录时，会调用此处函数
//请在此处弹出登录层，进行登录处理
//登录成功后，请从dict拿到当前页面currentUrl
//让服务器端重新生成一次自动登录地址，并附带redirect=currentUrl参数
//使用新生成的自动登录地址，让webView重新进行一次加载
-(void)onDuibaLoginClick:(NSNotification *)notify{
    self.loginData=notify.userInfo;
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"请登陆" message:@"作为演示，登陆成功后将跳转至百度\n实际中请跳转正确的地址" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登陆", nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert show];
    
    
    
}
-(void)onDuibaShareClick:(NSNotification *)notify{
    NSDictionary *dict=notify.userInfo;
    NSString *shareUrl=[dict objectForKey:@"shareUrl"];//分享url
    NSString *shareTitle=[dict objectForKey:@"shareTitle"];//标题
    NSString *shareThumbnail=[dict objectForKey:@"shareThumbnail"];//缩略图
    NSString *shareSubTitle=[dict objectForKey:@"shareSubtitle"];//副标题
    
    NSString *message=@"";
    message=[message stringByAppendingFormat:@"分享地址:%@ \n 分享标题:%@ \n分享图:%@ \n分享副标题:%@",shareUrl,shareTitle,shareThumbnail,shareSubTitle];
    
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"捕获到分享点击" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex==1){
        NSLog(@"currentUrl=%@",[self.loginData objectForKey:@"currentUrl"]);
        CreditWebView *webView=[self.loginData objectForKey:@"webView"];
        
        //登录成功后，刷新当前页面
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://baidu.com"]]];
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden{
    return NO;
}
@end

//
//  AppDelegate.m
//  MasterOfHair
//
//  Created by 于金祥 on 16/1/19.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "AppDelegate.h"

#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/Extend/SMSSDK+AddressBookMethods.h>
#import <ALBBQuPaiPlugin/ALBBQuPaiPlugin.h>


#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"

#import "Pingpp.h"

#import "DataProvider.h"
#import "SvUDIDTools.h"

#define SMSapp_Key @"f7f43b8dec0c"
#define SMSapp_Secret @"b58371f4502b0e800e461a27328e0ba8"

#define kQPAppKey @"205425099e62995"
#define kQPAppSecret @"fcac9d83d3b94d6c8287bef7993768e6"

#define APIKey @"56e8cf6867e58ea9710004b8"


@interface AppDelegate ()

@end

@implementation AppDelegate

//Code Singing Entitle                 MasterOfHair/KeychainAccessGroups.plist
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRootView1:) name:@"changeRootView1" object:nil];
    
    
    if (!get_Bsp(@"IsShowVIP")) {
        DataProvider * dataprovider=[[DataProvider alloc] init];
        [dataprovider setDelegateObject:self setBackFunctionName:@"IsShowVIPCallBack:"];
        [dataprovider IsShowVIP];
    }
    
    
    
    
    
    
/**
 *  短信设置
 */
    [SMSSDK registerApp:SMSapp_Key withSecret:SMSapp_Secret];
    //不允许访问通讯录
    [SMSSDK enableAppContactFriends:NO];

/**
 *  注册趣拍
 */
    [[QupaiSDK shared] registerAppWithKey:kQPAppKey secret:kQPAppSecret space:@"space" success:^(NSString *accessToken) {
        [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"accessToken"];
    } failure:^(NSError *error) {
        
    }];
/**
 *  友盟
 */
    [UMSocialData setAppKey:APIKey];
    
    //wx
    [UMSocialWechatHandler setWXAppId:@"wxbbedabd1c20c8942" appSecret:@"4a8c42aeeca6c86bd84de31e4076903a" url:ShartUrl(get_sp(@"member_id"))];
    
    //qq
    [UMSocialQQHandler setQQWithAppId:@"1105204231" appKey:@"qWWW6hLM0JDnxvN6" url:ShartUrl(get_sp(@"member_id"))];
    
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
    
    
    [self InitTabBarUI];
    
    return YES;
}
-(void)IsShowVIPCallBack:(id)dict
{
    DLog(@"%@",dict);
    if ([dict[@"status"][@"succeed"] intValue]==1) {
        if ([dict[@"data"][@"flag"] intValue]==1) {
            set_Bsp(@"IsShowVIP", YES);
        }
        else
        {
            set_Bsp(@"IsShowVIP", NO);
        }
    }
    else
    {
        set_Bsp(@"IsShowVIP", NO);
    }
}

-(void)requestCallBack:(id)dict
{
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        NSArray * itemarry=dict[@"data"][@"rightlist"];
        if (itemarry.count!=0) {
            if ([dict[@"data"][@"rightlist"][0][@"type"] intValue]==1) {
                set_sp(@"videozhifu_ok", @"1");
            }
            else if ([dict[@"data"][@"rightlist"][0][@"type"] intValue]==1)
            {
                set_sp(@"member_type", @"2");
            }
        }
        
    }
}

-(void)InitTabBarUI
{
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"requestCallBack:"];
    
    [dataprovider GetRightList:[SvUDIDTools UDID]];
    /**
     设置根VC
     */
//    _loginViewCtl = [[LoginViewController alloc] init];
    
    _firstCol=[[FirstScrollController alloc]init];
    
    _tabBarViewCol = [[CustomTabBarViewController alloc] init];
    
    if(self.window == nil)
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds] ];
    
    [self.window makeKeyAndVisible];
    
//    NSUserDefaults *mUserDefault = [NSUserDefaults standardUserDefaults];
    
//    NSString *mRegistAcount = [mUserDefault valueForKey:LogIn_UserID_key];
    
//    NSString *mRegistPwd = [mUserDefault valueForKey:LogIn_UserPass_key];
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]) {
        self.window.rootViewController =_tabBarViewCol;
//        self.window.rootViewController =_tabBarViewCol;
        
//        if((mRegistAcount == nil||[mRegistAcount isEqualToString:@"" ])||(mRegistPwd == nil || [mRegistPwd isEqualToString:@"" ]))
//        {
//            self.window.rootViewController = _loginViewCtl;
//        }
//        else
//        {
//            self.window.rootViewController = _tabBarViewCol;
//            
//            [self TryLoginFun];
//            
//        }
        
    }
    else
    {
        self.window.rootViewController =_firstCol;
        [self.window makeKeyAndVisible];
        //[self getAliPay];
    }
}
-(void)changeRootView1:(id)sender
{
    self.window.rootViewController = _tabBarViewCol;
    return;
}

//#pragma mark - 友盟回调
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    BOOL result = [UMSocialSnsService handleOpenURL:url];
//    if (result == FALSE) {
//        //调用其他SDK，例如支付宝SDK等
//    }
//    return result;
//}

//iOS 8 及以下

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
    return canHandleURL;
}

//iOS 9 及以上

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options {
    BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
    return canHandleURL;
}


#pragma mark - 隐藏tabBar

- (void)showTabBar
{
    [_tabBarViewCol showTabBar];
}

- (void)hiddenTabBar
{
    [_tabBarViewCol hideCustomTabBar];
}

- (void)selectTableBarIndex:(NSInteger)index
{
    [_tabBarViewCol selectTableBarIndex:index];
}


#pragma mark - 活跃和释放活跃状态
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

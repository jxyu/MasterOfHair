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

#define SMSapp_Key @"f7f43b8dec0c"
#define SMSapp_Secret @"b58371f4502b0e800e461a27328e0ba8"
#define kQPAppKey @"205425099e62995"
#define kQPAppSecret @"fcac9d83d3b94d6c8287bef7993768e6"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self InitTabBarUI];
    
/**
 *  短信设置
 */
    [SMSSDK registerApp:SMSapp_Key withSecret:SMSapp_Secret];
    //不允许访问通讯录
    [SMSSDK enableAppContactFriends:NO];

    //注册趣拍
    [[QupaiSDK shared] registerAppWithKey:kQPAppKey secret:kQPAppSecret space:@"space" success:^(NSString *accessToken) {
        [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"accessToken"];
    } failure:^(NSError *error) {
        
    }];
    
    return YES;
}

-(void)InitTabBarUI
{
    /**
     设置根VC
     */
//    _loginViewCtl = [[LoginViewController alloc] init];
    
//    firstCol=[[FirstScrollController alloc]init];
    
    _tabBarViewCol = [[CustomTabBarViewController alloc] init];
    
    if(self.window == nil)
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds] ];
    
    [self.window makeKeyAndVisible];
//    mUserDefault = [NSUserDefaults standardUserDefaults];
//    NSString *mRegistAcount = [mUserDefault valueForKey:LogIn_UserID_key];
//    NSString *mRegistPwd = [mUserDefault valueForKey:LogIn_UserPass_key];
    self.window.rootViewController =_tabBarViewCol;
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]) {
        
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
//        self.window.rootViewController =firstCol;
        
        [self.window makeKeyAndVisible];
        //[self getAliPay];
        
    
    }
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

//
//  AppDelegate.m
//  MasterOfHair
//
//  Created by 于金祥 on 16/1/19.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [self InitTabBarUI];
    
    
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

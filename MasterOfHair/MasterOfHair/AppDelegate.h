//
//  AppDelegate.h
//  MasterOfHair
//
//  Created by 于金祥 on 16/1/19.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBarViewController.h"
#import "FirstScrollController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) CustomTabBarViewController *tabBarViewCol;
@property (nonatomic,strong) FirstScrollController *firstCol;

- (void)showTabBar;
- (void)hiddenTabBar;
- (void)selectTableBarIndex:(NSInteger)index;

@end


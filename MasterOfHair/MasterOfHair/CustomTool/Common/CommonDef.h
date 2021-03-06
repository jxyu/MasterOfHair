//
//  CommenDef.h
//  shMetro3.0
//
//  Created by syzhou on 13-4-12.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#ifndef BestOne_CommonDef_h
#define BestOne_CommonDef_h


//外网地址
#define Url @"http://www.58titoujiang.com/index.php?r=api/"
#define Url_pic @"http://www.58titoujiang.com/"


//东东
//#define Url @"http://192.168.1.245/titoujiang/index.php?r=api/"
//#define Url_pic @"http://192.168.1.245/titoujiang/"





#define NavigationBar_HEIGHT 44
#define StatusBar_HEIGHT 20
#define TabBar_HEIGHT 49



#define Header_Height   (NavigationBar_HEIGHT + StatusBar_HEIGHT)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SAFE_RELEASE(x) [x release];x=nil
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])


#define remove_sp(a) [[NSUserDefaults standardUserDefaults] removeObjectForKey:a]
#define get_sp(a) [[NSUserDefaults standardUserDefaults] objectForKey:a]
#define get_Bsp(a) [[NSUserDefaults standardUserDefaults] boolForKey:a]
#define get_Dsp(a) [[NSUserDefaults standardUserDefaults]dictionaryForKey:a]
#define set_sp(a,b) [[NSUserDefaults standardUserDefaults] setObject:b forKey:a]
#define set_Bsp(a,b) [[NSUserDefaults standardUserDefaults] setBool:b forKey:a]
#define sp [NSUserDefaults standardUserDefaults]
#define img(a) [UIImage imageNamed:a]
#define _app_ ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define USER_ID @"id"
#define TEAM_ID @"TeamId"

#define navi_bar_bg_color   [UIColor colorWithRed:153/255.0 green:205/255.0 blue:255/255.0 alpha:1.0]
#define BACKGROUND_COLOR [UIColor colorWithRed:232/255.0 green:235/255.0 blue:240/255.0 alpha:1.0]
#define ItemsBaseColor  [UIColor colorWithRed:0x29/255.0 green:0x2a/255.0 blue:0x2f/255.0 alpha:1.0]
#define Separator_Color [UIColor colorWithRed:0x81/255.0 green:0x81/255.0 blue:0x81/255.0 alpha:1.0]
#define YellowBlock     [UIColor colorWithRed:0xef/255.0 green:0x9c/255.0 blue:0x00/255.0 alpha:1.0]

#define RGB(a, b, c) [UIColor colorWithRed:(a) / 255.0 green:(b) / 255.0 blue:(c) / 255.0 alpha:1.0]

#define ShartUrl(a) [NSString stringWithFormat:@"http://www.58titoujiang.com/index.php?r=api/web/spread&member_id=%@&client=ios",a] 


#ifndef DEBUG
#define DEBUG  //开启debug
#endif


//use dlog to print while in debug model
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)



#pragma mark - Error code Define 
#define OK          0
#define Param_err   -1







#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


//ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif


//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]



#pragma mark - common functions
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }


#pragma mark - degrees/radian functions
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define ITTDEBUG
#define ITTLOGLEVEL_INFO     10
#define ITTLOGLEVEL_WARNING  3
#define ITTLOGLEVEL_ERROR    1

#ifndef ITTMAXLOGLEVEL

#ifdef DEBUG
#define ITTMAXLOGLEVEL ITTLOGLEVEL_INFO
#else
#define ITTMAXLOGLEVEL ITTLOGLEVEL_ERROR
#endif

#endif

// The general purpose logger. This ignores logging levels.
#ifdef ITTDEBUG
#define ITTDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ITTDPRINT(xx, ...)  ((void)0)
#endif

// Prints the current method's name.
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

// Log-level based logging macros.
#if ITTLOGLEVEL_ERROR <= ITTMAXLOGLEVEL
#define ITTDERROR(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDERROR(xx, ...)  ((void)0)
#endif

#if ITTLOGLEVEL_WARNING <= ITTMAXLOGLEVEL
#define ITTDWARNING(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDWARNING(xx, ...)  ((void)0)
#endif

#if ITTLOGLEVEL_INFO <= ITTMAXLOGLEVEL
#define ITTDINFO(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDINFO(xx, ...)  ((void)0)
#endif

#ifdef ITTDEBUG
#define ITTDCONDITIONLOG(condition, xx, ...) { if ((condition)) { \
ITTDPRINT(xx, ##__VA_ARGS__); \
} \
} ((void)0)
#else
#define ITTDCONDITIONLOG(condition, xx, ...) ((void)0)
#endif

#define ITTAssert(condition, ...)                                       \
do {                                                                      \
if (!(condition)) {                                                     \
[[NSAssertionHandler currentHandler]                                  \
handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
file:[NSString stringWithUTF8String:__FILE__]  \
lineNumber:__LINE__                                  \
description:__VA_ARGS__];                             \
}                                                                       \
} while(0)



#define _po(o) DLOG(@"%@", (o))
#define _pn(o) DLOG(@"%d", (o))
#define _pf(o) DLOG(@"%f", (o))
#define _ps(o) DLOG(@"CGSize: {%.0f, %.0f}", (o).width, (o).height)
#define _pr(o) DLOG(@"NSRect: {{%.0f, %.0f}, {%.0f, %.0f}}", (o).origin.x, (o).origin.x, (o).size.width, (o).size.height)

#define DOBJ(obj)  DLOG(@"%s: %@", #obj, [(obj) description])

#define MARK    NSLog(@"\nMARK: %s, %d", __PRETTY_FUNCTION__, __LINE__)

#endif

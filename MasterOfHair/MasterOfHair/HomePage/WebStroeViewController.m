//
//  WebStroeViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/19.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "WebStroeViewController.h"

#import "AppDelegate.h"
@interface WebStroeViewController ()

//上面的两个btn
@property (nonatomic, strong) UIView * top_white;
@property (nonatomic, strong) UIButton * top_btnDelegate;
@property (nonatomic, strong) UIButton * top_btnFactory;
@property (nonatomic, strong) UIView * top_viewDelegate;
@property (nonatomic, strong) UIView * top_viewFactory;



@end

@implementation WebStroeViewController

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
    _lblTitle.text = @"商城";
    _lblTitle.font = [UIFont systemFontOfSize:19];
}

//显示tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showTabBar];
}

#pragma mark - 总布局
- (void)p_setupView
{
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self p_topView];

}

#pragma mark - topView
- (void)p_topView
{
    self.top_white = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50)];
    self.top_white.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.top_white];
    
    int length_x = SCREEN_WIDTH / 2;
    
    //代理商
    self.top_btnDelegate = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.top_btnDelegate.frame = CGRectMake(0, 0, length_x, 50);
    [self.top_btnDelegate setTitle:@"代理商" forState:(UIControlStateNormal)];
    [self.top_btnDelegate setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    self.top_btnDelegate.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.top_white addSubview:self.top_btnDelegate];
    
    [self.top_btnDelegate addTarget:self action:@selector(top_btnDelegateAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.top_viewDelegate = [[UIView alloc] initWithFrame:CGRectMake(length_x / 2 - 40, 48, 80, 2)];
    self.top_viewDelegate.backgroundColor = navi_bar_bg_color;
    [self.top_btnDelegate addSubview:self.top_viewDelegate];
    
    
    //厂家
    self.top_btnFactory = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.top_btnFactory.frame = CGRectMake(length_x, 0, length_x, 50);
    [self.top_btnFactory setTitle:@"厂家" forState:(UIControlStateNormal)];
    [self.top_btnFactory setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.top_btnFactory.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.top_white addSubview:self.top_btnFactory];
    
    [self.top_btnFactory addTarget:self action:@selector(top_btnFactoryAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.top_viewFactory = [[UIView alloc] initWithFrame:CGRectMake(length_x / 2 - 40, 48, 80, 2)];
    self.top_viewFactory.backgroundColor = navi_bar_bg_color;
    [self.top_btnFactory addSubview:self.top_viewFactory];
    self.top_viewFactory.hidden = YES;
}

#pragma mark - 代理商 和 厂家的btn

//代理商的btn
- (void)top_btnDelegateAction:(UIButton *)sender
{
    //变颜色
    [self.top_btnDelegate setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    self.top_viewDelegate.hidden = NO;
    
    [self.top_btnFactory setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.top_viewFactory.hidden = YES;
}

//厂家的btn
- (void)top_btnFactoryAction:(UIButton *)sender
{
    //变颜色
    [self.top_btnDelegate setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.top_viewDelegate.hidden = YES;
    
    [self.top_btnFactory setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    self.top_viewFactory.hidden = NO;
}









@end

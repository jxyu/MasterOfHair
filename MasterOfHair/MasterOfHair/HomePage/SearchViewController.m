//
//  SearchViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/22.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "SearchViewController.h"

#import "AppDelegate.h"
@interface SearchViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField * search_text;


@end

@implementation SearchViewController

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
    [self addLeftButton:@"iconfont-fanhui"];
//    _btnLeft.backgroundColor = [UIColor orangeColor];
    
    //右边为搜索
    [self addRightbuttontitle:@"搜索"];
    _lblRight.font = [UIFont systemFontOfSize:20];
//    _lblRight.backgroundColor = [UIColor orangeColor];
    _lblRight.frame = CGRectMake(SCREEN_WIDTH - 65, 20, 50, 44);
    _btnRight.frame = _lblRight.frame;
    
    
    //搜索框
    _lblTitle.hidden = YES;
    UIView * view_bg = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_btnLeft.frame) + 0, 24, SCREEN_WIDTH - 135, 35)];
    view_bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
    view_bg.layer.cornerRadius = 0.05 * SCREEN_WIDTH;
    [self.view addSubview:view_bg];
    //图标
    UIImageView * search_image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 25, 25)];
    search_image.image = [UIImage imageNamed:@"iconfont-sousuo"];
    [view_bg addSubview:search_image];
    
    self.search_text = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(search_image.frame) + 5, 5, CGRectGetWidth(view_bg.frame) - 50, 25)];
    self.search_text.placeholder = @"请您输入关键字";
    self.search_text.font = [UIFont systemFontOfSize:15];
    self.search_text.clearButtonMode = UITextFieldViewModeAlways;
    self.search_text.returnKeyType = UIReturnKeySearch;
    self.search_text.delegate = self;
    [view_bg addSubview:self.search_text];
    
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.search_text resignFirstResponder];
}

//左返回
- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//右搜索
- (void)clickRightButton:(UIButton *)sender
{
    NSLog(@"可编辑的搜索");
    
    [self.search_text resignFirstResponder];
    //进行检索
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

#pragma mark - textField的代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.search_text resignFirstResponder];
    
    //进行检索
    return YES;
}


@end

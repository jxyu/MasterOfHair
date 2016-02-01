
//
//  NextMingshiViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/30.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "NextMingshiViewController.h"

@interface NextMingshiViewController ()

@property (nonatomic, strong) UIScrollView * scrollView;

//
@property (nonatomic, strong) UIImageView * image;

@property (nonatomic, strong) UILabel * name;
@property (nonatomic, strong) UILabel * time;
@property (nonatomic, strong) UILabel * yewu;
@property (nonatomic, strong) UILabel * detail;

@property (nonatomic, strong) UIWebView * webView;

@end

@implementation NextMingshiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    _lblTitle.text = [NSString stringWithFormat:@"详情页"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
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
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.scrollView];
    
    
    UIView * view_1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 90)];
    view_1.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_1];
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 80, 80)];
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
    [view_1 addSubview:self.image];
    
    
    UIView * view_2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_1.frame) + 10, SCREEN_WIDTH, 50)];
    view_2.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_2];
    
    UILabel * label_2_1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 110, 15)];
    label_2_1.text = @"姓名";
    label_2_1.textAlignment = NSTextAlignmentCenter;
    label_2_1.font = [UIFont systemFontOfSize:15];
    label_2_1.textColor = [UIColor grayColor];
    [view_2 addSubview:label_2_1];
    
    UILabel * label_2_2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 26, 110, 15)];
    label_2_2.text = @"(店名)";
    label_2_2.textAlignment = NSTextAlignmentCenter;
    label_2_2.font = [UIFont systemFontOfSize:15];
    label_2_2.textColor = [UIColor grayColor];
    [view_2 addSubview:label_2_2];
    
    UIView * view_line2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_2_1.frame), 5, 1, 40)];
    view_line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view_2 addSubview:view_line2];
    
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line2.frame) + 10, 15, SCREEN_WIDTH - CGRectGetMaxX(view_line2.frame) - 20, 20)];
    self.name.text = @"hahah刘";
    self.name.font = [UIFont systemFontOfSize:15];
    [view_2 addSubview:self.name];
    
    

    UIView * view_3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_2.frame) + 2, SCREEN_WIDTH, 50)];
    view_3.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_3];
    
    UILabel * label_3_1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 110, 15)];
    label_3_1.text = @"年龄";
    label_3_1.textAlignment = NSTextAlignmentCenter;
    label_3_1.font = [UIFont systemFontOfSize:15];
    label_3_1.textColor = [UIColor grayColor];
    [view_3 addSubview:label_3_1];
    
    UILabel * label_3_2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 26, 110, 15)];
    label_3_2.text = @"(经营年限)";
    label_3_2.textAlignment = NSTextAlignmentCenter;
    label_3_2.font = [UIFont systemFontOfSize:15];
    label_3_2.textColor = [UIColor grayColor];
    [view_3 addSubview:label_3_2];
    
    UIView * view_line3 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_3_1.frame), 5, 1, 40)];
    view_line3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view_3 addSubview:view_line3];
    
    self.time = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line3.frame) + 10, 15, SCREEN_WIDTH - CGRectGetMaxX(view_line3.frame) - 20, 20)];
    self.time.text = @"hahah刘";
    self.time.font = [UIFont systemFontOfSize:15];
    [view_3 addSubview:self.time];

    
    UIView * view_4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_3.frame) + 2, SCREEN_WIDTH, 60)];
    view_4.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_4];
    
    UILabel * label_4_1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 110, 15)];
    label_4_1.text = @"技术工种";
    label_4_1.textAlignment = NSTextAlignmentCenter;
    label_4_1.font = [UIFont systemFontOfSize:15];
    label_4_1.textColor = [UIColor grayColor];
    [view_4 addSubview:label_4_1];
    
    UILabel * label_4_2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 31, 110, 15)];
    label_4_2.text = @"(主要业务)";
    label_4_2.textAlignment = NSTextAlignmentCenter;
    label_4_2.font = [UIFont systemFontOfSize:15];
    label_4_2.textColor = [UIColor grayColor];
    [view_4 addSubview:label_4_2];
    
    UIView * view_line4 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_4_1.frame), 5, 1, 50)];
    view_line4.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view_4 addSubview:view_line4];
    
    
    self.yewu = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line4.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line4.frame) - 20, 40)];
    self.yewu.text = @"hahah刘深刻的接口设计的开始就看到是打开数据库的时间看到";
    self.yewu.numberOfLines = 2;
    self.yewu.font = [UIFont systemFontOfSize:14];
    [view_4 addSubview:self.yewu];
    
    
    UIView * view_5 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_4.frame) + 10, SCREEN_WIDTH, 110)];
    view_5.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_5];
    
    UILabel * label_5_1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 110, 15)];
    label_5_1.text = @"技师简介";
    label_5_1.textAlignment = NSTextAlignmentCenter;
    label_5_1.font = [UIFont systemFontOfSize:15];
    label_5_1.textColor = [UIColor grayColor];
    [view_5 addSubview:label_5_1];
    
    UILabel * label_5_2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 56, 110, 15)];
    label_5_2.text = @"(店铺详情)";
    label_5_2.textAlignment = NSTextAlignmentCenter;
    label_5_2.font = [UIFont systemFontOfSize:15];
    label_5_2.textColor = [UIColor grayColor];
    [view_5 addSubview:label_5_2];
    
    UIView * view_line5 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_5_1.frame), 5, 1, 100)];
    view_line5.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view_5 addSubview:view_line5];

    self.detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line5.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line5.frame) - 20, 90)];
    self.detail.text = @"hahah刘深刻hah刘深刻hah刘深刻hah刘深刻hah刘深刻hah刘深刻hah刘深刻hah刘深刻hah刘深刻hah刘深刻hah刘深刻hah刘深刻hah刘深刻hah刘深刻hah刘深刻hah刘深刻";
    self.detail.numberOfLines = 5;
    self.detail.font = [UIFont systemFontOfSize:13];
    [view_5 addSubview:self.detail];
    
    
    UIView * view_6 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_5.frame) + 10, SCREEN_WIDTH, 40)];
    view_6.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_6];
    
    UILabel * label_6_1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 110, 20)];
    label_6_1.text = @"作品详情";
    label_6_1.font = [UIFont systemFontOfSize:15];
    [view_6 addSubview:label_6_1];
    
#pragma mark - 下面为H5网页
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_6.frame), SCREEN_WIDTH, SCREEN_HEIGHT / 3 * 2)];
    NSString * path = @"http://www.baidu.com";
    NSURL * url = [NSURL URLWithString:path];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.scrollView addSubview:self.webView];
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.webView.frame));

    
}















@end

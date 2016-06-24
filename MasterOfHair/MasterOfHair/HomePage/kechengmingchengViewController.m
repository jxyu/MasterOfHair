//
//  kechengmingchengViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/28.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "kechengmingchengViewController.h"

#import "ZhifuViewController.h"
@interface kechengmingchengViewController ()

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UIImageView * image;

@property (nonatomic, strong) UILabel * detail;


@property (nonatomic, strong) UILabel * time;
@property (nonatomic, strong) UILabel * price;
@property (nonatomic, strong) UILabel * date;
@property (nonatomic, strong) UILabel * address;

@property (nonatomic, strong) UIButton * btn_baoming;

//web
@property (nonatomic, strong) UIWebView * webView;

//保存数据
@property (nonatomic, copy) NSString * money;

@property (nonatomic, copy) NSString * course_name;

@property (nonatomic, copy) NSString * succeed;
@end

@implementation kechengmingchengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SVProgressHUD showWithStatus:@"加载数据中,请稍等..." maskType:SVProgressHUDMaskTypeBlack];
    
    [self p_panduan];
    
    [self p_data];
    
    [self p_navi];
    
    [self p_setupView];
    
    [self p_bottom];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navi
- (void)p_navi
{
    _lblTitle.text = [NSString stringWithFormat:@"课程名称"];
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
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 70)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    [self p_scrollView];
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.webView.frame) + 15);
}

#pragma mark - 底部栏
- (void)p_bottom
{
    UIView * view_bg = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 70, SCREEN_WIDTH, 70)];
    view_bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:view_bg];
    
    self.btn_baoming = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_baoming.frame = CGRectMake(15, 10, SCREEN_WIDTH - 30, 50);
    self.btn_baoming.backgroundColor = navi_bar_bg_color;
//    [self.btn_baoming setTitle:@"立即报名" forState:(UIControlStateNormal)];
    [self.btn_baoming setTintColor:[UIColor whiteColor]];
    self.btn_baoming.titleLabel.font = [UIFont systemFontOfSize:20];
    [view_bg addSubview:self.btn_baoming];
    
    [self.btn_baoming addTarget:self action:@selector(btn_baomingAction:) forControlEvents:(UIControlEventTouchUpInside)];

    
    
}

- (void)btn_baomingAction:(UIButton *)sender
{
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    if([[userdefault objectForKey:@"member_id"] length] == 0)
    {
        LoginViewController * loginViewController = [[LoginViewController alloc] init];
        
        [self showViewController:loginViewController sender:nil];
    }
    else
    {
        if([sender.titleLabel.text isEqualToString:@"立即报名"])
        {
            ZhifuViewController * zhifuViewController = [[ZhifuViewController alloc] init];
            zhifuViewController.course_id = self.course_id;
            zhifuViewController.name_course = self.course_name;
            zhifuViewController.money = self.money;
            [self showViewController:zhifuViewController sender:nil];
        }
        else
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已报名" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
        }
    }
}

#pragma mark - scrollView中的布局

- (void)p_scrollView
{
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
//    self.image.backgroundColor = [UIColor orangeColor];
//    NSString * str1 =  [NSString stringWithFormat:@"%@uploads/course/%@",Url,self.image_url];
//    [self.image sd_setImageWithURL:[NSURL URLWithString:str1]placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
    
    [self.scrollView addSubview:self.image];
    
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.image.frame) + 5, SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.image.frame) - 55)];
    
    NSString * path = [NSString stringWithFormat:@"%@Course/CourseIntro&course_id=%@",Url,self.course_id];
    NSURL * url = [NSURL URLWithString:path];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.scrollView addSubview:self.webView];
    
}


#pragma mark - 数据
- (void)p_data
{
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"Course:"];
    
    [dataprovider CourseWithCourse_id:self.course_id];
}

//数据
- (void)Course:(id )dict
{
//    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];

    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {

            NSArray * arr_ = dict[@"data"][@"courselist"];
            
            NSDictionary * dic = arr_.firstObject;
            
            NSString * str1 =  [NSString stringWithFormat:@"%@uploads/course/%@",Url_pic,dic[@"image"]];
            [self.image sd_setImageWithURL:[NSURL URLWithString:str1]placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
            
            self.money = [NSString stringWithFormat:@"%@",dic[@"money"]];
            self.course_name = [NSString stringWithFormat:@"%@",dic[@"course_name"]];
            
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

    }
}


#pragma mark - 判断
- (void)p_panduan
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"ifsignup:"];
    
    [dataprovider ifsignupWithCourse_id:self.course_id member_id:[userdefault objectForKey:@"member_id"]];
}

//数据
- (void)ifsignup:(id )dict
{
//    NSLog(@"%@",dict);
    if(![dict[@"status"][@"message"] isEqualToString:@"您已报名该课程"])
    {
        [self.btn_baoming setTitle:@"立即报名" forState:(UIControlStateNormal)];
    }
    else
    {
        [self.btn_baoming setTitle:@"已报名" forState:(UIControlStateNormal)];
//        self.btn_baoming.userInteractionEnabled = NO;
    }
}



















//用不到了

//- (void)p_data1
//{
//    DataProvider * dataprovider=[[DataProvider alloc] init];
//
//    [dataprovider setDelegateObject:self setBackFunctionName:@"Course:"];
//
//    [dataprovider CourseIntroWithCourse_id:self.course_id];
//}
//



//弃用布局
- (void)p_qiyongbuju
{
    //    NSString * str = @"sdjksjdksjdkjskdjskkjskdjksjdksjdkjskdjskkdjksjdksjdkjskdjskkkdjksjdksjdkjskdjskjskdjksjdksjdksjdkj+++++++++++++++++++++++++++++++++++++++++++++++++skdjsk";
    //    CGFloat height = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 10000)    options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
    //
    //    self.detail = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.image.frame) + 15, SCREEN_WIDTH - 20, height)];
    //    self.detail.text = str;
    //    self.detail.numberOfLines = 0;
    ////    self.detail.backgroundColor = [UIColor orangeColor];
    //    self.detail.textColor = [UIColor grayColor];
    //    [self.scrollView addSubview:self.detail];
    //
    //
    //#warning 可能改为textView +++++++++++++++++++++++++++++++++++++++++++++++++
    //    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.detail.frame) + 30, 80, 25)];
    //    label1.text = @"课程学时:";
    //    [self.scrollView addSubview:label1];
    //
    //    self.time = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 5, CGRectGetMinY(label1.frame), SCREEN_WIDTH - CGRectGetMaxX(label1.frame) - 10, 25)];
    //    self.time.text = @"4个小时";
    //    [self.scrollView addSubview:self.time];
    //
    //
    //    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label1.frame) + 5, 80, 25)];
    //    label2.text = @"费用:";
    //    [self.scrollView addSubview:label2];
    //
    //    self.price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame) + 5, CGRectGetMinY(label2.frame), SCREEN_WIDTH - CGRectGetMaxX(label2.frame) - 10, 25)];
    //    self.price.text = @"199元";
    //    [self.scrollView addSubview:self.price];
    //
    //
    //    UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label2.frame) + 5, 80, 25)];
    //    label3.text = @"时间:";
    //    [self.scrollView addSubview:label3];
    //
    //    self.date = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame) + 5, CGRectGetMinY(label3.frame), SCREEN_WIDTH - CGRectGetMaxX(label3.frame) - 10, 25)];
    //    self.date.text = @"2016.1.29 ";
    //    [self.scrollView addSubview:self.date];
    //
    //
    //    UILabel * label4 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label3.frame) + 5, 80, 25)];
    //    label4.text = @"地点:";
    //    [self.scrollView addSubview:label4];
    //
    //    self.address = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label4.frame) + 5, CGRectGetMinY(label4.frame), SCREEN_WIDTH - CGRectGetMaxX(label4.frame) - 10, 25)];
    //    self.address.text = @"临沂兰山";
    //    [self.scrollView addSubview:self.address];
}




@end

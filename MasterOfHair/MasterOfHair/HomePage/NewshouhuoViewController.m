//
//  NewshouhuoViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/26.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "NewshouhuoViewController.h"

#import "AppDelegate.h"
@interface NewshouhuoViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UITextField * name;

@property (nonatomic, strong) UITextField * tel;

@property (nonatomic, strong) UITextField * address;

@property (nonatomic, strong) UITextField * address_detail;

@end

@implementation NewshouhuoViewController

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
    _lblTitle.text = @"新建收货地址";
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    [self addRightbuttontitle:@"保存"];
}
//返回
- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//点击修改按钮
- (void)clickRightButton:(UIButton *)sender
{
    NSLog(@"提示保存成功");
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
    
    [self p_setupView1];
}

- (void)p_setupView1
{
    UIView * view_white = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view_white.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white];
    
    self.name = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 30)];
    self.name.placeholder = @"收货人姓名";
    self.name.delegate = self;
    self.name.font = [UIFont systemFontOfSize:15];
    [view_white addSubview:self.name];
    
    
    UIView * view_white1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_white.frame) + 2, SCREEN_WIDTH, 50)];
    view_white1.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white1];
    
    self.tel = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 30)];
    self.tel.placeholder = @"手机号码";
    self.tel.delegate = self;
    self.tel.font = [UIFont systemFontOfSize:15];
    [view_white1 addSubview:self.tel];
    
    
    
    UIView * view_white2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_white1.frame) + 2, SCREEN_WIDTH, 50)];
    view_white2.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white2];
    
    self.address = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 30)];
    self.address.placeholder = @"请选择 省 市 县";
    self.address.delegate = self;
    self.address.font = [UIFont systemFontOfSize:15];
    [view_white2 addSubview:self.address];
    
    
    
    UIView * view_white3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_white2.frame) + 2, SCREEN_WIDTH, 50)];
    view_white3.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white3];
    
    self.address_detail = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 30)];
    self.address_detail.placeholder = @"详细地址";
    self.address_detail.delegate = self;
    self.address_detail.font = [UIFont systemFontOfSize:15];
    [view_white3 addSubview:self.address_detail];
}


#pragma mark - textfiled的代理

- (BOOL )textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.name resignFirstResponder];
    [self.tel resignFirstResponder];
    [self.address_detail resignFirstResponder];
    [self.address resignFirstResponder];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if([textField isEqual:self.address])
    {
        [UIView animateWithDuration:0.7 animations:^{
            
            self.scrollView.contentOffset = CGPointMake(0, 110);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if([textField isEqual:self.address_detail])
    {
        [UIView animateWithDuration:0.7 animations:^{
            
            self.scrollView.contentOffset = CGPointMake(0, 160);
            
        } completion:^(BOOL finished) {
            
        }];
    }
}



@end

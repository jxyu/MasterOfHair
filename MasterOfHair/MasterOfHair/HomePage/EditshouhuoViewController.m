//
//  EditshouhuoViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/26.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "EditshouhuoViewController.h"

#import "AppDelegate.h"
@interface EditshouhuoViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UITextField * name;

@property (nonatomic, strong) UITextField * tel;

@property (nonatomic, strong) UITextField * address;

@property (nonatomic, strong) UITextField * address_detail;

@property (nonatomic, strong) UIButton * btn_morenAddress;

@end

@implementation EditshouhuoViewController

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
    _lblTitle.text = @"编辑收货地址";
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    [self addRightbuttontitle:@"修改"];
}
//返回
- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//点击修改按钮
- (void)clickRightButton:(UIButton *)sender
{
    NSLog(@"提示修改成功");
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
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 30)];
    label1.text = @"收货人";
    label1.font = [UIFont systemFontOfSize:19];
    [view_white addSubview:label1];
    
    self.name = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(label1.frame) - 20 , 30)];
    self.name.text = @"O(∩_∩)O哈哈~";
    self.name.delegate = self;
//    self.name.backgroundColor = [UIColor orangeColor];
    [view_white addSubview:self.name];
    
    
    UIView * view_white1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_white.frame) + 2, SCREEN_WIDTH, 50)];
    view_white1.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white1];
    
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 30)];
    label2.text = @"手机号码";
    label2.font = [UIFont systemFontOfSize:19];
    [view_white1 addSubview:label2];
    
    self.tel = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 5, 12, SCREEN_WIDTH - CGRectGetMaxX(label1.frame) - 20 , 30)];
    self.tel.text = @"12345678901";
    self.tel.delegate = self;
    [view_white1 addSubview:self.tel];
    
    
    UIView * view_white2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_white1.frame) + 2, SCREEN_WIDTH, 50)];
    view_white2.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white2];
    
    UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 30)];
    label3.text = @"所在地区";
    label3.font = [UIFont systemFontOfSize:19];
    [view_white2 addSubview:label3];
    
    self.address = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(label1.frame) - 20 , 30)];
    self.address.text = @"所在地 所在地";
    self.address.delegate = self;
    [view_white2 addSubview:self.address];
    
    
    UIView * view_white3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_white2.frame) + 2, SCREEN_WIDTH, 50)];
    view_white3.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white3];
    
    UILabel * label4 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 30)];
    label4.text = @"详细地址";
//    label4.backgroundColor = [UIColor orangeColor];
    label4.font = [UIFont systemFontOfSize:19];
    [view_white3 addSubview:label4];
    
    self.address_detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(label1.frame) - 20 , 30)];
    self.address_detail.text = @"所在地 所在地";
    self.address_detail.delegate = self;
    [view_white3 addSubview:self.address_detail];
    
    
    
    UIView * view_white4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_white3.frame) + 40, SCREEN_WIDTH, 50)];
    view_white4.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white4];
    
    UILabel * label5 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 150, 30)];
    label5.text = @"删除收货地址";
    label5.textColor = [UIColor redColor];
    label5.font = [UIFont systemFontOfSize:19];
    [view_white4 addSubview:label5];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    //设置点击次数和点击手指数
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [view_white4 addGestureRecognizer:tapGesture];
    
    
    self.btn_morenAddress = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_morenAddress.frame = CGRectMake(15, SCREEN_HEIGHT - 10 - 45 - 64, SCREEN_WIDTH - 30, 45);
    self.btn_morenAddress.backgroundColor = navi_bar_bg_color;
    [self.btn_morenAddress setTitle:@"设为默认地址" forState:(UIControlStateNormal)];
    self.btn_morenAddress.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.btn_morenAddress setTintColor:[UIColor whiteColor]];
    [self.scrollView addSubview:self.btn_morenAddress];
    
    [self.btn_morenAddress addTarget:self action:@selector(btn_morenAddressAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

#pragma mark - 轻击手势触发方法  和设为默认地址
-(void)tapGesture:(id)sender
{
    NSLog(@"走删除流程， 给提示");
}

//设为默认地址
- (void)btn_morenAddressAction:(UIButton *)sender
{
    NSLog(@"走默认地址 ， 给提示");
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

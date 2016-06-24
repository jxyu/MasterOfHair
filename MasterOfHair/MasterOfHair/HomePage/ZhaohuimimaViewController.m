
//
//  ZhaohuimimaViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/3/14.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "ZhaohuimimaViewController.h"

@interface ZhaohuimimaViewController () <UIScrollViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UILabel * tel;

@property (nonatomic, strong) UITextField * old_passWord;

@property (nonatomic, strong) UITextField * newpassWord;

@property (nonatomic, strong) UITextField * next_passWord;

@end

@implementation ZhaohuimimaViewController

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
    _lblTitle.text = [NSString stringWithFormat:@"修改密码"];
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
    
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT + 30);
    self.scrollView.delegate = self;
    
    [self.view addSubview:self.scrollView];
    
    [self p_other];
}

- (void)p_other
{
    //
    UIView * view_5 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 50)];
    view_5.backgroundColor = [UIColor whiteColor];
    view_5.layer.cornerRadius = 5;
    view_5.layer.borderColor = navi_bar_bg_color.CGColor;
    view_5.layer.borderWidth = 1;
    [self.scrollView addSubview:view_5];
    
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];

    self.tel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, view_5.frame.size.width - 30, 40)];
    self.tel.text = [NSString stringWithFormat:@"账号: %@",[userdefault objectForKey:@"member_username"]];
    [view_5 addSubview:self.tel];
    
    
    //
    UIView * view_4 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(view_5.frame) + 10, self.view.frame.size.width - 20, 50)];
    view_4.backgroundColor = [UIColor whiteColor];
    view_4.layer.cornerRadius = 5;
    view_4.layer.borderColor = navi_bar_bg_color.CGColor;
    view_4.layer.borderWidth = 1;
    [self.scrollView addSubview:view_4];
    
    self.old_passWord = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, view_4.frame.size.width - 30, 40)];
    self.old_passWord.placeholder = @"请输入旧密码";
    self.old_passWord.secureTextEntry = YES;
    self.old_passWord.delegate = self;
    [view_4 addSubview:self.old_passWord];
    
    
    //
    UIView * view3 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(view_4.frame) + 10, self.view.frame.size.width - 20, 50)];
    view3.backgroundColor = [UIColor whiteColor];
    view3.layer.cornerRadius = 5;
    view3.layer.borderColor = navi_bar_bg_color.CGColor;
    view3.layer.borderWidth = 1;
    [self.scrollView addSubview:view3];
    
    self.newpassWord = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, view3.frame.size.width - 30, 40)];
    self.newpassWord.placeholder = @"请输入新密码";
    self.newpassWord.secureTextEntry = YES;
    self.newpassWord.delegate = self;
    [view3 addSubview:self.newpassWord];
    
    
    //
    UIView * view_2 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(view3.frame) + 10, self.view.frame.size.width - 20, 50)];
    view_2.backgroundColor = [UIColor whiteColor];
    view_2.layer.cornerRadius = 5;
    view_2.layer.borderColor = navi_bar_bg_color.CGColor;
    view_2.layer.borderWidth = 1;
    [self.scrollView addSubview:view_2];
    
    self.next_passWord = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, view_2.frame.size.width - 30, 40)];
    self.next_passWord.placeholder = @"请再次输入新密码";
    self.next_passWord.delegate = self;
    self.next_passWord.secureTextEntry = YES;
    [view_2 addSubview:self.next_passWord];
    
    
    //btn注册
    UIButton * btn_change = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn_change.frame = CGRectMake(20, CGRectGetMaxY(view_2.frame) + 20, self.view.frame.size.width - 40 , 40);
    [btn_change setTitle:@"修 改 密 码" forState:(UIControlStateNormal)];
    [btn_change setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    btn_change.layer.cornerRadius = 4;
    btn_change.backgroundColor = navi_bar_bg_color;
    [self.scrollView addSubview:btn_change];
    [btn_change addTarget:self action:@selector(btn_changeAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

#pragma mark - 点击事件
- (void )touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.tel resignFirstResponder];
    [self.old_passWord resignFirstResponder];
    [self.newpassWord resignFirstResponder];
    [self.next_passWord resignFirstResponder];
}

- (void)btn_changeAction:(UIButton *)sender
{
    [self.tel resignFirstResponder];
    [self.old_passWord resignFirstResponder];
    [self.newpassWord resignFirstResponder];
    [self.next_passWord resignFirstResponder];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    
//    if([self.tel.text length] != 11)
//    {
//        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确账号(手机号)" preferredStyle:(UIAlertControllerStyleAlert)];
//        [self presentViewController:alert animated:YES completion:^{
//        }];
//        
//        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//        }];
//        [alert addAction:action];
//    }
    
    if([self.old_passWord.text length] < 6 || [self.old_passWord.text length] < 6)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的旧密码" preferredStyle:(UIAlertControllerStyleAlert)];
        [self presentViewController:alert animated:YES completion:^{
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        
    }
    
    if([self.newpassWord.text length] < 6 || [self.newpassWord.text length] < 6)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入6位以上数字或字母组合的新密码" preferredStyle:(UIAlertControllerStyleAlert)];
        [self presentViewController:alert animated:YES completion:^{
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        
    }
    
    if(![self.next_passWord.text isEqualToString:self.newpassWord.text])
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次输入的密码不相同" preferredStyle:(UIAlertControllerStyleAlert)];
        [self presentViewController:alert animated:YES completion:^{
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        
    }
    
    
    if([self.tel.text length] != 0 && [self.old_passWord.text length] != 0 && [self.newpassWord.text isEqualToString:self.next_passWord.text] && [self.newpassWord.text length] >= 6 && [self.newpassWord.text length] >= 6)
    {
//        NSLog(@"掉接口");
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        
        DataProvider * dataprovider=[[DataProvider alloc] init];
        
        [dataprovider setDelegateObject:self setBackFunctionName:@"update:"];
        
        [dataprovider createWithMember_username:[userdefault objectForKey:@"member_username"] member_password:self.old_passWord.text member_new_password:self.newpassWord.text];
    }
}

#pragma mark - 修改
- (void)update:(id )dict
{
    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"修改成功" maskType:(SVProgressHUDMaskTypeBlack)];
            
            NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
            
            [userdefault setObject:self.newpassWord.text forKey:@"password"];
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
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] maskType:SVProgressHUDMaskTypeBlack];
    }
}


#pragma mark - text
- (BOOL )textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if([textField isEqual:self.newpassWord])
    {
        [UIView animateWithDuration:0.7 animations:^{
            
            self.scrollView.contentOffset = CGPointMake(0, 100);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if([textField isEqual:self.next_passWord])
    {
        [UIView animateWithDuration:0.7 animations:^{
            
            self.scrollView.contentOffset = CGPointMake(0, 150);
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark - scrollView代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.tel resignFirstResponder];
    [self.old_passWord resignFirstResponder];
    [self.newpassWord resignFirstResponder];
    [self.next_passWord resignFirstResponder];
}

@end

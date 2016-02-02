//
//  NextTextViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/2.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "NextTextViewController.h"

#import "NextTextTableViewCell.h"
@interface NextTextViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView * tableView;
//头视图
@property (nonatomic, strong) UIView * head_view;

@property (nonatomic, strong) UIImageView * head_image;
@property (nonatomic, strong) UILabel * head_name;
@property (nonatomic, strong) UILabel * head_time;
@property (nonatomic, strong) UILabel * head_detail;

//底部栏
@property (nonatomic, strong) UIView * bottom_View;
@property (nonatomic, strong) UITextField * bottom_text;
@property (nonatomic, strong) UIButton * bottom_btn;
@end

@implementation NextTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_navi];
    
    [self p_headView];
    
    [self p_bottomView];
    
    [self p_setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navi
- (void)p_navi
{
    _lblTitle.text = [NSString stringWithFormat:@"评论"];
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:(UITableViewStylePlain)];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 80, 0, 0);
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = self.head_view;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //注册
    [self.tableView registerClass:[NextTextTableViewCell class] forCellReuseIdentifier:@"cell_pinglun"];
}

#pragma mark - tableview代理
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = @"手机打开手机的空间设计的款式简单款式简单款就是看的就是空间打开手机看的就是宽带接口设计的";
    
    return 80 + [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 80 - 50 - 20, 10000)    options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NextTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_pinglun" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - 头部栏
- (void)p_headView
{
    self.head_view = [[UIView alloc] init];
    
    
    self.head_image = [[UIImageView alloc] init];
    self.head_image.frame = CGRectMake(10, 10, 60, 60);
    self.head_image.backgroundColor = [UIColor orangeColor];
    self.head_image.layer.cornerRadius = 30;
    [self.head_view addSubview:self.head_image];
    
    
    self.head_name = [[UILabel alloc] init];
    self.head_name.textColor = [UIColor grayColor];
    self.head_name.frame = CGRectMake(CGRectGetMaxX(self.head_image.frame) + 10, CGRectGetMinY(self.head_image.frame) + 5, SCREEN_WIDTH - 50 - CGRectGetMaxX(self.head_image.frame) - 10, 20);
    self.head_name.text = @"哈哈和还好";
//    self.head_name.backgroundColor = [UIColor orangeColor];
    self.head_name.font = [UIFont systemFontOfSize:14];
    [self.head_view addSubview:self.head_name];
    
    
    
    self.head_time = [[UILabel alloc] init];
    self.head_time.frame = CGRectMake(CGRectGetMaxX(self.head_image.frame) + 10, CGRectGetMaxY(self.head_name.frame) + 5, SCREEN_WIDTH - 50 - CGRectGetMaxX(self.head_image.frame) - 10, 20);
    self.head_time.textColor = [UIColor grayColor];
    self.head_time.text = @"2016-03-01 22:20:11";
//        self.head_time.backgroundColor = [UIColor orangeColor];
    self.head_time.font = [UIFont systemFontOfSize:14];
    [self.head_view addSubview:self.head_time];
    

    NSString * str = @"jksjdksjkdsjkdjskjdksjkdskdksjdkskdjskjdksj手机的空间";
    CGFloat length_x = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - CGRectGetMaxX(self.head_image.frame) - 20, 10000)    options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    
    self.head_detail = [[UILabel alloc] init];
    self.head_detail.frame = CGRectMake(CGRectGetMaxX(self.head_image.frame) + 10, CGRectGetMaxY(self.head_image.frame) + 5, SCREEN_WIDTH - CGRectGetMaxX(self.head_image.frame) - 20, length_x);
    self.head_detail.font = [UIFont systemFontOfSize:14];
    self.head_detail.text = str;
    self.head_detail.numberOfLines = 0;
    [self.head_view addSubview:self.head_detail];

    
    self.head_view.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(self.head_detail.frame) + 10);
}

#pragma mark - 底部栏
- (void)p_bottomView
{
    self.bottom_View = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    self.bottom_View.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottom_View];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.bottom_View addSubview:line];
    
    UIView * view_1 = [[UIView alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 90, 40)];
    view_1.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    view_1.layer.borderWidth = 1;
    [self.bottom_View addSubview:view_1];
    
    UIImageView * image_1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    image_1.image = [UIImage imageNamed:@"01_3323232323"];
    [view_1 addSubview:image_1];
    
    self.bottom_text = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image_1.frame) + 10, 5, SCREEN_WIDTH - 90 - CGRectGetMaxX(image_1.frame) - 18, 30)];
    [self registerForKeyboardNotifications];
    //    self.bottom_text.backgroundColor = [UIColor orangeColor];
    self.bottom_text.placeholder = @"我来说几句";
    self.bottom_text.delegate = self;
    [view_1 addSubview:self.bottom_text];
    
    
    self.bottom_btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.bottom_btn.frame = CGRectMake(CGRectGetMaxX(view_1.frame) + 10, 5, 60, 40);
    self.bottom_btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.bottom_btn setTitle:@"发布" forState:(UIControlStateNormal)];
    self.bottom_btn.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.bottom_btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [self.bottom_View addSubview:self.bottom_btn];
    
    [self.bottom_btn addTarget:self action:@selector(bottom_btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)bottom_btnAction:(UIButton *)sender
{
    if([self.bottom_text.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入文字后再发布评论" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        [self.bottom_text resignFirstResponder];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else
    {
        NSLog(@"发布");
        
//        self.bottom_text.text = nil;
        [self.bottom_text resignFirstResponder];
    }
}

#pragma mark - textField代理 和通知收回键盘
- (BOOL )textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
//获取键盘高度
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    
    CGSize keyboardSize = [value CGRectValue].size;
    
    //    NSLog(@"keyBoard:%f", keyboardSize.height);  //
    
    [UIView animateWithDuration:0.5 animations:^{
        self.bottom_View.frame = CGRectMake(0, SCREEN_HEIGHT - 50 - keyboardSize.height, SCREEN_WIDTH, 50);
        [self.view bringSubviewToFront:self.bottom_View];
    }];
}

- (void) keyboardWasHidden:(NSNotification *) notif
{
    [UIView animateWithDuration:0.5 animations:^{
        self.bottom_View.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
        [self.view bringSubviewToFront:self.bottom_View];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.bottom_text resignFirstResponder];
}











@end

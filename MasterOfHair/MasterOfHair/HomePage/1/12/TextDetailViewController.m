//
//  TextDetailViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/1.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "TextDetailViewController.h"

#import "TextTableViewCell.h"
@interface TextDetailViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView * tableView;

//headView
@property (nonatomic, strong) UIView * headView;
//头视图
@property (nonatomic, strong) UILabel * name;
@property (nonatomic, strong) UILabel * read_number;

@property (nonatomic, strong) UIImageView * image_collect;
@property (nonatomic, strong) UILabel * text_collect;
@property (nonatomic, strong) UIButton * btn_collect;

@property (nonatomic, strong) UIButton * btn_share;

@property (nonatomic, strong) UIImageView * head_image;
@property (nonatomic, strong) UILabel * head_text;

@property (nonatomic, strong) UILabel * head_comment;

//底部栏
@property (nonatomic, strong) UIView * bottom_View;

@property (nonatomic, strong) UITextField * bottom_text;
@property (nonatomic, strong) UIButton * bottom_btn;

@end

@implementation TextDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    _lblTitle.text = [NSString stringWithFormat:@"详情"];
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
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableHeaderView = self.headView;
    
    //注册
    [self.tableView registerClass:[TextTableViewCell class] forCellReuseIdentifier:@"cell_textDetail"];
}

#pragma mark - tableView代理
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
    
    NSString * str = @"手机打开手机的空间设计的款式简单款式简单款就是看的就是空间打开手机看的就是宽带接口设计的技术肯定就是空间打开数据库的技术可简单接口技术的间设计的款式简单款式简单款就是看的就是空间";

    return 95 + [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 100, 10000)    options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_textDetail" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"评论详情");
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - headView

- (void)p_headView
{
    self.headView = [[UIView alloc] init];
    self.headView.backgroundColor = [UIColor whiteColor];
    
    //标题
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 28)];
    self.name.text = @"2016年度时尚发型设计展示";
    self.name.font = [UIFont systemFontOfSize:20];
//    self.name.backgroundColor = [UIColor orangeColor];
    [self.headView addSubview:self.name];
    
    //浏览量
    UIImageView * image_1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.name.frame) + 5, 25, 25)];
    image_1.image = [UIImage imageNamed:@"yanjing"];
    [self.headView addSubview:image_1];
    
    self.read_number = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image_1.frame) + 3, CGRectGetMinY(image_1.frame) + 2.5, 50, 20)];
    self.read_number.font = [UIFont systemFontOfSize:13];
    self.read_number.text = @"1.2万";
//    self.read_number.backgroundColor = [UIColor orangeColor];
    [self.headView addSubview:self.read_number];
    
    //收藏
    self.image_collect = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.read_number.frame) + 5, CGRectGetMaxY(self.name.frame) + 5, 25, 25)];
    self.image_collect.image = [UIImage imageNamed:@"01collect_16"];
    [self.headView addSubview:self.image_collect];
    
    self.text_collect = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.image_collect.frame) + 3, CGRectGetMinY(image_1.frame) + 2.5, 50, 20)];
    self.text_collect.font = [UIFont systemFontOfSize:13];
    self.text_collect.text = @"收藏";
//        self.text_collect.backgroundColor = [UIColor orangeColor];
    [self.headView addSubview:self.text_collect];
    
    self.btn_collect = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_collect.frame = CGRectMake(CGRectGetMinX(self.image_collect.frame), CGRectGetMaxY(self.name.frame) + 5, CGRectGetMaxX(self.text_collect.frame) -  CGRectGetMinX(self.image_collect.frame), 25);
    [self.headView addSubview:self.btn_collect];
    [self.btn_collect addTarget:self action:@selector(btn_collectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //分享
    UIImageView * image_2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.btn_collect.frame) + 5, CGRectGetMaxY(self.name.frame) + 5, 25, 25)];
    image_2.image = [UIImage imageNamed:@"01share_21"];
    [self.headView addSubview:image_2];
    
    UILabel * lable_2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image_2.frame) + 3, CGRectGetMinY(image_2.frame) + 2.5, 50, 20)];
    lable_2.font = [UIFont systemFontOfSize:13];
    lable_2.text = @"收藏";
    [self.headView addSubview:lable_2];
    
    self.btn_share = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_share.frame = CGRectMake(CGRectGetMinX(image_2.frame), CGRectGetMaxY(self.name.frame) + 5, CGRectGetMaxX(lable_2.frame) -  CGRectGetMinX(image_2.frame), 25);
    [self.headView addSubview:self.btn_share];
    [self.btn_share addTarget:self action:@selector(btn_shareAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.head_image = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.btn_share.frame) + 10, SCREEN_WIDTH - 20, 200)];
    self.head_image.layer.masksToBounds = YES;
    [self.head_image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
    [self.headView addSubview:self.head_image];
    
    
    NSString * str = @"jksjdksjkdsjkdjskjdksjkdskdksjdkskdjskjdksjdkjskdjksjdksjdksjkdjskdjksjdksjdks时间快速打开手机打开手机的就是看就看大家时间的快速健康的就是空间打开手机的空间";
    CGFloat length_x = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 10000)    options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    
    self.head_text = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.head_image.frame) + 10, SCREEN_WIDTH - 20, length_x)];
    self.head_text.text = str;
    self.head_text.numberOfLines = 0;
    self.head_text.font = [UIFont systemFontOfSize:14];
    self.head_text.textColor = [UIColor grayColor];
    [self.headView addSubview:self.head_text];
    
    //
    UILabel * label_3 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.head_text.frame) + 40, 70, 25)];
    label_3.text = @"评论";
    [self.headView addSubview:label_3];
    
    self.head_comment = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_3.frame) + 10, CGRectGetMaxY(self.head_text.frame) + 40, SCREEN_WIDTH  - CGRectGetMaxX(label_3.frame) - 20, 25)];
//    self.head_comment.backgroundColor = [UIColor orangeColor];
    self.head_comment.textColor = [UIColor grayColor];
    self.head_comment.text = @"共60条评论";
    self.head_comment.font = [UIFont systemFontOfSize:15];
    self.head_comment.textAlignment = NSTextAlignmentRight;
    [self.headView addSubview:self.head_comment];
    
    self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(label_3.frame) + 10);
}

#pragma mark - btn收藏 和 分享
- (void)btn_collectAction:(UIButton *)sender
{
    if([self.image_collect.image isEqual:[UIImage imageNamed:@"01collect_16"]])
    {
        //收藏
        self.image_collect.image = [UIImage imageNamed:@"h_collect"];
        self.text_collect.textColor = navi_bar_bg_color;
    }
    else
    {
        //取消收藏
        self.image_collect.image = [UIImage imageNamed:@"01collect_16"];
        self.text_collect.textColor = [UIColor blackColor];
    }
}

- (void)btn_shareAction:(UIButton *)sender
{
    NSLog(@"分享");
    //使用第三方
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

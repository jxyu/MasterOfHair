//
//  shouhuodizhiViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/26.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "shouhuodizhiViewController.h"

#import "AppDelegate.h"
#import "shouhudizhiTableViewCell.h"
#import "EditshouhuoViewController.h"
#import "NewshouhuoViewController.h"
@interface shouhuodizhiViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView * view_head;


@property (nonatomic, strong) UITableView * tableView;

@end

@implementation shouhuodizhiViewController

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
    _lblTitle.text = @"选择收货地址";
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
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self p_headView];
    self.tableView.tableHeaderView = self.view_head;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //注册
    [self.tableView registerClass:[shouhudizhiTableViewCell class] forCellReuseIdentifier:@"cell_shouhuo"];
    
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    shouhudizhiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_shouhuo" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
#warning 跳转编辑收货地址(传不传值)
    EditshouhuoViewController * editshouhuoViewController = [[EditshouhuoViewController alloc] init];
    
    [self showViewController:editshouhuoViewController sender:nil];
}

#pragma mark - 头视图
- (void)p_headView
{
    self.view_head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    self.view_head.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView * view_whith = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 50)];
    view_whith.backgroundColor = [UIColor whiteColor];
    [self.view_head addSubview:view_whith];
    
    UIImageView * head_image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
    head_image.image = [UIImage imageNamed:@"05__03"];
    [view_whith addSubview:head_image];
    
    UILabel * head_label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(head_image.frame) + 10, 10, 150, 30)];
    head_label.text = @"添加收货地址";
    [view_whith addSubview:head_label];
    
    //新建tap手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    //设置点击次数和点击手指数
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [view_whith addGestureRecognizer:tapGesture];
}

#pragma mark - 轻击手势触发方法
-(void)tapGesture:(id)sender
{
    NSLog(@"跳到新建页");
    NewshouhuoViewController * newshouhuoViewController = [[NewshouhuoViewController alloc] init];
    
    [self showViewController:newshouhuoViewController sender:nil];
}



@end

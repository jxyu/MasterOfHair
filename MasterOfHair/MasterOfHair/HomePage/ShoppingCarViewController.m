//
//  ShoppingCarViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/19.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "ShoppingCarViewController.h"

#import "AppDelegate.h"
#import "ShoppingCarTableViewCell.h"
@interface ShoppingCarViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

//下面的结算栏
@property (nonatomic, strong) UIView * bottom_view;

@property (nonatomic, strong) UIButton * bottom_Btnselect;
@property (nonatomic, strong) UILabel * bottom_price;

@property (nonatomic, strong) UIButton * bottom_clearing;

@end

@implementation ShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    _lblTitle.text = @"购物车";
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addRightbuttontitle:@"删除"];
}

//点击设置按钮
- (void)clickRightButton:(UIButton *)sender
{
    NSLog(@"这个删除可要可不要");
}

//显示tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showTabBar];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49 - 50) style:(UITableViewStylePlain)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //注册
    [self.tableView registerClass:[ShoppingCarTableViewCell class] forCellReuseIdentifier:@"cell_shoppingCar"];
}

#pragma mark - 结算栏
- (void)p_bottom
{
    self.bottom_view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, 50)];
    self.bottom_view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottom_view];
    
//全选
    self.bottom_Btnselect = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.bottom_Btnselect.frame = CGRectMake(15, 15, 20, 20);
    [self.bottom_view addSubview:self.bottom_Btnselect];
    [self.bottom_Btnselect setImage:[UIImage imageNamed:@"iconfont-iconquanxuan"] forState:(UIControlStateNormal)];
    [self.bottom_Btnselect setTintColor:[UIColor grayColor]];
    
    [self.bottom_Btnselect addTarget:self action:@selector(bottom_BtnselectAction:) forControlEvents:(UIControlEventTouchUpInside)];

    //
    UILabel * lable_select = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.bottom_Btnselect.frame) + 6, 10, 35, 30)];
    lable_select.text = @"全选";
    lable_select.font = [UIFont systemFontOfSize:15];
    [self.bottom_view addSubview:lable_select];
    
    
    //结算
    self.bottom_clearing = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.bottom_clearing.frame = CGRectMake(SCREEN_WIDTH - 70, 0, 70, 50);
    self.bottom_clearing.backgroundColor = navi_bar_bg_color;
    [self.bottom_view addSubview:self.bottom_clearing];
    [self.bottom_clearing setTitle:@"结算" forState:(UIControlStateNormal)];
    [self.bottom_clearing setTintColor:[UIColor whiteColor]];
    self.bottom_clearing.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [self.bottom_clearing addTarget:self action:@selector(bottom_clearingAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
//合计
    UILabel * label_sum = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lable_select.frame) + 20, 10.5, 30, 30)];
    label_sum.text = @"合计:";
//    label_sum.backgroundColor = [UIColor orangeColor];
    label_sum.font = [UIFont systemFontOfSize:13];
    [self.bottom_view addSubview:label_sum];
    
    self.bottom_price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_sum.frame) + 3, 10.5, SCREEN_WIDTH - 80 - CGRectGetMaxX(label_sum.frame), 30)];
//    self.bottom_price.backgroundColor = [UIColor cyanColor];
    self.bottom_price.text = @"¥ 0.00";
    self.bottom_price.font = [UIFont systemFontOfSize:13];
    self.bottom_price.textColor = [UIColor orangeColor];
    [self.bottom_view addSubview:self.bottom_price];
}

#pragma mark - tableView的代理方法

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingCarTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_shoppingCar"];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    [cell.btn_select addTarget:self action:@selector(btn_selectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 结算栏的点击事件
//全选
- (void)bottom_BtnselectAction:(UIButton *)sender
{
    NSLog(@"全选，可能改变右边的价格");
}

//结算
- (void)bottom_clearingAction:(UIButton *)sender
{
    NSLog(@"结算所有选中的商品");
}

#pragma mark - cell的点击事件
- (void)btn_selectAction:(UIButton *)sender
{
    NSLog(@"点击选中");
}








@end

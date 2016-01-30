//
//  QianbaoViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/30.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "QianbaoViewController.h"

#import "QianbaoTableViewCell.h"
#import "NextqianbaoViewController.h"
@interface QianbaoViewController () <UITableViewDataSource, UITableViewDelegate>

//头视图
@property (nonatomic, strong) UILabel * money;
@property (nonatomic, strong) UILabel * introduce;

//
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation QianbaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self p_navi];
    
    [self p_headView];
    
    [self p_setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navi
- (void)p_navi
{
    _lblTitle.text = [NSString stringWithFormat:@"我的钱包"];
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
    [self example01];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.introduce.frame) + 5, SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.introduce.frame) - 5) style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = [[UIView alloc] init];
    //注册
    [self.tableView registerClass:[QianbaoTableViewCell class] forCellReuseIdentifier:@"cell_qianbao"];
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf.tableView reloadData];
        
        [weakSelf loadNewData];
        
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf.tableView reloadData];
        
        [weakSelf loadNewData];
    }];
}
#pragma mark - tableview的代理
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
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QianbaoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_qianbao" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(1)
    {
        cell.type.text = @"处理中";
        cell.type.textColor = [UIColor orangeColor];
    }
    else
    {
        cell.type.text = @"已完成";
    }
    
    return cell;
}

#pragma mark - 头视图
- (void)p_headView
{
    UIView * view_white = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 10, SCREEN_WIDTH, 50)];
    view_white.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_white];
    
    UILabel * label_1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 30)];
    label_1.text = @"我的钱包余额";
    label_1.font = [UIFont systemFontOfSize:15];
//    label_1.backgroundColor = [UIColor orangeColor];
    [view_white addSubview:label_1];
    
    UIImageView * image_1 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 5 - 20, 15, 20, 20)];
    image_1.image = [UIImage imageNamed:@"iconfont-fanhuiyou"];
    [view_white addSubview:image_1];
    
    self.money = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_1.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(label_1.frame) - 40, 30)];
    self.money.text = @"¥ 1000.00";
    self.money.font = [UIFont systemFontOfSize:15];
    self.money.textAlignment = NSTextAlignmentRight;
    self.money.textColor = [UIColor orangeColor];
//    self.money.backgroundColor = [UIColor orangeColor];
    [view_white addSubview:self.money];
    
    self.introduce = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(view_white.frame) + 10, 100, 20)];
//    self.introduce.textColor = [UIColor grayColor];
    self.introduce.text = @"历史提现列表";
    self.introduce.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.introduce];
    
    //手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [view_white addGestureRecognizer:tapGesture];

}

//手势的点击方法
-(void)tapGesture:(id)sender
{
//    NSLog(@"11111");
    NextqianbaoViewController * Nextqianbao = [[NextqianbaoViewController alloc] init];
    [self showViewController:Nextqianbao sender:nil];
}

#pragma mark - 下拉刷新
- (void)example01
{
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
}

-(void)example02
{
    [self.tableView.footer beginRefreshing];
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    });
    
}








@end

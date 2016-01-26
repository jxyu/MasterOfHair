//
//  querendingdanViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/26.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "querendingdanViewController.h"

#import "AppDelegate.h"
@interface querendingdanViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
//头视图
@property (nonatomic, strong) UIView * head_view;
@property (nonatomic, assign) BOOL isMoren;


@property (nonatomic, strong) UILabel * name;
@property (nonatomic, strong) UILabel * tel;
@property (nonatomic, strong) UILabel * address;

//尾视图
@property (nonatomic, strong) UIView * bottom_view;

@end

@implementation querendingdanViewController

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
    _lblTitle.text = @"确认订单";
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
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    
    [self p_headView];
    [self p_bottomView];
    
    self.tableView.tableHeaderView = self.head_view;
    self.tableView.tableFooterView = self.bottom_view;
    
    //注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_queren"];
}


#pragma mark - tableView
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_queren"];
    
    return cell;
}


#pragma mark - 头视图
- (void)p_headView
{
    if(self.isMoren == NO)
    {
        self.head_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
        self.head_view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UIView * view_white = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 50)];
        view_white.backgroundColor = [UIColor whiteColor];
        [self.head_view addSubview:view_white];
        
        UIImageView * head_image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
        head_image.image = [UIImage imageNamed:@"iconfont-tianjia"];
        [view_white addSubview:head_image];
        
        UILabel * head_label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(head_image.frame) + 10, 10, 150, 30)];
        head_label.text = @"选择收货地址";
        [view_white addSubview:head_label];
    }
    else
    {
        self.head_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        self.head_view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
        image.image = [UIImage imageNamed:@"white_bg"];
        [self.head_view addSubview:image];
        
        CGFloat length_x = (SCREEN_WIDTH - 50) / 2;

        self.name = [[UILabel alloc] init];
        self.name.frame = CGRectMake(20, 10, length_x, 25);
        self.name.text = @"哈啊哈";
        self.name.font = [UIFont systemFontOfSize:18];
        [self.head_view addSubview:self.name];
        

        self.tel = [[UILabel alloc] init];
        self.tel.frame = CGRectMake(CGRectGetMaxX(self.name.frame) + 10, 10, length_x, 25);
        self.tel.text = @"1888888888888";
        self.tel.textAlignment = NSTextAlignmentRight;
        [self.head_view addSubview:self.tel];
        
        
        self.address = [[UILabel alloc] init];
        self.address.frame = CGRectMake(20, CGRectGetMaxY(self.name.frame) + 15, SCREEN_WIDTH - 40, 34);
        self.address.text = @"山东省临沂市山东省临沂市山东省临沂市山东省临沂市";
        self.address.font = [UIFont systemFontOfSize:14];
        self.address.numberOfLines = 2;
        [self.head_view addSubview:self.address];
    }
    
    //新建tap手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    //设置点击次数和点击手指数
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.head_view addGestureRecognizer:tapGesture];
}

#pragma mark - 轻击手势触发方法
-(void)tapGesture:(id)sender
{
    NSLog(@"跳到选择页");
}

#pragma mark - 尾视图
- (void)p_bottomView
{
    
}











@end

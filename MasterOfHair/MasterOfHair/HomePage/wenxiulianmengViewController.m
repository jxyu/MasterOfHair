//
//  wenxiulianmengViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/25.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "wenxiulianmengViewController.h"
#import "AppDelegate.h"
#import "LocationViewController.h"


#import "wenxiuFactoryTableViewCell.h"
#import "wenxiuPeopleTableViewCell.h"
@interface wenxiulianmengViewController () <UITableViewDataSource, UITableViewDelegate>

//上面的btn
@property (nonatomic, strong) UIView * top_white;
@property (nonatomic, strong) UIButton * top_btnPeople;
@property (nonatomic, strong) UIButton * top_btnFactory;
@property (nonatomic, strong) UIView * top_viewPeople;
@property (nonatomic, strong) UIView * top_viewFactory;

@property (nonatomic, assign) BOOL isTeacher;

//tableView
@property (nonatomic, strong) UITableView * tableView;



@end

@implementation wenxiulianmengViewController

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
    _lblTitle.text = [NSString stringWithFormat:@"纹绣联盟"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    
    //右边为定位
    [self addRightbuttontitle:@"临沂"];
    _lblRight.font = [UIFont systemFontOfSize:18];
    //    _lblRight.backgroundColor = [UIColor orangeColor];
    _lblRight.frame = CGRectMake(SCREEN_WIDTH - 65, 19, 50, 44);
    _btnRight.frame = _lblRight.frame;
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
    
    [self example01];
}

- (void)clickRightButton:(UIButton *)sender
{
    LocationViewController * locationViewController = [[LocationViewController alloc] init];
    [self showViewController:locationViewController sender:nil];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.isTeacher = 0;
    
    [self p_topView];
    
    [self p_tableView];
}

- (void)p_topView
{
    self.top_white = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50)];
    self.top_white.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.top_white];
    
    int length_x = SCREEN_WIDTH / 2;
    
    //合作店
    self.top_btnFactory = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.top_btnFactory.frame = CGRectMake(0, 0, length_x, 50);
    [self.top_btnFactory setTitle:@"合作店" forState:(UIControlStateNormal)];
    [self.top_btnFactory setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    self.top_btnFactory.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.top_white addSubview:self.top_btnFactory];
    
    [self.top_btnFactory addTarget:self action:@selector(top_btnFactoryAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.top_viewFactory = [[UIView alloc] initWithFrame:CGRectMake(length_x / 2 - 40, 48, 80, 2)];
    self.top_viewFactory.backgroundColor = navi_bar_bg_color;
    [self.top_white addSubview:self.top_viewFactory];
    
    
    //纹绣师
    self.top_btnPeople = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.top_btnPeople.frame = CGRectMake(length_x, 0, length_x, 50);
    [self.top_btnPeople setTitle:@"纹绣师" forState:(UIControlStateNormal)];
    [self.top_btnPeople setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.top_btnPeople.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.top_white addSubview:self.top_btnPeople];
    
    [self.top_btnPeople addTarget:self action:@selector(top_btnPeopleAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.top_viewPeople = [[UIView alloc] initWithFrame:CGRectMake(length_x +  length_x / 2 - 40, 48, 80, 2)];
    self.top_viewPeople.backgroundColor = navi_bar_bg_color;
    [self.top_white addSubview:self.top_viewPeople];
    self.top_viewPeople.hidden = YES;
}

#pragma mark - 合作店 和 纹绣师的btn
//合作店的btn
- (void)top_btnFactoryAction:(UIButton *)sender
{
    self.isTeacher = NO;
    
    //变颜色
    [self.top_btnFactory setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    self.top_viewFactory.hidden = NO;
    
    [self.top_btnPeople setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.top_viewPeople.hidden = YES;
    
    [self example01];
    //通知主线程刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        //回调或者说是通知主线程刷新，
        [self.tableView reloadData];
    });
}

//纹绣师的btn
- (void)top_btnPeopleAction:(UIButton *)sender
{
    self.isTeacher = YES;

    //变颜色
    [self.top_btnFactory setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.top_viewFactory.hidden = YES;
    
    [self.top_btnPeople setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    self.top_viewPeople.hidden = NO;
    
    
    [self example01];
    
    //通知主线程刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        //回调或者说是通知主线程刷新，
        [self.tableView reloadData];
    });
}

#pragma mark - tableView
- (void)p_tableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50 + 64, SCREEN_WIDTH, SCREEN_HEIGHT - 50 - 64) style:(UITableViewStylePlain)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    
    //注册
    [self.tableView registerClass:[wenxiuFactoryTableViewCell class] forCellReuseIdentifier:@"cell_wenxiuFactory"];
    
    [self.tableView registerClass:[wenxiuPeopleTableViewCell class] forCellReuseIdentifier:@"cell_wenxiulianmeng"];
    
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

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isTeacher == 0)
    {
        return 15;
    }
    
    return 5;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isTeacher == 0)
    {
        return 200;
    }
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(self.isTeacher == 0)
    {
        wenxiuFactoryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_wenxiuFactory"];
        
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [cell.image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];

        
        return cell;
    }
    else
    {
        wenxiuPeopleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_wenxiulianmeng"];
        
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [cell.image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

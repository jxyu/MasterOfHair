//
//  KechengbaomingViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/28.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "KechengbaomingViewController.h"

#import "KechengbaomingTableViewCell.h"
#import "kechengmingchengViewController.h"
@interface KechengbaomingViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation KechengbaomingViewController

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
    _lblTitle.text = [NSString stringWithFormat:@"课程报名"];
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //注册
    [self.tableView registerClass:[KechengbaomingTableViewCell class] forCellReuseIdentifier:@"cell_kecheng"];
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
    return 260;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KechengbaomingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_kecheng" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    kechengmingchengViewController * kechengmingcheng = [[kechengmingchengViewController alloc] init];
    [self showViewController:kechengmingcheng sender:nil];
}

















@end

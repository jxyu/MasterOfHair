//
//  NextFenxiaozhongxin1ViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/29.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "NextFenxiaozhongxin1ViewController.h"

#import "Fenxiaozhongxin_Model.h"

#import "NextFenxiaoTableViewCell.h"
@interface NextFenxiaozhongxin1ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * arr_data;

@property (nonatomic, assign) NSInteger page;

@end

@implementation NextFenxiaozhongxin1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    _lblTitle.text = [NSString stringWithFormat:@"二级分销会员"];
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
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self p_dataALL];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf loadNewData];
        
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self p_dataALL1];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf loadNewData];
    }];
    
    //注册
    [self.tableView registerClass:[NextFenxiaoTableViewCell class] forCellReuseIdentifier:@"cell_nextFenxiao"];
}

#pragma mark - tableView代理

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr_data.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NextFenxiaoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_nextFenxiao" forIndexPath:indexPath];
    
    if(self.arr_data.count != 0)
    {
        Fenxiaozhongxin_Model * model = self.arr_data[indexPath.row];
        
        [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/member/%@",Url_pic,model.member_headpic]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
        
        cell.account.text = [NSString stringWithFormat:@"%@",model.member_username];
        
        cell.number.text = [NSString stringWithFormat:@"%@单",model.order_count];
        
        cell.price.text = [NSString stringWithFormat:@"￥ %@",model.percentage];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 数据数据
- (void)p_dataALL
{
    self.page = 1;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"GetFirstLevelMembers:"];
    
    [dataprovider GetSecondLevelMembersWithMember_id:[userdefault objectForKey:@"member_id"] pagenumber:@"1" pagesize:@"15"];
}

- (void)p_dataALL1
{
    self.page ++;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"GetFirstLevelMembers:"];
    
    [dataprovider GetSecondLevelMembersWithMember_id:[userdefault objectForKey:@"member_id"] pagenumber:[NSString stringWithFormat:@"%ld",(long)self.page] pagesize:@"15"];
}


// 数据
- (void)GetFirstLevelMembers:(id )dict
{
    //    NSLog(@"%@",dict);
    
    if(self.page == 1)
    {
        self.arr_data = nil;
    }
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"memberlist"])
            {
                Fenxiaozhongxin_Model * model = [[Fenxiaozhongxin_Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_data addObject:model];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新tableView(记住,要更新放在主线程中)
                
                [self.tableView reloadData];
            });
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] maskType:SVProgressHUDMaskTypeBlack];
    }
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

#pragma mark - 懒加载
- (NSMutableArray *)arr_data
{
    if(_arr_data == nil)
    {
        self.arr_data = [NSMutableArray array];
    }
    return _arr_data;
}


@end

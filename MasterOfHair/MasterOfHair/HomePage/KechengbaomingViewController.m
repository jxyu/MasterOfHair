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

#import "Model_Kechengbm.h"

@interface KechengbaomingViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

//数据
@property (nonatomic, strong) NSMutableArray * arr_data;
@property (nonatomic, assign) NSInteger page;
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
    [self example01];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self p_data];
        
        [weakSelf.tableView reloadData];
        [weakSelf loadNewData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self p_data1];
        
        [weakSelf.tableView reloadData];
        [weakSelf loadNewData];
    }];
    
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
    return self.arr_data.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KechengbaomingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_kecheng" forIndexPath:indexPath];

    cell.backgroundColor = [UIColor whiteColor];
    
    if(self.arr_data.count != 0)
    {
        Model_Kechengbm * model = self.arr_data[indexPath.row];
        
        cell.name.text = [NSString stringWithFormat:@"%@",model.course_name];
        
        NSString * str =  [NSString stringWithFormat:@"%@uploads/course/%@",Url_pic,model.image];
        [cell.image sd_setImageWithURL:[NSURL URLWithString:str]placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
        
    }
    else
    {
        [cell.image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];

    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Model_Kechengbm * model = self.arr_data[indexPath.row];
    
    kechengmingchengViewController * kechengmingcheng = [[kechengmingchengViewController alloc] init];
    
    kechengmingcheng.course_id = model.course_id;
    
    kechengmingcheng.image_url = model.image;
    
    [self showViewController:kechengmingcheng sender:nil];
}

#pragma mark - 数据
- (void)p_data
{
    self.page = 1;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"Course:"];
    
    [dataprovider CourseWithPagenumber:@"1" status:@"2"];
}

- (void)p_data1
{
    self.page ++;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"Course:"];
    
    [dataprovider CourseWithPagenumber:[NSString stringWithFormat:@"%ld",self.page] status:@"2"];
}

//数据
- (void)Course:(id )dict
{
//    NSLog(@"%@",dict);
    
    if(self.page == 1)
    {
        self.arr_data = nil;
    }
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"courselist"])
            {
                Model_Kechengbm * model = [[Model_Kechengbm alloc] init];
                
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
        
    }
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


#pragma mark - 下拉刷新
- (void)example01
{
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}

-(void)example02
{
    [self.tableView.mj_footer beginRefreshing];
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    });
    
}










@end

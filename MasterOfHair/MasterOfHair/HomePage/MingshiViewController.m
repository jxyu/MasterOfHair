//
//  MingshiViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/25.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "MingshiViewController.h"
#import "AppDelegate.h"

#import "wenxiuPeopleTableViewCell.h"
#import "NextMingshiViewController.h"
#import "Mingshimingdian_Model.h"
@interface MingshiViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * arr_data;

@property (nonatomic, assign) NSInteger page;

@end

@implementation MingshiViewController

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
    _lblTitle.text = [NSString stringWithFormat:@"名师名店"];
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
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    
    //注册
    [self.tableView registerClass:[wenxiuPeopleTableViewCell class] forCellReuseIdentifier:@"cell_mingshi"];
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self p_data];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf loadNewData];
        
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self p_data1];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf loadNewData];
    }];
}

#pragma mark - tableView
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
    wenxiuPeopleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_mingshi" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [cell.image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
    
    if(self.arr_data.count != 0)
    {
        Mingshimingdian_Model * model = self.arr_data[indexPath.row];
        
        cell.name.text = model.teacher_name;
        
        cell.detail.text = model.describe;
        
        NSString * str = [NSString stringWithFormat:@"%@uploads/teacher/%@",Url,model.image];
        [cell.image sd_setImageWithURL:[NSURL URLWithString:str]placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
    }
    
    return cell;
}

- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NextMingshiViewController * NextMingshi = [[NextMingshiViewController alloc] init];
    
    Mingshimingdian_Model * model = self.arr_data[indexPath.row];
    
    NextMingshi.teacher_id = model.teacher_id;
    
    [self showViewController:NextMingshi sender:nil];
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

#pragma mark - 数据
- (void)p_data
{
    self.page = 1;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"FamousTeacher:"];
    
    [dataprovider FamousTeacherpagenumber:@"1" pagesize:@"15"];
}

- (void)p_data1
{
    self.page ++;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"FamousTeacher:"];
    
    [dataprovider FamousTeacherpagenumber:[NSString stringWithFormat:@"%ld",self.page] pagesize:@"15"];
}

//数据
- (void)FamousTeacher:(id )dict
{
    NSLog(@"%@",dict);
    
    if(self.page == 1)
    {
        self.arr_data = nil;
    }
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"teacherlist"])
            {
                Mingshimingdian_Model * model = [[Mingshimingdian_Model alloc] init];
                
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



@end

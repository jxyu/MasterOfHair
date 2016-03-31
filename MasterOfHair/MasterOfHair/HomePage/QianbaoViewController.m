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
#import "Qianbao_Model.h"
@interface QianbaoViewController () <UITableViewDataSource, UITableViewDelegate>

//头视图
@property (nonatomic, strong) UILabel * money;
@property (nonatomic, strong) UILabel * introduce;

//
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * arr_data;

@property (nonatomic, assign) NSInteger page;

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
    [self p_dataALL];
    
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
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = [[UIView alloc] init];
    //注册
    [self.tableView registerClass:[QianbaoTableViewCell class] forCellReuseIdentifier:@"cell_qianbao"];
    
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
#pragma mark - tableview的代理
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
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QianbaoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_qianbao" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(self.arr_data.count != 0)
    {
        Qianbao_Model * model = self.arr_data[indexPath.row];
        
        cell.money.text = [NSString stringWithFormat:@"￥ %@",model.change_amount];
        
        switch ([model.treatment_status integerValue])
        {
            case 0:
            {
                cell.type.text = @"处理中";
                cell.type.textColor = [UIColor orangeColor];
            }
                break;
            case 1:
            {
                cell.type.text = @"已完成";
                cell.type.textColor = [UIColor blackColor];

            }
                break;
            default:
                break;
        }
        
        
        
        NSString* string = model.change_time;
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate * tiem = [format dateFromString:string];
        NSDate * x = [tiem dateByAddingTimeInterval:8 * 60 * 60];
//        NSLog(@"%@",[self compareDate:x]);
        
        

        
        
        NSString * str = [model.change_time substringFromIndex:11];
        cell.time.text = str;
        

        NSString * str2 = [self compareDate:x];
        
        if([str2 isEqualToString:@"今天"] || [str2 isEqualToString:@"昨天"])
        {
            cell.month.text = [NSString stringWithFormat:@"%@",[self compareDate:x]];
            
        }
        else
        {
            NSString * str_yy = [str2 substringToIndex:10];
            
            NSString * str_mm_dd = [str_yy substringFromIndex:5];
            
            cell.month.text = [NSString stringWithFormat:@"%@",str_mm_dd];
        }
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
    self.money.text = @"¥ 0.00";
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

#pragma mark - 数据
- (void)p_data
{
    self.page = 1;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"update:"];
    
    [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] record_type:@"1" pagenumber:@"1" pagesize:@"15"];
}

- (void)p_data1
{
    self.page ++ ;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"update:"];
    
    [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] record_type:@"1" pagenumber:[NSString stringWithFormat:@"%ld",(long)self.page] pagesize:@"15"];
}


#pragma mark - 数据
- (void)update:(id )dict
{
//    NSLog(@"%@",dict);
    
    if(self.page == 1)
    {
        self.arr_data = nil;
    }
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"cashRecordlist"])
            {
                Qianbao_Model * modle = [[Qianbao_Model alloc] init];
                
                [modle setValuesForKeysWithDictionary:dic];
                
                [self.arr_data addObject:modle];
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

#pragma mark - 数据数据
- (void)p_dataALL
{    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"GetMembers:"];
    
    [dataprovider GetMembersWithMember_id:[userdefault objectForKey:@"member_id"]];
}

// 数据
- (void)GetMembers:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSArray * arr_ = dict[@"data"][@"memberlist"];
            
            NSDictionary * dic = arr_.firstObject;
            
            self.money.text = [NSString stringWithFormat:@"￥ %@",dic[@"wallet_balance"]];
            
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

#pragma mark - 懒加载

- (NSMutableArray *)arr_data
{
    if(_arr_data == nil)
    {
        self.arr_data = [NSMutableArray array];
    }
    
    return _arr_data;
}


-(NSString *)compareDate:(NSDate *)date{
    
    NSDate * today = [NSDate date];
    NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow:-86400];
    NSDate * refDate = date;
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * refDateString = [[refDate description] substringToIndex:10];
    
    if ([refDateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([refDateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }
    else
    {
        return [self formatDate:date];
    }
}

-(NSString *)formatDate:(NSDate *)date{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //[formatter setDateFormat:@"MM-dd    HH:mm"];
    NSString* str = [formatter stringFromDate:date];
    return str;
    
}

@end

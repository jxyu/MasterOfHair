//
//  wenxiulianmengViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/25.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "wenxiulianmengViewController.h"
#import "AppDelegate.h"


#import "wenxiuFactoryTableViewCell.h"
#import "wenxiuPeopleTableViewCell.h"
#import "Wenxiulianmeng_Model.h"
#import "GaojijishiViewController.h"
#import "HezuomingdianViewController.h"
#import "WenxiulianmengLocationViewController.h"
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

@property (nonatomic, strong) NSMutableArray * arr_data;

@property (nonatomic, assign) NSInteger page;

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
//    [self addRightbuttontitle:@"临沂"];
//    _lblRight.font = [UIFont systemFontOfSize:18];
    //    _lblRight.backgroundColor = [UIColor orangeColor];
    _lblRight.frame = CGRectMake(SCREEN_WIDTH - 105, 19, 90, 44);
    _btnRight.frame = _lblRight.frame;
    _lblRight.font = [UIFont systemFontOfSize:15];
    _lblRight.numberOfLines = 1;
    _lblRight.textAlignment = NSTextAlignmentRight;

}

//返回
- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    if([[userdefault objectForKey:@"city_id"] length] == 0)
    {
        [self addRightbuttontitle:@"定位"];
        
        if([[userdefault objectForKey:@"diquweizhi1"] length] == 0)
        {
            [self addRightbuttontitle:@"定位"];
            
            [userdefault setObject:@"183" forKey:@"diquweizhi_id1"];
        }
        else
        {
            [self addRightbuttontitle:[userdefault objectForKey:@"diquweizhi1"]];
        }
    }
    else
    {
        [self addRightbuttontitle:[userdefault objectForKey:@"city_name"]];
        
        if([[userdefault objectForKey:@"diquweizhi1"] length] == 0)
        {
            [self addRightbuttontitle:[userdefault objectForKey:@"city_name"]];

            [userdefault setObject:[userdefault objectForKey:@"city_id"] forKey:@"diquweizhi_id1"];
        }
        else
        {
            [self addRightbuttontitle:[userdefault objectForKey:@"diquweizhi1"]];
        }
    }

    
    
    [self example01];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

- (void)clickRightButton:(UIButton *)sender
{
    WenxiulianmengLocationViewController * locationViewController = [[WenxiulianmengLocationViewController alloc] init];
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
    [self.top_btnPeople setTitle:@"高级技师" forState:(UIControlStateNormal)];
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
    [SVProgressHUD showWithStatus:@"数据加载中..." maskType:(SVProgressHUDMaskTypeBlack)];
    
    self.isTeacher = NO;
    
    //变颜色
    [self.top_btnFactory setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    self.top_viewFactory.hidden = NO;
    
    [self.top_btnPeople setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.top_viewPeople.hidden = YES;
    
    [self example01];
    
    [self p_data];
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

    [SVProgressHUD showWithStatus:@"数据加载中..." maskType:(SVProgressHUDMaskTypeBlack)];
    
    //变颜色
    [self.top_btnFactory setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.top_viewFactory.hidden = YES;
    
    [self.top_btnPeople setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    self.top_viewPeople.hidden = NO;
    
    
    [self example01];
    [self p_data_teacher];

    
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
        
        if(self.isTeacher == 0)
        {
            [self p_data];
        }
        else
        {
            [self p_data_teacher];
        }
        
        
        [weakSelf.tableView reloadData];
        
        [weakSelf loadNewData];
        
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if(self.isTeacher == 0)
        {
            [self p_data1];
        }
        else
        {
//            NSLog(@"1");
            [self p_data_teacher1];
        }
        
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
//    if (self.isTeacher == 0)
//    {
//        return self.arr_data.count;
//    }
    
    return self.arr_data.count;
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

        
        if(self.arr_data.count != 0)
        {
            Wenxiulianmeng_Model * model = self.arr_data[indexPath.row];
            
            NSString * str1 =  [NSString stringWithFormat:@"%@uploads/store/%@",Url_pic,model.store_image];
            [cell.image sd_setImageWithURL:[NSURL URLWithString:str1]placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
            
            cell.name.text = model.store_name;
        }
        
        return cell;
    }
    else
    {
        wenxiuPeopleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_wenxiulianmeng"];
        
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [cell.image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];

        
        if(self.arr_data.count != 0)
        {
            Wenxiulianmeng_Model * model = self.arr_data[indexPath.row];

            NSString * str1 =  [NSString stringWithFormat:@"%@uploads/technician/%@",Url_pic,model.technician_image];
            [cell.image sd_setImageWithURL:[NSURL URLWithString:str1]placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
            
            cell.name.text = model.technician_name;
            
            cell.detail.text = model.technician_describe;
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Wenxiulianmeng_Model * model = self.arr_data[indexPath.row];
    
    if(self.isTeacher == 0)
    {
        HezuomingdianViewController * hezuomingdianViewController = [[HezuomingdianViewController alloc] init];
        
        hezuomingdianViewController.store_id = model.store_id;
        
        [self showViewController:hezuomingdianViewController sender:nil];
    }
    else
    {
        GaojijishiViewController * gaojijishiViewController = [[GaojijishiViewController alloc] init];
        
        gaojijishiViewController.technician_id = model.technician_id;
        
        [self showViewController:gaojijishiViewController sender:nil];
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

#pragma mark - 数据
- (void)p_data
{
    self.page = 1;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"CooperateStore:"];
    
    [dataprovider CooperateStoreWithTeacher_id:[userdefault objectForKey:@"diquweizhi_id1"] pagenumber:@"1" pagesize:@"15"];
    
//    [dataprovider CooperateStoreWithTeacher_id:@"37" pagenumber:@"1" pagesize:@"15"];
}

- (void)p_data1
{
    self.page ++;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"CooperateStore:"];
    
    [dataprovider CooperateStoreWithTeacher_id:[userdefault objectForKey:@"diquweizhi_id1"] pagenumber:[NSString stringWithFormat:@"%ld",(long)self.page] pagesize:@"15"];

//    [dataprovider CooperateStoreWithTeacher_id:@"37" pagenumber:[NSString stringWithFormat:@"%ld",(long)self.page] pagesize:@"15"];
}

//数据
- (void)CooperateStore:(id )dict
{
//    NSLog(@"%@",dict);

    [SVProgressHUD dismiss];
    
    if(self.page == 1)
    {
        self.arr_data = nil;
    }
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"cooperatestorelist"])
            {
                Wenxiulianmeng_Model * model = [[Wenxiulianmeng_Model alloc] init];
                
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

#pragma mark - 数据
- (void)p_data_teacher
{
    self.page = 1;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"SeniorTechnician:"];
    
    [dataprovider SeniorTechnicianWithcity_id:[userdefault objectForKey:@"diquweizhi_id1"] pagenumber:@"1" pagesize:@"15"];
//    NSLog(@"%@",[userdefault objectForKey:@"diquweizhi_id1"]);
    
//    [dataprovider SeniorTechnicianWithcity_id:@"109" pagenumber:@"1" pagesize:@"15"];
}

- (void)p_data_teacher1
{
    self.page ++;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"SeniorTechnician:"];
    
    [dataprovider SeniorTechnicianWithcity_id:[userdefault objectForKey:@"diquweizhi_id1"] pagenumber:[NSString stringWithFormat:@"%ld",self.page] pagesize:@"15"];
    
//    [dataprovider SeniorTechnicianWithcity_id:@"109" pagenumber:[NSString stringWithFormat:@"%ld",self.page] pagesize:@"15"];
}


//数据
- (void)SeniorTechnician:(id )dict
{
//    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];
    
    if(self.page == 1)
    {
        self.arr_data = nil;
    }
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"seniortechnicianlist"])
            {
                Wenxiulianmeng_Model * model = [[Wenxiulianmeng_Model alloc] init];
                
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

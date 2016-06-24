//
//  WenxiulanmengdingdanViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/3/16.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "WenxiulanmengdingdanViewController.h"
#import "WenxiulanmengdingdanTableViewCell.h"
#import "Wenxiulanmengdingdan_Model.h"
#import "wenxiulanmengdingdandetailViewController.h"
@interface WenxiulanmengdingdanViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray * arr_data;

@end

@implementation WenxiulanmengdingdanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SVProgressHUD showWithStatus:@"加载数据中,请稍等..." maskType:SVProgressHUDMaskTypeBlack];
    
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
    _lblTitle.text = @"纹绣联盟订单";
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    _lblLeft.text=@"返回";
    _lblLeft.textAlignment=NSTextAlignmentLeft;
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
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:self.tableView];
    
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self p_data_state];
        
        [weakSelf.tableView reloadData];
        [weakSelf loadNewData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self p_data_state1];
        
        [weakSelf.tableView reloadData];
        [weakSelf loadNewData];
    }];
    
    //注册
    [self.tableView registerClass:[WenxiulanmengdingdanTableViewCell class] forCellReuseIdentifier:@"cell_wenxiu"];
}

#pragma mark - 代理
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
    return 145;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WenxiulanmengdingdanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_wenxiu" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(self.arr_data.count != 0)
    {
        Wenxiulanmengdingdan_Model * model = self.arr_data[indexPath.row];
        
        cell.number.text = [NSString stringWithFormat:@"订单编号:%@",model.order_code];
        
        NSString * str = [model.order_time substringToIndex:10];
        cell.date.text = str;
        
        cell.name.text = model.store_name;
        
        cell.taocan_name.text = model.product_name;
        
        cell.teacher_name.text = [NSString stringWithFormat:@"技师:%@",model.technician_name];
        
        cell.price.text = [NSString stringWithFormat:@"￥ %@",model.order_payable];
        
        cell.sell.text = [NSString stringWithFormat:@"实际支付: ￥ %@",model.order_realpay];
    }
    
    return cell;
}

- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if(self.arr_data[indexPath.row] != nil)
//    {
//        wenxiulanmengdingdandetailViewController * wenxiulanmengdingdandetail = [[wenxiulanmengdingdandetailViewController alloc] init];
//        
//        [self showViewController:wenxiulanmengdingdandetail sender:nil];
//    }
}

#pragma mark - 删除
//删除cell
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //做删除操作，并调接口删除后台数据
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除该订单" preferredStyle:(UIAlertControllerStyleAlert)];
    
    [self presentViewController:alert animated:YES completion:^{
        
        
    }];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
       
        Wenxiulanmengdingdan_Model * model = self.arr_data[indexPath.row];
        
        DataProvider * dataprovider=[[DataProvider alloc] init];
        
        [dataprovider setDelegateObject:self setBackFunctionName:@"delete:"];
        
        [dataprovider deleteWithStore_id:model.order_id];
        
    }];
    
    [alert addAction:action1];
    
}

- (void)delete:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"删除成功" maskType:(SVProgressHUDMaskTypeBlack)];
            
            [self p_data_state];
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
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

#pragma mark - 数据
//所有的
- (void)p_data_state
{
    self.page = 1;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getOrders:"];
    
    [dataprovider GetOrdersWithmember_id:[userdefault objectForKey:@"member_id"] union_order_status:@"2" pagenumber:@"1" pagesize:@"15"];
}

//所有的
- (void)p_data_state1
{
    self.page ++;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getOrders:"];
    
    [dataprovider GetOrdersWithmember_id:[userdefault objectForKey:@"member_id"] union_order_status:@"2" pagenumber:[NSString stringWithFormat:@"%ld",(long)self.page] pagesize:@"15"];
}

- (void)getOrders:(id )dict
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
            for (NSDictionary * dic in dict[@"data"][@"orderlist"])
            {
                Wenxiulanmengdingdan_Model * model = [[Wenxiulanmengdingdan_Model alloc] init];
                
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

#pragma mark - 懒加载
- (NSMutableArray * )arr_data
{
    if(_arr_data == nil)
    {
        self.arr_data = [NSMutableArray array];
    }
    
    return _arr_data;
}

@end

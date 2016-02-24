//
//  SelectshouhuoViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/27.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "SelectshouhuoViewController.h"

#import "AppDelegate.h"
#import "shouhuodizhiViewController.h"
#import "shouhudizhiTableViewCell.h"
#import "Shouhudizhi_Model.h"
@interface SelectshouhuoViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

//数据
@property (nonatomic, strong) NSMutableArray * arr_data;

@end

@implementation SelectshouhuoViewController

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
    _lblTitle.text = @"请选择收货地址";
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    
    [self addRightbuttontitle:@"管理"];
}
//返回
- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [self p_data];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

//右管理
- (void)clickRightButton:(UIButton *)sender
{
    shouhuodizhiViewController * shouhuodizhi = [[shouhuodizhiViewController alloc] init];
    
    [self showViewController:shouhuodizhi sender:nil];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //注册
    [self.tableView registerClass:[shouhudizhiTableViewCell class] forCellReuseIdentifier:@"cell_shouhuo"];
}

#pragma mark - tableView的代理

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
    Shouhudizhi_Model * model = self.arr_data[indexPath.row];
    
    shouhudizhiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_shouhuo" forIndexPath:indexPath];
    
    cell.name.text = model.consignee;
    cell.tel.text = model.mobile;
    
    NSString * str = [NSString stringWithFormat:@"%@%@%@%@",[model.province_name length]== 0 ? @"" : model.province_name,[model.city_name length]== 0 ? @"" : model.city_name,[model.area_name length]== 0 ? @"" : model.area_name ,[model.address length]== 0 ? @"" : model.address];
    cell.address.text = str;
    
    if([model.is_default isEqualToString:@"1"])
    {
        cell.address.text = [NSString stringWithFormat:@"[默认] %@",str];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
#warning +++++
    NSLog(@"上个页改变状态，赋值");
}

#pragma mark - 接口数据
- (void)p_data
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getAddresses:"];
    
    [dataprovider getAddressesWithMember_id:[userdefault objectForKey:@"member_id"]];
}

//接口部分
- (void)getAddresses:(id )dict
{
    NSLog(@"%@",dict);
    
    self.arr_data = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSArray * arr = dict[@"data"][@"addresslist"];
            
            for (NSDictionary * dic in arr)
            {
                Shouhudizhi_Model * model = [[Shouhudizhi_Model alloc] init];
                
                
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
- (NSMutableArray *)arr_data
{
    if(_arr_data == nil)
    {
        self.arr_data = [NSMutableArray array];
    }
    return _arr_data;
}




@end

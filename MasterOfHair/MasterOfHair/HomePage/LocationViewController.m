//
//  LocationViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/22.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "LocationViewController.h"

#import "AppDelegate.h"
#import "ChineseString.h"
#import "loca_Model.h"
@interface LocationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

//数据
@property (nonatomic, strong) NSMutableArray * arr_indexData;
@property (nonatomic, strong) NSMutableArray * arr_letterResult;
@property (nonatomic, strong) NSMutableArray * arr_data;

@property (nonatomic, strong) NSMutableArray * arr_all;
//
@property (nonatomic, strong) UIView * headView;

@property (nonatomic, strong) UILabel * address;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SVProgressHUD showWithStatus:@"加载数据中,请稍等..." maskType:SVProgressHUDMaskTypeBlack];
    
    [self p_data];
    
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
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
//    [userdefault setObject:[NSString stringWithFormat:@"%@",dict[@"data"][@"city_id"]] forKey:@"city_id"];
//    [userdefault setObject:[NSString stringWithFormat:@"%@",dict[@"data"][@"city_name"]] forKey:@"city_name"];
    
    if([[userdefault objectForKey:@"city_name"] length] == 0)
    {
        _lblTitle.text = [NSString stringWithFormat:@"当前位置"];
    }
    else
    {
        _lblTitle.text = [NSString stringWithFormat:@"当前位置- %@",[userdefault objectForKey:@"city_name"]];
    }
    
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
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    
    [self p_headView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableHeaderView = self.headView;
    
    
    //注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_diqu"];
}

#pragma mark -
- (void)p_headView
{
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
    self.headView.backgroundColor = [UIColor whiteColor];
    
    self.address = [[UILabel alloc] initWithFrame:CGRectMake(15, 35 / 2, SCREEN_WIDTH - 50, 30)];
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    //183
//    [userdefault setObject:[NSString stringWithFormat:@""] forKey:@"city_id"];
//    [userdefault setObject:[NSString stringWithFormat:@""] forKey:@"city_name"];
    
    if([[userdefault objectForKey:@"city_name"] length] == 0)
    {
        self.address.text = [NSString stringWithFormat:@"无GPS定位"];
    }
    else
    {
        self.address.text = [NSString stringWithFormat:@"%@  GPS定位",[userdefault objectForKey:@"city_name"]];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        tapGesture.numberOfTapsRequired = 1; //点击次数
        tapGesture.numberOfTouchesRequired = 1; //点击手指数
        [self.headView addGestureRecognizer:tapGesture];
    }
    
    [self.headView addSubview:self.address];
    
}

#pragma mark - tableView代理
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.arr_indexData count];
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arr_letterResult[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_diqu" forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.arr_letterResult objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%@",[[self.arr_letterResult objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    [userdefault setObject:[[self.arr_letterResult objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] forKey:@"diquweizhi"];
    
    for (loca_Model * model in self.arr_all)
    {
        NSString * str = [[self.arr_letterResult objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        
        if([model.area_name isEqualToString:str])
        {
            [userdefault setObject:model.area_id forKey:@"diquweizhi_id"];
        }
    }
    
//    NSLog(@"%@",[userdefault objectForKey:@"diquweizhi_id"]);
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * key = [self.arr_indexData objectAtIndex:section];
    
    return key;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.arr_indexData;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

#pragma mark - 解析数据
- (void)p_data
{
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"area:"];
    [dataprovider area];
}

- (void)area:(id )dict
{
//    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"citylist"])
            {
                [self.arr_data addObject:dic[@"area_name"]];
                
                loca_Model * model = [[loca_Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_all addObject:model];
                
            }
            
            self.arr_indexData = [ChineseString IndexArray:self.arr_data];
            self.arr_letterResult = [ChineseString LetterSortArray:self.arr_data];
            
            
            
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
- (NSMutableArray *)arr_indexData
{
    if(_arr_indexData == nil)
    {
        self.arr_indexData = [NSMutableArray array];
    }
    return _arr_indexData;
}

- (NSMutableArray *)arr_letterResult
{
    if(_arr_letterResult == nil)
    {
        self.arr_letterResult = [NSMutableArray array];
    }
    return _arr_letterResult;
}

- (NSMutableArray *)arr_data
{
    if(_arr_data == nil)
    {
        self.arr_data = [NSMutableArray array];
    }
    return _arr_data;
}

- (NSMutableArray *)arr_all
{
    if(_arr_all == nil)
    {
        self.arr_all = [NSMutableArray array];
    }
    
    return _arr_all;
}

#pragma mark - 手势点击事件
- (void)tapGesture:(id)sender
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];

    [userdefault setObject:[userdefault objectForKey:@"city_id"] forKey:@"diquweizhi_id"];
    [userdefault setObject:[userdefault objectForKey:@"city_name"] forKey:@"diquweizhi"];
    
    [self.navigationController popViewControllerAnimated:YES];
}





@end

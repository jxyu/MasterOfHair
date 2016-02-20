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
@interface LocationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

//数据
@property (nonatomic, strong) NSMutableArray * arr_indexData;
@property (nonatomic, strong) NSMutableArray * arr_letterResult;
@property (nonatomic, strong) NSMutableArray * arr_data;

//
@property (nonatomic, strong) UIView * headView;

@property (nonatomic, strong) UILabel * address;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    _lblTitle.text = [NSString stringWithFormat:@"当前位置- %@",@""];
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
    self.address.text = [NSString stringWithFormat:@"%@  GPS定位",@"临沂"];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"arealist"])
            {
                [self.arr_data addObject:dic[@"area_name"]];
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








@end

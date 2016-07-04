//
//  xinziViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/3/22.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "xinziViewController.h"
#import "Zhaopingfeilei_Model.h"

@interface xinziViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * arr_data;

@property (nonatomic, assign) NSInteger page;

@end

@implementation xinziViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SVProgressHUD showWithStatus:@"加载数据中,请稍等..." ];
    
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
    _lblTitle.text = [NSString stringWithFormat:@"薪资区间"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    _btnLeft.hidden = YES;

    //    [self addLeftButton:@"iconfont-fanhui"];
    [self addRightbuttontitle:@"关闭"];
}

//返回
- (void)clickRightButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    self.page = 100000000;
    
    //保存
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:@"" forKey:@"zhaopingxinzi_name_1"];
    [userdefault setObject:@"" forKey:@"zhaopingxinzi_id_1"];
    
    [self p_data];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIView * view_head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    
    self.tableView.tableHeaderView = view_head;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr_data.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView * view_bg = [[UIView alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 20, 50)];
    view_bg.tag = indexPath.row + 100;
    //    view_bg.layer.borderColor = [UIColor grayColor].CGColor;
    //    view_bg.layer.borderWidth = 1;
    [cell addSubview:view_bg];
    
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, SCREEN_WIDTH - 30, 30)];
    name.text = @"wolaji";
    name.textAlignment = NSTextAlignmentCenter;
    [view_bg addSubview:name];
    
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 20 - 15, 35, 15, 15)];
    image.tag = indexPath.row + 400;
    image.image = [UIImage imageNamed:@"01sdjjdijsidjs_03"];
    [view_bg addSubview:image];
    
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = view_bg.frame;
    btn.tag = indexPath.row + 800;
    btn.layer.borderColor = [UIColor grayColor].CGColor;
    btn.layer.borderWidth = 1;
    [cell addSubview:btn];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    if(self.arr_data != 0)
    {
        Zhaopingfeilei_Model * model = self.arr_data[indexPath.row];
        name.text = model.status_name;
        
        if(indexPath.row == self.page)
        {
            btn.layer.borderColor = navi_bar_bg_color.CGColor;
            image.hidden = NO;
        }
        else
        {
            btn.layer.borderColor = [UIColor grayColor].CGColor;
            image.hidden = YES;
        }
    }
    
    
    return cell;
}

- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 点击
- (void)btnAction:(UIButton *)sender
{
    NSInteger count = sender.tag - 800;
    
    //    UIView * view_bg = [self.view viewWithTag:count + 100];
    UIImageView * image = [self.view viewWithTag:count + 400];
    
    Zhaopingfeilei_Model * model = self.arr_data[count];
    
    if(image.hidden == 0)
    {
        image.hidden = 1;
        sender.layer.borderColor = [UIColor grayColor].CGColor;
        
        self.page = self.arr_data.count + 10;
        
//        //保存
//        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
//        [userdefault setObject:@"薪资区间" forKey:@"zhaopingxinzi_name"];
//        [userdefault setObject:@"0" forKey:@"zhaopingxinzi_id"];
    }
    else
    {
        image.hidden = 0;
        sender.layer.borderColor = navi_bar_bg_color.CGColor;
        
        self.page = count;
        
        //保存
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        [userdefault setObject:model.status_name forKey:@"zhaopingxinzi_name_1"];
        [userdefault setObject:model.status_code forKey:@"zhaopingxinzi_id_1"];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //刷新tableView(记住,要更新放在主线程中)
        
        [self.tableView reloadData];
    });
}

#pragma mark - 数据
- (void)p_data
{
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"Recruit:"];
    //
    [dataprovider RecruitSalary];
}

//数据
- (void)Recruit:(id )dict
{
//    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];
    
    self.arr_data = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"])
            {
                Zhaopingfeilei_Model * model = [[Zhaopingfeilei_Model alloc] init];
                
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
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] ];
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

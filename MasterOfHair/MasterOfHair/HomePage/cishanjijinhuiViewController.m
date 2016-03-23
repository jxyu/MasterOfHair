//
//  cishanjijinhuiViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/29.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "cishanjijinhuiViewController.h"

#import "cishanjijinhuiTableViewCell.h"
#import "ChongzhiViewController.h"
#import "ShenqingtixianViewController.h"
#import "Qianbao_Model.h"

@interface cishanjijinhuiViewController () <UITableViewDataSource, UITableViewDelegate>

//头
@property (nonatomic, strong) UIView * head_View;
@property (nonatomic, strong) UIImageView * image;
@property (nonatomic, strong) UILabel * name;
@property (nonatomic, strong) UILabel * money;
@property (nonatomic, strong) UIButton * btn_chong;
@property (nonatomic, strong) UIButton * btn_carsh;


//
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * arr_data;

@property (nonatomic, assign) NSInteger page;

@end

@implementation cishanjijinhuiViewController

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
    _lblTitle.text = [NSString stringWithFormat:@"慈善基金会"];
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.btn_chong.frame) + 37, SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.btn_chong.frame) - 37) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //注册
    [self.tableView registerClass:[cishanjijinhuiTableViewCell class] forCellReuseIdentifier:@"cell_cishanjijinhui"];
    
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
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cishanjijinhuiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_cishanjijinhui" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(self.arr_data.count != 0)
    {
        Qianbao_Model * model = self.arr_data[indexPath.row];
        
        NSString * str1 = [model.change_time substringToIndex:10];
        
        cell.date.text = str1;
        
        NSString * str = [NSString stringWithFormat:@"￥ %@",model.change_amount];
        
        if([model.change_type integerValue] == 1)
        {
            cell.price.text = [NSString stringWithFormat:@"+ %@",str];
            cell.price.textColor = [UIColor colorWithRed:100/255.0 green:220/255.0 blue:155/255.0 alpha:1];
        }
        else
        {
            cell.price.text = [NSString stringWithFormat:@"- %@",str];
            cell.price.textColor = [UIColor redColor];
        }
        
        
        switch ([model.treatment_status integerValue])
        {
            case 0:
            {
                cell.finish.text = @"处理中";
                cell.finish.textColor = [UIColor orangeColor];
            }
                break;
            case 1:
            {
                cell.finish.text = @"已完成";
                cell.finish.textColor = [UIColor blackColor];
                
            }
                break;
            default:
                break;
        }
        
        if([model.remark length] == 0)
        {
            cell.detail.text = @"";
        }
    }
    
    return cell;
}

#pragma mark - 头视图

- (void)p_headView
{
    self.head_View = [[UIView alloc] initWithFrame:CGRectMake(15, 64 + 5, SCREEN_WIDTH - 30, 100)];
    self.head_View.layer.cornerRadius = 5;
    self.head_View.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.head_View];
    
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 80, 80)];
//    self.image.backgroundColor = [UIColor orangeColor];
    self.image.layer.cornerRadius = 40;
    self.image.layer.masksToBounds = YES;
    [self.head_View addSubview:self.image];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.image.frame) + 10, CGRectGetMinY(self.image.frame) + 5, 40, 30)];
    label1.text = @"账号:";
    label1.font = [UIFont systemFontOfSize:15];
    [self.head_View addSubview:label1];
    
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 5, CGRectGetMinY(label1.frame), self.head_View.frame.size.width - CGRectGetMaxX(label1.frame) - 15, 30)];
    self.name.text = @"用户名";
    self.name.font = [UIFont systemFontOfSize:15];
//    self.name.backgroundColor = [UIColor orangeColor];
    [self.head_View addSubview:self.name];
    
    
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.image.frame) + 10, CGRectGetMaxY(label1.frame) + 7, 40, 30)];
    label2.text = @"余额:";
    label2.font = [UIFont systemFontOfSize:15];
    [self.head_View addSubview:label2];
    
    self.money = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame) + 5, CGRectGetMinY(label2.frame), self.head_View.frame.size.width - CGRectGetMaxX(label2.frame) - 15, 30)];
    self.money.text = @"¥ 2000.00";
    self.money.font = [UIFont systemFontOfSize:15];
    self.money.textColor = [UIColor orangeColor];
//    self.money.backgroundColor = [UIColor orangeColor];
    [self.head_View addSubview:self.money];
    
    CGFloat length_x = (SCREEN_WIDTH - 30 - 15) / 2;
    
    self.btn_chong = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_chong.frame = CGRectMake(15, CGRectGetMaxY(self.head_View.frame) + 5, length_x, 30);
    self.btn_chong.layer.cornerRadius = 5;
    self.btn_chong.backgroundColor = [UIColor colorWithRed:100/255.0 green:220/255.0 blue:155/255.0 alpha:1];
    [self.btn_chong setTitle:@"充值" forState:(UIControlStateNormal)];
    [self.btn_chong setTintColor:[UIColor whiteColor]];
    [self.view addSubview:self.btn_chong];
    
    [self.btn_chong addTarget:self action:@selector(btn_chongAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.btn_carsh = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_carsh.frame = CGRectMake(CGRectGetMaxX(self.btn_chong.frame) + 15, CGRectGetMaxY(self.head_View.frame) + 5, length_x, 30);
    self.btn_carsh.layer.cornerRadius = 5;
    self.btn_carsh.backgroundColor = navi_bar_bg_color;
    [self.btn_carsh setTitle:@"申请提现" forState:(UIControlStateNormal)];
    [self.btn_carsh setTintColor:[UIColor whiteColor]];
    [self.view addSubview:self.btn_carsh];
    
    [self.btn_carsh addTarget:self action:@selector(btn_carshAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIView * view_bg = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.btn_chong.frame) + 7, SCREEN_WIDTH, 30)];
    view_bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:view_bg];
    
    UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 15)];
    label3.text = @"资金变动详情";
//    label3.textColor = [UIColor grayColor];
    label3.font = [UIFont systemFontOfSize:12];
    [view_bg addSubview:label3];
}

#pragma mark - 充值 和 提现

//充值
- (void)btn_chongAction:(UIButton *)sender
{
//    NSLog(@"充值");
    ChongzhiViewController * ChongzhiView = [[ChongzhiViewController alloc] init];
    
    [self showViewController:ChongzhiView sender:nil];
}

//提现
- (void)btn_carshAction:(UIButton *)sender
{
//    NSLog(@"提现");
    ShenqingtixianViewController * Shenqingtixian = [[ShenqingtixianViewController alloc] init];
    
    [self showViewController:Shenqingtixian sender:nil];
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
    
    [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] record_type:@"2" pagenumber:@"1" pagesize:@"15"];
}

- (void)p_data1
{
    self.page ++ ;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"update:"];
    
    [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] record_type:@"2" pagenumber:[NSString stringWithFormat:@"%ld",(long)self.page] pagesize:@"15"];
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

#pragma mark - 懒加载

- (NSMutableArray *)arr_data
{
    if(_arr_data == nil)
    {
        self.arr_data = [NSMutableArray array];
    }
    
    return _arr_data;
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
    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSArray * arr_ = dict[@"data"][@"memberlist"];
            
            NSDictionary * dic = arr_.firstObject;
            
            [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/member/%@",Url_pic,dic[@"member_headpic"]]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
            
            
            if([[NSString stringWithFormat:@"%@",dic[@"member_nickname"]] length] == 0 || [[NSString stringWithFormat:@"%@",dic[@"member_nickname"]] isEqualToString:@"<null>"])
            {
                self.name.text = [NSString stringWithFormat:@"%@",dic[@"member_username"]];
            }
            else
            {
                self.name.text = [NSString stringWithFormat:@"%@",dic[@"member_nickname"]];
            }
            
            self.money.text = [NSString stringWithFormat:@"%@",dic[@"fund_balance"]];
            
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



@end

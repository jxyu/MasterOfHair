//
//  AdvertiseViewController.m
//  MasterOfHair
//
//  Created by 于金祥 on 16/1/31.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "AdvertiseViewController.h"
#import "AdvertiseCellTableViewCell.h"
#import "AdvertiseClassesViewController.h"

#import "ZhaopingdingweiViewController.h"
#import "Advertise_Model.h"
#import "ZhaopinfenleiViewController.h"
#import "ZhaopinxinziViewController.h"
#import "YingpinDetailViewController.h"
#import "ZhaopingDetailViewController.h"
#import "YingpinfabuViewController.h"
#import "ZhaopingfabuViewController.h"
@interface AdvertiseViewController ()<UITableViewDataSource,UITableViewDelegate>

//上面的btn
@property (nonatomic, strong) UIView * top_white;
@property (nonatomic, strong) UIButton * top_btnPeople;
@property (nonatomic, strong) UIButton * top_btnFactory;
@property (nonatomic, strong) UIView * top_viewPeople;
@property (nonatomic, strong) UIView * top_viewFactory;

@property (nonatomic, assign) BOOL isTeacher;


@property (nonatomic,strong) UITableView * mTableView;

//数据
@property (nonatomic, strong) NSMutableArray * arr_data;

@property (nonatomic, assign) NSInteger page;

//
@property (nonatomic, strong) FL_Button * btn_1;
@property (nonatomic, strong) FL_Button * btn_2;

@property (nonatomic, strong) FL_Button *btn_top_location_select;


@end

@implementation AdvertiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitTopView];
    
    [self BuildSegmentView];
    
    [self BuildHeaderView];
    
    [self InitTableview];
}

-(void)InitTopView
{
    _btnRight.hidden = YES;
    _lblRight.hidden = YES;
    
    [self addLeftButton:@"iconfont-fanhui"];
    self.btn_top_location_select = [FL_Button fl_shareButton];
    [self.btn_top_location_select setImage:[UIImage imageNamed:@"select_baise"] forState:UIControlStateNormal];
    [self.btn_top_location_select setTitle:@"定位" forState:UIControlStateNormal];
    [self.btn_top_location_select setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btn_top_location_select.status = FLAlignmentStatusCenter;
    self.btn_top_location_select.titleLabel.font = [UIFont systemFontOfSize:18];
    [_topView addSubview:self.btn_top_location_select];
    
    [self.btn_top_location_select zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.edgeInsets(UIEdgeInsetsMake(20, 80, 0, 80));
    }];
    
    [self.btn_top_location_select addTarget:self action:@selector(JumpToSecectCityVC) forControlEvents:UIControlEventTouchUpInside];
    
}

/**
 *   跳转到选择城市页面
 */
-(void)JumpToSecectCityVC
{
//    NSLog(@"跳转");
    ZhaopingdingweiViewController * zhaopingdingweiViewController = [[ZhaopingdingweiViewController alloc] init];
    
    [self showViewController:zhaopingdingweiViewController sender:nil];
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    //
    [userdefault setObject:@"" forKey:@"zhaopingxinzi_name_1"];
    [userdefault setObject:@"" forKey:@"zhaopingxinzi_id_1"];
    
    [userdefault setObject:@"" forKey:@"zhaopingfei_name_2"];
    [userdefault setObject:@"" forKey:@"zhaopingfei_id_2"];
    
    [userdefault setObject:@"" forKey:@"diquweizhi_id3_"];
    [userdefault setObject:@"" forKey:@"diquweizhi3_"];
    //
    
    
    if([[userdefault objectForKey:@"zhaopingfei_name"] length] == 0)
    {
        [self.btn_1 setTitle:@"全部分类" forState:UIControlStateNormal];
        
        [userdefault setObject:@"0" forKey:@"zhaopingfei_id"];
    }
    else
    {
        [self.btn_1 setTitle:[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"zhaopingfei_name"]] forState:UIControlStateNormal];
    }
    
    if([[userdefault objectForKey:@"zhaopingxinzi_name"] length] == 0)
    {
        [self.btn_2 setTitle:@"薪资区间" forState:UIControlStateNormal];
        [userdefault setObject:@"0" forKey:@"zhaopingxinzi_id"];

    }
    else
    {
        [self.btn_2 setTitle:[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"zhaopingxinzi_name"]] forState:UIControlStateNormal];
    }
    
    if([[userdefault objectForKey:@"city_id"] length] == 0)
    {
        [self.btn_top_location_select setTitle:@"定位" forState:UIControlStateNormal];
        
        if([[userdefault objectForKey:@"diquweizhi2"] length] == 0)
        {
            [self.btn_top_location_select setTitle:@"定位" forState:UIControlStateNormal];
            
            [userdefault setObject:@"183" forKey:@"diquweizhi_id2"];
        }
        else
        {
            [self.btn_top_location_select setTitle:[userdefault objectForKey:@"diquweizhi2"] forState:UIControlStateNormal];
        }
    }
    else
    {
        [self.btn_top_location_select setTitle:[userdefault objectForKey:@"city_name"] forState:UIControlStateNormal];

        
        if([[userdefault objectForKey:@"diquweizhi2"] length] == 0)
        {
            [self.btn_top_location_select setTitle:[userdefault objectForKey:@"city_name"] forState:UIControlStateNormal];
            
            [userdefault setObject:[userdefault objectForKey:@"city_id"] forKey:@"diquweizhi_id2"];
        }
        else
        {
            [self.btn_top_location_select setTitle:[userdefault objectForKey:@"diquweizhi2"] forState:UIControlStateNormal];
        }
    }

    [self example01];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)jumpToSelectClass
{
    ZhaopinfenleiViewController * zhaopinfenleiViewController = [[ZhaopinfenleiViewController alloc] init];
    
    [self showViewController:zhaopinfenleiViewController sender:nil];
}

- (void)btn_betweenToSelectClass
{
    ZhaopinxinziViewController * zhaopinxinziViewController = [[ZhaopinxinziViewController alloc] init];
    
    [self showViewController:zhaopinxinziViewController sender:nil];
}

#pragma mark - 布局
-(void)BuildSegmentView
{
    self.top_white = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50)];
    self.top_white.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.top_white];
    
    int length_x = SCREEN_WIDTH / 2;
    
    //应聘
    self.top_btnFactory = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.top_btnFactory.frame = CGRectMake(0, 0, length_x, 50);
    [self.top_btnFactory setTitle:@"应聘" forState:(UIControlStateNormal)];
    [self.top_btnFactory setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    self.top_btnFactory.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.top_white addSubview:self.top_btnFactory];
    
    [self.top_btnFactory addTarget:self action:@selector(top_btnFactoryAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.top_viewFactory = [[UIView alloc] initWithFrame:CGRectMake(length_x / 2 - 40, 48, 80, 2)];
    self.top_viewFactory.backgroundColor = navi_bar_bg_color;
    [self.top_white addSubview:self.top_viewFactory];
    
    
    //招聘
    self.top_btnPeople = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.top_btnPeople.frame = CGRectMake(length_x, 0, length_x, 50);
    [self.top_btnPeople setTitle:@"招聘" forState:(UIControlStateNormal)];
    [self.top_btnPeople setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.top_btnPeople.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.top_white addSubview:self.top_btnPeople];
    
    [self.top_btnPeople addTarget:self action:@selector(top_btnPeopleAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.top_viewPeople = [[UIView alloc] initWithFrame:CGRectMake(length_x+length_x / 2 - 40, 48, 80, 2)];
    self.top_viewPeople.backgroundColor = navi_bar_bg_color;
    [self.top_white addSubview:self.top_viewPeople];
    self.top_viewPeople.hidden = YES;
}

-(void)BuildHeaderView
{
    UIView * HeaderBackView=[[UIView alloc] init];
    HeaderBackView.backgroundColor=BACKGROUND_COLOR;
    [self.view addSubview:HeaderBackView];
    
    
    FL_Button *btn_AllClass = [FL_Button fl_shareButton];
    [btn_AllClass setImage:[UIImage imageNamed:@"select_down"] forState:UIControlStateNormal];
    [btn_AllClass setTitle:@"全部分类" forState:UIControlStateNormal];
    [btn_AllClass setTitleColor:navi_bar_bg_color forState:UIControlStateNormal];
    btn_AllClass.status = FLAlignmentStatusCenter;
    btn_AllClass.titleLabel.font = [UIFont systemFontOfSize:14];
    btn_AllClass.layer.masksToBounds=YES;
    btn_AllClass.layer.borderWidth=0.5;
    btn_AllClass.layer.borderColor=navi_bar_bg_color.CGColor;
    btn_AllClass.layer.cornerRadius=8;
    [btn_AllClass addTarget:self action:@selector(jumpToSelectClass) forControlEvents:UIControlEventTouchUpInside];
    [HeaderBackView addSubview:btn_AllClass];
    self.btn_1 = btn_AllClass;
    
    FL_Button *btn_between = [FL_Button fl_shareButton];
    [btn_between setImage:[UIImage imageNamed:@"select_down"] forState:UIControlStateNormal];
    [btn_between setTitle:@"薪资区间" forState:UIControlStateNormal];
    [btn_between setTitleColor:navi_bar_bg_color forState:UIControlStateNormal];
    btn_between.status = FLAlignmentStatusCenter;
    btn_between.titleLabel.font = [UIFont systemFontOfSize:14];
    btn_between.layer.masksToBounds=YES;
    btn_between.layer.borderWidth=0.5;
    btn_between.layer.borderColor=navi_bar_bg_color.CGColor;
    btn_between.layer.cornerRadius=8;
    [btn_between addTarget:self action:@selector(btn_betweenToSelectClass) forControlEvents:UIControlEventTouchUpInside];
    self.btn_2 = btn_between;
    [HeaderBackView addSubview:btn_between];
    
    FL_Button *btn_new  = [FL_Button fl_shareButton];
    btn_new.backgroundColor=navi_bar_bg_color;
    [btn_new setImage:[UIImage imageNamed:@"01_33_small"] forState:UIControlStateNormal];
    [btn_new setTitle:@"发布" forState:UIControlStateNormal];
    [btn_new setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn_new.status = FLAlignmentStatusNormal;
    btn_new.titleLabel.font = [UIFont systemFontOfSize:14];
    btn_new.layer.masksToBounds=YES;
    btn_new.layer.cornerRadius=8;
    [HeaderBackView addSubview:btn_new];
    
    [btn_new addTarget:self action:@selector(btn_newAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    [HeaderBackView zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpace(0);
        layout.topSpaceByView(self.top_white,0);
        layout.rightSpace(0);
        layout.heightValue(54);
    }];
    
    [btn_AllClass zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpace(10);
        layout.topSpace(10);
        layout.bottomSpace(10);
        layout.widthValue(85);
    }];
    //薪资区间的位置
    [btn_between zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(btn_AllClass,10);
        layout.topSpace(10);
        layout.bottomSpace(10);
        layout.widthValue(85);
    }];
    
    [btn_new zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.topSpace(10);
        layout.rightSpace(10);
        layout.bottomSpace(10);
        layout.widthValue(85);
    }];
    
    
}

-(void)InitTableview{
    self.mTableView=[[UITableView alloc] init];
    
    self.mTableView.backgroundColor=BACKGROUND_COLOR;
    
    self.mTableView.delegate=self;
    
    self.mTableView.dataSource=self;
    
    [self.view addSubview:self.mTableView];
    
    self.mTableView.tableFooterView = [[UIView alloc] init];
    
    [self.mTableView zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.topSpace(168);
        layout.leftSpace(0);
        layout.rightSpace(0);
        layout.bottomSpace(0);
    }];
    
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.mTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    
        [weakSelf.mTableView reloadData];
        [weakSelf loadNewData];
    }];
    
    self.mTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if(self.isTeacher == 1)
        {
            [self p_data1];
        }
        else
        {
            [self p_data4];
        }
        
        [weakSelf.mTableView reloadData];
        [weakSelf loadNewData];
    }];

}


#pragma mark - 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr_data.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"zhaoPinCellid";
    
    AdvertiseCellTableViewCell *cell = (AdvertiseCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell  = [[[NSBundle mainBundle] loadNibNamed:@"AdvertiseCellTableViewCell" owner:self options:nil] lastObject];
    cell.imageView.layer.masksToBounds = YES;
//    cell.layer.masksToBounds = YES;
    
    
    if(self.arr_data.count != 0)
    {
        Advertise_Model * model = self.arr_data[indexPath.row];
        
        if(self.isTeacher == 1)
        {
            NSString * str = [NSString stringWithFormat:@"%@uploads/recruit/%@",Url_pic,model.image];
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str]placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
            
            cell.lbl_Title.text = model.company_name;
            cell.lbl_Detial.text = model.job_description;
            cell.lbl_betweenPrice.text = model.status_name;
        }
        else
        {
            NSString * str = [NSString stringWithFormat:@"%@uploads/vitae/%@",Url_pic,model.image];
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str]placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
            
            cell.lbl_Title.text = model.name;
            cell.lbl_Detial.text = model.intention_position;
            cell.lbl_betweenPrice.text = model.status_name;
        }
    }
    else
    {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"placeholder_short"]];
        
        cell.lbl_Title.text=@"招收发型师";
        
        cell.lbl_Detial.text=@"擅长各种发型设计以及各种理发技术";
        
        cell.lbl_betweenPrice.text = @"8K~10K/月";
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(self.isTeacher == 0)
    {//应聘
        Advertise_Model * model = self.arr_data[indexPath.row];
        
        YingpinDetailViewController * yingpinDetailViewController = [[YingpinDetailViewController alloc] init];
        
        yingpinDetailViewController.vitae_id = model.vitae_id;
        
        [self showViewController:yingpinDetailViewController sender:nil];
    }
    else
    {//招聘
        Advertise_Model * model = self.arr_data[indexPath.row];

        ZhaopingDetailViewController * zhaopingDetailViewController = [[ZhaopingDetailViewController alloc] init];
        
        zhaopingDetailViewController.recruit_id = model.recruit_id;
        
        [self showViewController:zhaopingDetailViewController sender:nil];
    }
    
}

#pragma mark - 点击方法；
/**
 *  应聘
 *
 *  @param sender <#sender description#>
 */
- (void)top_btnFactoryAction:(UIButton *)sender
{
    self.isTeacher = NO;
    
    //变颜色
    [self.top_btnFactory setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    self.top_viewFactory.hidden = NO;
    
    [self.top_btnPeople setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.top_viewPeople.hidden = YES;
    // 马上进入刷新状态
//    [self.mTableView.mj_header beginRefreshing];
    [self example01];
}
/**
 *  招聘
 *
 *  @param sender <#sender description#>
 */
- (void)top_btnPeopleAction:(UIButton *)sender
{
    self.isTeacher = YES;
    
    //变颜色
    [self.top_btnFactory setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.top_viewFactory.hidden = YES;
    
    [self.top_btnPeople setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    self.top_viewPeople.hidden = NO;
    
    // 马上进入刷新状态
    [self example01];
}

- (void )btn_newAction:(UIButton *)sender
{
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    if([[userdefault objectForKey:@"member_id"] length] == 0)
    {
        LoginViewController * loginViewController = [[LoginViewController alloc] init];
        
        [self showViewController:loginViewController sender:nil];
    }
    else
    {
        if(self.isTeacher == 0)
        {
            YingpinfabuViewController * yingpinfabuViewController = [[YingpinfabuViewController alloc] init];
            
            [self showViewController:yingpinfabuViewController sender:nil];
        }
        else
        {
            if([[userdefault objectForKey:@"member_type"] isEqualToString:@"1"])
            {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您没有此权限发布招聘" preferredStyle:(UIAlertControllerStyleAlert)];
                
                [self presentViewController:alert animated:YES completion:^{
                    
                }];
                
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alert addAction:action];
            }
            else
            {
                ZhaopingfabuViewController * zhaopingfabuViewController = [[ZhaopingfabuViewController alloc] init];
                
                [self showViewController:zhaopingfabuViewController sender:nil];
            }
        }
    }
}


#pragma mark - 数据_1
- (void)p_data
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];

    self.page = 1;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"Recruit:"];
    //
    [dataprovider talkWithArea_id:[userdefault objectForKey:@"diquweizhi_id2"] salary_id:[userdefault objectForKey:@"zhaopingxinzi_id"] type_id:[userdefault objectForKey:@"zhaopingfei_id"] pagenumber:@"1" pagesize:@"15"];
}


- (void)p_data1
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];

    self.page ++ ;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"Recruit:"];
    //
    [dataprovider talkWithArea_id:[userdefault objectForKey:@"diquweizhi_id2"] salary_id:[userdefault objectForKey:@"zhaopingxinzi_id"] type_id:[userdefault objectForKey:@"zhaopingfei_id"] pagenumber:[NSString stringWithFormat:@"%ld",self.page] pagesize:@"15"];
}

#pragma mark - 数据_2
- (void)p_data3
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];


//    NSLog(@"%@",[userdefault objectForKey:@"zhaopingfei_id"]);
//    NSLog(@"%@",[userdefault objectForKey:@"zhaopingxinzi_id"]);

    self.page = 1;
    NSLog(@"%@",[userdefault objectForKey:@"diquweizhi_id2"]);
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"Recruit:"];
    //
    [dataprovider VitaeWithArea_id:[userdefault objectForKey:@"diquweizhi_id2"] salary_id:[userdefault objectForKey:@"zhaopingxinzi_id"] type_id:[userdefault objectForKey:@"zhaopingfei_id"] pagenumber:@"1" pagesize:@"15"];
    
}


- (void)p_data4
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];

    self.page ++ ;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"Recruit:"];
    //
    [dataprovider VitaeWithArea_id:[userdefault objectForKey:@"diquweizhi_id2"] salary_id:[userdefault objectForKey:@"zhaopingxinzi_id"] type_id:[userdefault objectForKey:@"zhaopingfei_id"] pagenumber:[NSString stringWithFormat:@"%ld",self.page] pagesize:@"15"];
}

//数据
- (void)Recruit:(id )dict
{
//    NSLog(@"%@",dict);
    
    if(self.page == 1)
    {
        self.arr_data = nil;
    }
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            if(self.isTeacher == 1)
            {
                for (NSDictionary * dic in dict[@"data"][@"recruitlist"])
                {
                    Advertise_Model * model = [[Advertise_Model alloc] init];
                    
                    [model setValuesForKeysWithDictionary:dic];
                    
                    [self.arr_data addObject:model];
                }
            }
            else
            {
                for (NSDictionary * dic in dict[@"data"][@"vitaelist"])
                {
                    Advertise_Model * model = [[Advertise_Model alloc] init];
                    
                    [model setValuesForKeysWithDictionary:dic];
                    
                    [self.arr_data addObject:model];
                }
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新tableView(记住,要更新放在主线程中)
                
                [self.mTableView reloadData];
            });
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
    if(self.isTeacher == 1)
    {
        [self p_data];
    }
    else
    {
        [self p_data3];
    }
    
    // 马上进入刷新状态
    [self.mTableView.header beginRefreshing];
}

-(void)example02
{
    [self.mTableView.footer beginRefreshing];
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mTableView.header endRefreshing];
        [self.mTableView.footer endRefreshing];
    });
    
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

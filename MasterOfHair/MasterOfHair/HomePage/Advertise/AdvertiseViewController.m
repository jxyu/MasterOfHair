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

@interface AdvertiseViewController ()<UITableViewDataSource,UITableViewDelegate>

//上面的btn
@property (nonatomic, strong) UIView * top_white;
@property (nonatomic, strong) UIButton * top_btnPeople;
@property (nonatomic, strong) UIButton * top_btnFactory;
@property (nonatomic, strong) UIView * top_viewPeople;
@property (nonatomic, strong) UIView * top_viewFactory;

@property (nonatomic, assign) BOOL isTeacher;


@property (nonatomic,strong) UITableView * mTableView;

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
    [self addLeftButton:@"iconfont-fanhui"];
    FL_Button *btn_top_location_select = [FL_Button fl_shareButton];
    [btn_top_location_select setImage:[UIImage imageNamed:@"select_baise"] forState:UIControlStateNormal];
    [btn_top_location_select setTitle:@"全部分类" forState:UIControlStateNormal];
    [btn_top_location_select setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn_top_location_select.status = FLAlignmentStatusCenter;
    btn_top_location_select.titleLabel.font = [UIFont systemFontOfSize:14];
    [_topView addSubview:btn_top_location_select];
    
    [btn_top_location_select zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.edgeInsets(UIEdgeInsetsMake(20, 80, 0, 80));
    }];
    
    [btn_top_location_select addTarget:self action:@selector(JumpToSecectCityVC) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

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
//    [btn_AllClass addTarget:self action:@selector(jumpToSelectClass) forControlEvents:UIControlEventTouchUpInside];
    [HeaderBackView addSubview:btn_AllClass];
    
    
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
    
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // 马上进入刷新状态
    [self.mTableView.mj_header beginRefreshing];
    
    
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    
    // 设置footer
    self.mTableView.mj_footer = footer;
}


-(void)loadNewData
{
    [self.mTableView.mj_header endRefreshing];
}
-(void)loadMoreData
{
    [self.mTableView.mj_footer endRefreshing];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
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
    
    cell.layer.masksToBounds=YES;
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"placeholder_short"]];
    
    cell.lbl_Title.text=@"招收发型师";
    
    cell.lbl_Detial.text=@"擅长各种发型设计以及各种理发技术";
    
    cell.lbl_betweenPrice.text=@"8K~10K/月";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

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
    [self.mTableView.mj_header beginRefreshing];
    
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
    [self.mTableView.mj_header beginRefreshing];
}

/**
 *   跳转到选择城市页面
 */
-(void)JumpToSecectCityVC
{
    NSLog(@"跳转");
}
-(void)jumpToSelectClass
{
    AdvertiseClassesViewController * adveClass=[[AdvertiseClassesViewController alloc] init];
    
    [self.navigationController pushViewController:adveClass animated:YES];
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  WebStroeViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/19.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "WebStroeViewController.h"

#import "WebStroeCollectionViewCell.h"
#import "AppDelegate.h"
#import "LocationViewController.h"
#import "SearchViewController.h"

#import "chanpingxiangqingViewController.h"
#import "FenleiViewController.h"
@interface WebStroeViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//tableView
@property (nonatomic, strong) UITableView * tableView;

//collectionView
@property (nonatomic, strong) UICollectionView * stroe_collectionView;

//头视图
@property (nonatomic, strong) UIView * head_view;
//轮播图
@property (nonatomic, strong) UIScrollView * lunbo_scrollView;
@property (nonatomic, strong) UIPageControl * lunbo_pageControl;
@property (nonatomic, strong) NSTimer * lunbo_timer;
@property (nonatomic, assign) BOOL isplay;
//搜索......
@property (nonatomic, strong) UIView * headview_Delegate;
@property (nonatomic, strong) FL_Button * delegate_address;
@property (nonatomic, strong) FL_Button * delegate_class;
@property (nonatomic, strong) UIButton * delegate_search;

//测试
@property (nonatomic, assign) NSInteger page;

@end

@implementation WebStroeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    _lblTitle.text = @"商城";
    _lblTitle.font = [UIFont systemFontOfSize:19];
}

//显示tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [self example01];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showTabBar];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) style:(UITableViewStylePlain)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    
    //头视图
    [self p_headView];
    self.tableView.tableHeaderView = self.head_view;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_WebStroe"];
    
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.page = 1;
        
        [weakSelf.tableView reloadData];
        [weakSelf loadNewData];
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.page ++;
        
        [weakSelf.tableView reloadData];
        [weakSelf loadNewData];
    }];
}

#pragma mark - tableView代理
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.page;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat length_h = 0;
    
    if(SCREEN_WIDTH < 360)
    {
        length_h = ((SCREEN_WIDTH ) / 4 + 100) * 2.15;
    }
    else
    {
        length_h = ((SCREEN_WIDTH ) / 4 + 100) * 2.25;
    }
    return length_h;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat length_h = 0;
    
    if(SCREEN_WIDTH < 360)
    {
        length_h = ((SCREEN_WIDTH ) / 4 + 100) * 2.15;
    }
    else
    {
        length_h = ((SCREEN_WIDTH ) / 4 + 100) * 2.25;
    }
    
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, length_h);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //每个item的大小
    int  item_length = (SCREEN_WIDTH ) / 4;
    layout.itemSize = CGSizeMake(item_length + 11, item_length + 40);
    layout.sectionInset = UIEdgeInsetsMake(5, 10, 0, 10);
    
    self.stroe_collectionView = [[UICollectionView alloc] initWithFrame:cell.frame collectionViewLayout:layout];
    self.stroe_collectionView.delegate = self;
    self.stroe_collectionView.dataSource = self;
    self.stroe_collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.stroe_collectionView.tag = indexPath.row;
    
    [self.stroe_collectionView registerClass:[WebStroeCollectionViewCell class] forCellWithReuseIdentifier:@"cell_webStroe"];
    
    [cell addSubview:self.stroe_collectionView];
    
    return cell;
}

#pragma mark - collection代理
//代理
- (NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WebStroeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_webStroe" forIndexPath:indexPath];
    
    [cell.image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"第几行tableView   %ld",collectionView.tag + 1);
    NSLog(@"%ld",(long)indexPath.item);
    
    chanpingxiangqingViewController * chanpingxiangqing = [[chanpingxiangqingViewController alloc] init];
    
    [self showViewController:chanpingxiangqing sender:nil];
}

#pragma mark - 头视图
- (void)p_headView
{
    self.head_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
    self.head_view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self p_lunbotu];
    
    [self.head_view addSubview:self.lunbo_scrollView];
    [self.head_view addSubview:self.lunbo_pageControl];
    
    //搜索。。。。。。。
    [self p_setupView2];
}

#pragma mark - 3个点击布局
- (void)p_setupView2
{
    self.headview_Delegate = [[UIView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 60)];
    self.headview_Delegate.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.head_view addSubview:self.headview_Delegate];
    
    
    
    self.delegate_address = [FL_Button fl_shareButton];
    self.delegate_address.frame = CGRectMake(10, 12.5, 70, 35);
    [self.delegate_address setImage:[UIImage imageNamed:@"select_down"] forState:UIControlStateNormal];
    [self.delegate_address setTitle:@"全国" forState:UIControlStateNormal];
    [self.delegate_address setTitleColor:navi_bar_bg_color forState:UIControlStateNormal];
    self.delegate_address.status = FLAlignmentStatusCenter;
    self.delegate_address.titleLabel.font = [UIFont systemFontOfSize:14];
    self.delegate_address.layer.masksToBounds=YES;
    self.delegate_address.layer.borderWidth= 1;
    self.delegate_address.layer.borderColor=navi_bar_bg_color.CGColor;
    self.delegate_address.layer.cornerRadius=8;
    [self.headview_Delegate addSubview:self.delegate_address];
    [self.delegate_address addTarget:self action:@selector(delegate_addressAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.delegate_class = [FL_Button fl_shareButton];
    self.delegate_class.frame = CGRectMake(CGRectGetMaxX(self.delegate_address.frame) + 10, 12.5, 70, 35);
    [self.delegate_class setImage:[UIImage imageNamed:@"select_down"] forState:UIControlStateNormal];
    [self.delegate_class setTitle:@"分类" forState:UIControlStateNormal];
    [self.delegate_class setTitleColor:navi_bar_bg_color forState:UIControlStateNormal];
    self.delegate_class.status = FLAlignmentStatusCenter;
    self.delegate_class.titleLabel.font = [UIFont systemFontOfSize:14];
    self.delegate_class.layer.masksToBounds=YES;
    self.delegate_class.layer.borderWidth= 1;
    self.delegate_class.layer.borderColor=navi_bar_bg_color.CGColor;
    self.delegate_class.layer.cornerRadius=8;
    [self.headview_Delegate addSubview:self.delegate_class];
    [self.delegate_class addTarget:self action:@selector(delegate_classAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.delegate_search = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.delegate_search.frame = CGRectMake(CGRectGetMaxX(self.delegate_class.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(self.delegate_class.frame) - 20, 40);
    self.delegate_search.layer.cornerRadius = SCREEN_WIDTH * 0.055;
    self.delegate_search.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.delegate_search.layer.borderWidth = 1;
    self.delegate_search.backgroundColor = [UIColor whiteColor];
    [self.headview_Delegate addSubview:self.delegate_search];
    [self.delegate_search addTarget:self action:@selector(delegate_searchAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7.5, 25, 25)];
    image.image = [UIImage imageNamed:@"iconfont-sousuo"];
    [self.delegate_search addSubview:image];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame) + 5, 7.5, 90, 25)];
    label.text = @"请输入关键字";
    //    label.backgroundColor = [UIColor orangeColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor grayColor];
    [self.delegate_search addSubview:label];

}

//地址范围
- (void)delegate_addressAction:(UIButton *)sender
{
//    NSLog(@"地址范围");
    LocationViewController * locationViewController = [[LocationViewController alloc] init];
    
    [self showViewController:locationViewController sender:nil];
    
}
//分类
- (void)delegate_classAction:(UIButton *)sender
{
//    NSLog(@"分类");
    FenleiViewController * fenleiViewController = [[FenleiViewController alloc] init];
    
    [self showViewController:fenleiViewController sender:nil];
}
//查找关键字
- (void)delegate_searchAction:(UIButton *)sender
{
    NSLog(@"查找关键字");
    SearchViewController * searchViewController = [[SearchViewController alloc] init];
    [self showViewController:searchViewController sender:nil];
}


#pragma mark - 轮播图
- (void)p_lunbotu
{
    self.lunbo_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    //        self.lunbo_scrollView.backgroundColor = [UIColor orangeColor];
    self.lunbo_scrollView.pagingEnabled = YES;
    self.lunbo_scrollView.showsHorizontalScrollIndicator = NO;
    self.lunbo_scrollView.delegate = self;
    
    self.lunbo_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 5, 0);
    
    //3张图
    UIImageView * view1 = [[UIImageView alloc] init];
    view1.frame = CGRectMake(SCREEN_WIDTH * 0 , 0 , SCREEN_WIDTH, 200);
    [view1 sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
    [self.lunbo_scrollView addSubview:view1];
    
    UIImageView * view2 = [[UIImageView alloc] init];
    view2.frame = CGRectMake(SCREEN_WIDTH * 1 , 0 , SCREEN_WIDTH, 200);
    [view2 sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
    [self.lunbo_scrollView addSubview:view2];
    
    UIImageView * view3 = [[UIImageView alloc] init];
    view3.frame = CGRectMake(SCREEN_WIDTH * 2 , 0 , SCREEN_WIDTH, 200);
    [view3 sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
    [self.lunbo_scrollView addSubview:view3];
    
    UIImageView * view4 = [[UIImageView alloc] init];
    view4.frame = CGRectMake(SCREEN_WIDTH * 3 , 0 , SCREEN_WIDTH, 200);
    [view4 sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
    [self.lunbo_scrollView addSubview:view4];
    
    UIImageView * view5 = [[UIImageView alloc] init];
    view5.frame = CGRectMake(SCREEN_WIDTH * 4 , 0 , SCREEN_WIDTH, 200);
    [view5 sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
    [self.lunbo_scrollView addSubview:view5];
    
    //
    self.lunbo_pageControl = [[UIPageControl alloc] init];
    self.lunbo_pageControl.frame = CGRectMake(self.view.frame.size.width / 2 - 50, 180, 100, 18);
    self.lunbo_pageControl.numberOfPages = 3;
    self.lunbo_pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:132/255.0 green:193/255.0 blue:254/255.0 alpha:1];
    self.lunbo_pageControl.pageIndicatorTintColor = [UIColor colorWithRed:202/255.0 green:218/255.0 blue:233/255.0 alpha:1];
    
    if(self.isplay == 0)
    {
        self.lunbo_scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        //轮播秒数
        self.lunbo_timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        self.lunbo_pageControl.currentPage = 0;
        
        self.isplay = 1;
    }
    else
    {
        self.lunbo_scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * (self.lunbo_pageControl.currentPage + 1), 0);
    }
    //手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.lunbo_scrollView addGestureRecognizer:tapGesture];
}

#pragma mark - 轮播图的点击事件
-(void)tapGesture:(id)sender
{
    NSLog(@"%ld",(long)self.lunbo_pageControl.currentPage);
    
    switch (self.lunbo_pageControl.currentPage){
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        default:
            break;
    }
}

#pragma mark - 定时器的方法!
- (void)timerAction
{
    CGFloat x = self.lunbo_scrollView.contentOffset.x;
    int count = x / SCREEN_WIDTH;
    
    if(count < 3)
    {
        count ++;
        [UIView animateWithDuration:0.7f animations:^{
            
            self.lunbo_scrollView.contentOffset = CGPointMake(count * SCREEN_WIDTH, 0);
            self.lunbo_pageControl.currentPage = count - 1;
            
        }];
    }
    else if(count == 3)
    {
        count ++;
        
        [UIView animateWithDuration:0.7f animations:^{
            
            self.lunbo_scrollView.contentOffset = CGPointMake(count * SCREEN_WIDTH, 0);
            self.lunbo_pageControl.currentPage = 0;
            
        }];
    }
    else
    {
        count = 2;
        self.lunbo_scrollView.contentOffset = CGPointMake(1 * SCREEN_WIDTH, 0);
        [UIView animateWithDuration:0.7f animations:^{
            
            self.lunbo_scrollView.contentOffset = CGPointMake(count * SCREEN_WIDTH, 0);
            self.lunbo_pageControl.currentPage = count - 1;
        }];
    }
}
#pragma mark - scrollView的代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat x = self.lunbo_scrollView.contentOffset.x;
    
    int count = x / SCREEN_WIDTH;
    
    if(count == 4)
    {
        self.lunbo_scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        self.lunbo_pageControl.currentPage = 0;
    }
    else if(count == 0)
    {
        self.lunbo_scrollView.contentOffset = CGPointMake(3 * SCREEN_WIDTH, 0);
        self.lunbo_pageControl.currentPage = 2;
    }
    else
    {
        self.lunbo_pageControl.currentPage = count - 1;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if([self.lunbo_scrollView isEqual:scrollView])
    {
        [self.lunbo_timer invalidate];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([scrollView isEqual:self.lunbo_scrollView]) {
        
        self.lunbo_timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        
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












@end

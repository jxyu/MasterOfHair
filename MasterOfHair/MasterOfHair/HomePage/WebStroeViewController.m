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
#import "FactroySearchViewController.h"

@interface WebStroeViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//上面的两个btn
@property (nonatomic, strong) UIView * top_white;
@property (nonatomic, strong) UIButton * top_btnDelegate;
@property (nonatomic, strong) UIButton * top_btnFactory;
@property (nonatomic, strong) UIView * top_viewDelegate;
@property (nonatomic, strong) UIView * top_viewFactory;


//
@property (nonatomic, strong) UITableView * tableView;
//是哪个按钮
@property (nonatomic, assign) BOOL isFactory;
//几组
@property (nonatomic, assign) NSInteger number_delegate;
@property (nonatomic, assign) NSInteger number_factory;

//代理商
@property (nonatomic, strong) UIView * headview_Delegate;

@property (nonatomic, strong) UIButton * delegate_address;
@property (nonatomic, strong) UIButton * delegate_class;
@property (nonatomic, strong) UIButton * delegate_search;

//厂家
@property (nonatomic, strong) UIView * headview_Factory;

@property (nonatomic, strong) UIButton * factory_class;
@property (nonatomic, strong) UIButton * factory_search;

//
@property (nonatomic, strong) UICollectionView * stroe_collectionView;

@end

@implementation WebStroeViewController

#warning 可能后期加数据的时候要改
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
    _lblTitle.text = @"商城";
    _lblTitle.font = [UIFont systemFontOfSize:19];
}

//显示tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [self example01];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showTabBar];
}


#pragma mark - 总布局
- (void)p_setupView
{
    
    self.number_delegate = 1;
    self.number_factory = 1;
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.isFactory = NO;
    
    [self p_topView];
    
    [self p_tableView];
    
    [self example01];
    [self example02];

}

#pragma mark - topView
- (void)p_topView
{
    self.top_white = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50)];
    self.top_white.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.top_white];
    
    int length_x = SCREEN_WIDTH / 2;
    
    //代理商
    self.top_btnDelegate = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.top_btnDelegate.frame = CGRectMake(0, 0, length_x, 50);
    [self.top_btnDelegate setTitle:@"代理商" forState:(UIControlStateNormal)];
    [self.top_btnDelegate setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    self.top_btnDelegate.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.top_white addSubview:self.top_btnDelegate];
    
    [self.top_btnDelegate addTarget:self action:@selector(top_btnDelegateAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.top_viewDelegate = [[UIView alloc] initWithFrame:CGRectMake(length_x / 2 - 40, 48, 80, 2)];
    self.top_viewDelegate.backgroundColor = navi_bar_bg_color;
    [self.top_btnDelegate addSubview:self.top_viewDelegate];
    
    
    //厂家
    self.top_btnFactory = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.top_btnFactory.frame = CGRectMake(length_x, 0, length_x, 50);
    [self.top_btnFactory setTitle:@"厂家" forState:(UIControlStateNormal)];
    [self.top_btnFactory setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.top_btnFactory.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.top_white addSubview:self.top_btnFactory];
    
    [self.top_btnFactory addTarget:self action:@selector(top_btnFactoryAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.top_viewFactory = [[UIView alloc] initWithFrame:CGRectMake(length_x / 2 - 40, 48, 80, 2)];
    self.top_viewFactory.backgroundColor = navi_bar_bg_color;
    [self.top_btnFactory addSubview:self.top_viewFactory];
    self.top_viewFactory.hidden = YES;
}

#pragma mark - 代理商 和 厂家的btn

//代理商的btn
- (void)top_btnDelegateAction:(UIButton *)sender
{
    //变颜色
    [self.top_btnDelegate setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    self.top_viewDelegate.hidden = NO;
    
    [self.top_btnFactory setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.top_viewFactory.hidden = YES;
    
    self.isFactory = NO;
    [self example01];
    //变头视图
    [self p_head_delegate];
    self.tableView.tableHeaderView = self.headview_Delegate;
    
    [self.tableView reloadData];
}

//厂家的btn
- (void)top_btnFactoryAction:(UIButton *)sender
{
    //变颜色
    [self.top_btnDelegate setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.top_viewDelegate.hidden = YES;
    
    [self.top_btnFactory setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    self.top_viewFactory.hidden = NO;
    
    self.isFactory = YES;
    [self example01];
    //变头视图
    [self p_head_factory];
    self.tableView.tableHeaderView = self.headview_Factory;

    [self.tableView reloadData];
}

#pragma mark - tableView
- (void)p_tableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.top_white.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.top_white.frame) - 49) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    //头视图
    [self p_head_delegate];
    self.tableView.tableHeaderView = self.headview_Delegate;

    //注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_WebStroe"];
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.number_delegate = 1;
        weakSelf.number_factory = 1;
        
        [weakSelf.tableView reloadData];
        
        [weakSelf loadNewData];
        
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if(weakSelf.isFactory == YES)
        {
            weakSelf.number_factory ++;
        }
        else
        {
            weakSelf.number_delegate ++;
        }
        
        [weakSelf.tableView reloadData];
        
        [weakSelf loadNewData];
    }];

}

//tableView代理
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.isFactory == NO)
    {
        return self.number_delegate;
    }
    else
    {
        return self.number_factory;
    }
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat length_h = ((SCREEN_WIDTH ) / 4 + 105) * 2.25;
    return length_h;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat length_h = ((SCREEN_WIDTH ) / 4 + 105) * 2.25;
    
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, length_h);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
//    [self p_collection];
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //每个item的大小
    int  item_length = (SCREEN_WIDTH ) / 4;
    layout.itemSize = CGSizeMake(item_length + 11, item_length + 40);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.stroe_collectionView = [[UICollectionView alloc] initWithFrame:cell.frame collectionViewLayout:layout];
    self.stroe_collectionView.delegate = self;
    self.stroe_collectionView.dataSource = self;
    self.stroe_collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.stroe_collectionView.tag = indexPath.row;
    
    [self.stroe_collectionView registerClass:[WebStroeCollectionViewCell class] forCellWithReuseIdentifier:@"cell_webStroe"];
    
    [cell addSubview:self.stroe_collectionView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - collection
- (void)p_collection
{
    
}

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
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.item);
}

#pragma mark - 头视图+++++++++++++++++++++++++++++++++++代理商
- (void)p_head_delegate
{
    self.headview_Delegate = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    self.headview_Delegate.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    self.delegate_address = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.delegate_address.frame = CGRectMake(10, 10, 70, 40);
    self.delegate_address.backgroundColor = [UIColor orangeColor];
    [self.headview_Delegate addSubview:self.delegate_address];
    [self.delegate_address addTarget:self action:@selector(delegate_addressAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.delegate_class = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.delegate_class.frame = CGRectMake(CGRectGetMaxX(self.delegate_address.frame) + 10, 10, 70, 40);
    self.delegate_class.backgroundColor = [UIColor orangeColor];
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

//代理中的地址范围
- (void)delegate_addressAction:(UIButton *)sender
{
    NSLog(@"代理中的地址范围");
    
    LocationViewController * locationViewController = [[LocationViewController alloc] init];
    
    [self showViewController:locationViewController sender:nil];
    
}
//代理中的分类
- (void)delegate_classAction:(UIButton *)sender
{
    NSLog(@"代理中的分类");
}
//代理中的查找关键字
- (void)delegate_searchAction:(UIButton *)sender
{
    NSLog(@"代理中的查找关键字");
    
    SearchViewController * searchViewController = [[SearchViewController alloc] init];
    [self showViewController:searchViewController sender:nil];
}

#pragma mark - 头视图+++++++++++++++++++++++++++++++++++厂家
- (void)p_head_factory
{
    self.headview_Factory = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    self.headview_Factory.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.factory_class = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.factory_class.frame = CGRectMake(10, 10, 70, 40);
    self.factory_class.backgroundColor = [UIColor orangeColor];
    [self.headview_Factory addSubview:self.factory_class];
    [self.factory_class addTarget:self action:@selector(factory_classAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.factory_search = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.factory_search.frame = CGRectMake(CGRectGetMaxX(self.factory_class.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(self.factory_class.frame) - 20, 40);
    self.factory_search.layer.cornerRadius = SCREEN_WIDTH * 0.055;
    self.factory_search.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.factory_search.layer.borderWidth = 1;
    self.factory_search.backgroundColor = [UIColor whiteColor];
    [self.headview_Factory addSubview:self.factory_search];
    [self.factory_search addTarget:self action:@selector(factory_searchAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7.5, 25, 25)];
    image.image = [UIImage imageNamed:@"iconfont-sousuo"];
    [self.factory_search addSubview:image];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame) + 10, 7.5, 120, 25)];
    label.text = @"请输入关键字";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor grayColor];
    [self.factory_search addSubview:label];

}

//厂家中的分类
- (void)factory_classAction:(UIButton *)sender
{
    NSLog(@"厂家中的分类");
}
//厂家中的查找关键字
- (void)factory_searchAction:(UIButton *)sender
{
    NSLog(@"厂家中的查找关键字");
    
    FactroySearchViewController * factroySearchViewController = [[FactroySearchViewController alloc] init];
    [self showViewController:factroySearchViewController sender:nil];
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

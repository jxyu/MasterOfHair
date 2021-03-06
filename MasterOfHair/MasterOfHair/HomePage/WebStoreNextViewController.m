//
//  WebStoreNextViewController.m
//  MasterOfHair
//
//  Created by 于金祥 on 16/6/14.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "WebStoreNextViewController.h"


#import "WebStroeCollectionViewCell.h"
#import "AppDelegate.h"
#import "LocationViewController.h"
#import "SearchViewController.h"

#import "chanpingxiangqingViewController.h"
#import "FenleiViewController.h"

#import "WebStroe_Model.h"
#import "JCCollectionViewCell.h"

@interface WebStoreNextViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
//tableView
@property (nonatomic, strong) UITableView * tableView;

//collectionView
@property (nonatomic, strong) UICollectionView * stroe_collectionView;

//头视图
@property (nonatomic, strong) UIView * head_view;


//分类（10个）
//@property (nonatomic, strong) UICollectionView * classify_collectionView;
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


//保存数据的数组
@property (nonatomic, strong) NSMutableArray * arr_data;
//全部数据
@property (nonatomic, strong) NSMutableArray * arr_all;
@property (nonatomic, strong) NSMutableArray * arr_lunboData;


////轮播图
@property (nonatomic, strong) UIImageView * image1;
@property (nonatomic, strong) UIImageView * image2;
@property (nonatomic, strong) UIImageView * image4;

@end

@implementation WebStoreNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self p_data2];
    [SVProgressHUD showWithStatus:@"加载数据中,请稍等..." ];
    
    
    
    [self p_setupView];
    [self p_navi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navi
- (void)p_navi
{
    //    _topView.backgroundColor=[UIColor clearColor];
    _lblTitle.text = @"商城";
    _lblTitle.font = [UIFont systemFontOfSize:19];
    [self addLeftButton:@"iconfont-fanhui"];
    _lblLeft.text=@"返回";
    _lblLeft.textAlignment=NSTextAlignmentLeft;
    //    [self.view bringSubviewToFront:_imgLeft];
    //    [self.view bringSubviewToFront:_btnLeft];
    //    [self.view bringSubviewToFront:_lblTitle];
}

-(void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//显示tabbar
-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    if([[userdefault objectForKey:@"category_name"] length] == 0)
    {
        [self.delegate_class setTitle:self.type_title?self.type_title:@"全部分类" forState:UIControlStateNormal];
    }
    else
    {
        [self.delegate_class setTitle:[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"category_name"]] forState:UIControlStateNormal];
    }
    
    
    if([[userdefault objectForKey:@"city_id"] length] == 0)
    {
        [self.delegate_address setTitle:@"定位城市" forState:UIControlStateNormal];
        
        if([[userdefault objectForKey:@"diquweizhi"] length] == 0)
        {
            [self.delegate_address setTitle:@"定位城市" forState:UIControlStateNormal];
            
            [userdefault setObject:@"183" forKey:@"diquweizhi_id"];
        }
        else
        {
            [self.delegate_address setTitle:[userdefault objectForKey:@"diquweizhi"] forState:UIControlStateNormal];
        }
    }
    else
    {
        [self.delegate_address setTitle:[userdefault objectForKey:@"city_name"] forState:UIControlStateNormal];
        
        if([[userdefault objectForKey:@"diquweizhi"] length] == 0)
        {
            [self.delegate_address setTitle:[userdefault objectForKey:@"city_name"] forState:UIControlStateNormal];
            [userdefault setObject:[userdefault objectForKey:@"city_id"] forKey:@"diquweizhi_id"];
        }
        else
        {
            [self.delegate_address setTitle:[userdefault objectForKey:@"diquweizhi"] forState:UIControlStateNormal];
        }
    }
    
    NSLog(@"%@,%@",[userdefault objectForKey:@"diquweizhi"],[userdefault objectForKey:@"diquweizhi_id"]);
    
    
    [self example01];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showTabBar];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT - 49) style:(UITableViewStylePlain)];
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
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self p_data2];
        //        self.isplay = 0;
        
        [self p_data];
        
        [weakSelf.tableView reloadData];
        [weakSelf loadNewData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self p_data1];
        
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
    return self.arr_all.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat length_h = 0;
    
    
    if(SCREEN_WIDTH < 360)
    {
        if([self.arr_all[indexPath.row] count] >= 7)
        {
            length_h = ((SCREEN_WIDTH ) / 4 + 100) * 2.15;
        }
        else if([self.arr_all[indexPath.row] count] <= 6 && [self.arr_all[indexPath.row] count] >= 4)
        {
            length_h = (((SCREEN_WIDTH ) / 4 + 100) * 2.15) / 3 * 2;
        }
        else if([self.arr_all[indexPath.row] count] <= 3 && [self.arr_all[indexPath.row] count] >= 1)
        {
            length_h = ((SCREEN_WIDTH ) / 4 + 100) * 2.15 / 3;
        }
    }
    else
    {
        if([self.arr_all[indexPath.row] count] >= 7)
        {
            length_h = ((SCREEN_WIDTH ) / 4 + 100) * 2.25;
        }
        else if([self.arr_all[indexPath.row] count] <= 6 && [self.arr_all[indexPath.row] count] >= 4)
        {
            length_h = ((SCREEN_WIDTH ) / 4 + 100) * 2.25 / 3 * 2;
        }
        else if([self.arr_all[indexPath.row] count] <= 3 && [self.arr_all[indexPath.row] count] >= 1)
        {
            length_h = ((SCREEN_WIDTH ) / 4 + 100) * 2.25 / 3;
        }
    }
    return length_h;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat length_h = 0;
    
    if(SCREEN_WIDTH < 360)
    {
        if([self.arr_all[indexPath.row] count] >= 7)
        {
            length_h = ((SCREEN_WIDTH ) / 4 + 100) * 2.15;
        }
        else if([self.arr_all[indexPath.row] count] <= 6 && [self.arr_all[indexPath.row] count] >= 4)
        {
            length_h = (((SCREEN_WIDTH ) / 4 + 100) * 2.15) / 3 * 2;
        }
        else
        {
            length_h = ((SCREEN_WIDTH ) / 4 + 100) * 2.15 / 3;
        }
    }
    else
    {
        if([self.arr_all[indexPath.row] count] >= 7)
        {
            length_h = ((SCREEN_WIDTH ) / 4 + 100) * 2.25;
        }
        else if([self.arr_all[indexPath.row] count] <= 6 && [self.arr_all[indexPath.row] count] >= 4)
        {
            length_h = ((SCREEN_WIDTH ) / 4 + 100) * 2.25 / 3 * 2;
        }
        else
        {
            length_h = ((SCREEN_WIDTH ) / 4 + 100) * 2.25 / 3;
        }
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
//    if([collectionView isEqual:self.classify_collectionView])
//    {
//        return 10;
//    }
    return [self.arr_all[collectionView.tag] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
//    if([collectionView isEqual:self.classify_collectionView])
//    {
//        JCCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_classify" forIndexPath:indexPath];
//        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"class_%ld",(long)indexPath.item]];
//        switch (indexPath.row) {
//            case 0:
//            {
//                cell.name.text = @"美发产品";
//                
//            }
//                break;
//            case 1:
//            {
//                cell.name.text = @"美容产品";
//                
//            }
//                break;
//            case 2:
//            {
//                cell.name.text = @"纹绣产品";
//                
//            }
//                break;
//            case 3:
//            {
//                cell.name.text = @"美甲产品";
//                //                cell.imageView.image = [UIImage imageNamed:@"01_38"];
//                
//            }
//                break;
//            case 4:
//            {
//                cell.name.text = @"化妆产品";
//                //                cell.imageView.image = [UIImage imageNamed:@"01_41"];
//                
//            }
//                break;
//            case 5:
//            {
//                cell.name.text = @"足浴";
//                //                cell.imageView.image = [UIImage imageNamed:@"01_59"];
//                
//            }
//                break;
//            case 6:
//            {
//                cell.name.text = @"纹身产品";
//                //                cell.imageView.image = [UIImage imageNamed:@"01_62"];
//                
//            }
//                break;
//            case 7:
//            {
//                cell.name.text = @"美业服饰";
//                //                cell.imageView.image = [UIImage imageNamed:@"01_65"];
//                
//            }
//                break;
//            case 8:
//            {
//                cell.name.text = @"国际品牌";
//                //                cell.imageView.image = [UIImage imageNamed:@"01_68"];
//                
//            }
//                break;
//            case 9:
//            {
//                cell.name.text = @"教学资料";
//                //                cell.imageView.image = [UIImage imageNamed:@"01_71"];
//                
//            }
//                break;
//            default:
//                break;
//        }
//        return cell;
//    }
    
    
    
    
    WebStroe_Model * model = self.arr_all[collectionView.tag][indexPath.item];
    
    WebStroeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_webStroe" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    //价格
    cell.price.text = [NSString stringWithFormat:@"¥%@",model.sell_price];
    
    cell.old_price.text = [NSString stringWithFormat:@"¥%@",model.net_price];
    
    cell.detail.text = model.production_name;
    
    [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/product/%@",Url_pic,model.list_img]] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
    
    if(![model.city_id isEqualToString:@"0"])
    {
        cell.image_class.hidden = YES;
    }
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if([collectionView isEqual:self.classify_collectionView])
//    {
//        [self fenleiBtnClick:indexPath.item];
//        return;
//    }
    
    
    //    NSLog(@"第几行tableView   %ld",collectionView.tag + 1);
    //    NSLog(@"%ld",(long)indexPath.item);
    
    WebStroe_Model * model = self.arr_all[collectionView.tag][indexPath.item];
    
    chanpingxiangqingViewController * chanpingxiangqing = [[chanpingxiangqingViewController alloc] init];
    
    //    NSLog(@"%@",model.production_id);
    
    chanpingxiangqing.production_id = model.production_id;
    
    [self showViewController:chanpingxiangqing sender:nil];
}

#pragma mark - 头视图
- (void)p_headView
{
    self.head_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,  70)];
    self.head_view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //    [self p_lunbotu];
    //
    //    [self.head_view addSubview:self.lunbo_scrollView];
    //    [self.head_view addSubview:self.lunbo_pageControl];
//    [self.head_view addSubview:self.classify_collectionView];
    //搜索。。。。。。。
    [self p_setupView2];
}

#pragma mark - 3个点击布局
- (void)p_setupView2
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    UIView * lastView=[self.head_view.subviews lastObject];
    self.headview_Delegate = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lastView.frame), SCREEN_WIDTH, 60)];
    self.headview_Delegate.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.head_view addSubview:self.headview_Delegate];
    
    
    self.delegate_address = [FL_Button fl_shareButton];
    self.delegate_address.frame = CGRectMake(10, 12.5, 70, 35);
    [self.delegate_address setImage:[UIImage imageNamed:@"select_down"] forState:UIControlStateNormal];
    //定位城市
    if([[userdefault objectForKey:@"diquweizhi"] length] == 0)
    {
        [self.delegate_address setTitle:@"定位城市" forState:UIControlStateNormal];
    }
    else
    {
        [self.delegate_address setTitle:[NSString stringWithFormat:@" %@",[userdefault objectForKey:@"diquweizhi"]] forState:UIControlStateNormal];
    }
    [self.delegate_address setTitleColor:navi_bar_bg_color forState:UIControlStateNormal];
    self.delegate_address.status = FLAlignmentStatusCenter;
    self.delegate_address.titleLabel.font = [UIFont systemFontOfSize:12];
    self.delegate_address.layer.masksToBounds=YES;
    self.delegate_address.layer.borderWidth= 1;
    self.delegate_address.layer.borderColor=navi_bar_bg_color.CGColor;
    self.delegate_address.layer.cornerRadius=8;
    [self.headview_Delegate addSubview:self.delegate_address];
    [self.delegate_address addTarget:self action:@selector(delegate_addressAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.delegate_class = [FL_Button fl_shareButton];
    self.delegate_class.frame = CGRectMake(CGRectGetMaxX(self.delegate_address.frame) + 10, 12.5, 70, 35);
    [self.delegate_class setImage:[UIImage imageNamed:@"select_down"] forState:UIControlStateNormal];
    
    if([[userdefault objectForKey:@"category_name"] length] == 0)
    {
        [self.delegate_class setTitle:self.type_title?self.type_title:@"全部分类" forState:UIControlStateNormal];
    }
    else
    {
        [self.delegate_class setTitle:[NSString stringWithFormat:@" %@",[userdefault objectForKey:@"category_name"]] forState:UIControlStateNormal];
    }
    
    [self.delegate_class setTitleColor:navi_bar_bg_color forState:UIControlStateNormal];
    self.delegate_class.status = FLAlignmentStatusCenter;
    self.delegate_class.titleLabel.font = [UIFont systemFontOfSize:12];
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
    //    NSLog(@"查找关键字");
    
    SearchViewController * searchViewController = [[SearchViewController alloc] init];
    searchViewController.is_maker = @"0";
    
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
    self.lunbo_scrollView.userInteractionEnabled = YES;
    
    self.lunbo_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.arr_lunboData.count + 2, 0);
    
    if(self.arr_lunboData.count == 0)
    {
        self.image4.hidden = NO;
        
        self.lunbo_scrollView.scrollEnabled = NO;
        
        self.image4 = [[UIImageView alloc] init];
        self.image4.frame = CGRectMake(SCREEN_WIDTH * 1, 0 , SCREEN_WIDTH, 200);
        [self.image4 sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
        [self.lunbo_scrollView addSubview:self.image4];
        
        
        self.image1 = [[UIImageView alloc] init];
        self.image1.frame = CGRectMake(SCREEN_WIDTH * 0 , 0 , SCREEN_WIDTH, 200);
        [self.image1 sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
        [self.lunbo_scrollView addSubview:self.image1];
    }
    else
    {
        [self lunsdsd];
    }
    //
    self.lunbo_pageControl = [[UIPageControl alloc] init];
    self.lunbo_pageControl.frame = CGRectMake(self.view.frame.size.width / 2 - 50, 180, 100, 18);
    self.lunbo_pageControl.numberOfPages = self.arr_lunboData.count;
    self.lunbo_pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:132/255.0 green:193/255.0 blue:254/255.0 alpha:1];
    self.lunbo_pageControl.pageIndicatorTintColor = [UIColor colorWithRed:202/255.0 green:218/255.0 blue:233/255.0 alpha:1];
    
    //手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.lunbo_scrollView addGestureRecognizer:tapGesture];
}

#pragma mark - 轮播图的点击事件
-(void)tapGesture:(id)sender
{
    
}

#pragma mark - 定时器的方法!
- (void)timerAction
{
    CGFloat x = self.lunbo_scrollView.contentOffset.x;
    int count = x / SCREEN_WIDTH;
    
    if(count < self.arr_lunboData.count)
    {
        count ++;
        [UIView animateWithDuration:0.7f animations:^{
            
            self.lunbo_scrollView.contentOffset = CGPointMake(count * SCREEN_WIDTH, 0);
            self.lunbo_pageControl.currentPage = count - 1;
            
        }];
    }
    else if(count == self.arr_lunboData.count)
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
    
    if(count == self.arr_lunboData.count + 1)
    {
        self.lunbo_scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        self.lunbo_pageControl.currentPage = 0;
    }
    else if(count == 0)
    {
        self.lunbo_scrollView.contentOffset = CGPointMake(self.arr_lunboData.count * SCREEN_WIDTH, 0);
        self.lunbo_pageControl.currentPage = self.arr_lunboData.count - 1;
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

#pragma mark - 加载数据 (首条)
- (void)p_data
{
    self.page = 1;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"product:"];
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    if([[userdefault objectForKey:@"category_id"] length] == 0)
    {
        [dataprovider productWithcity_id:[userdefault objectForKey:@"diquweizhi_id"] category_id:@"0" is_maker:@"0" is_sell:@"1" pagenumber:@"1" pagesize:@"9"];
    }
    else
    {
        [dataprovider productWithcity_id:[userdefault objectForKey:@"diquweizhi_id"] category_id:[userdefault objectForKey:@"category_id"] is_maker:@"0" is_sell:@"1" pagenumber:@"1" pagesize:@"9"];
    }
}

//后面的
- (void)p_data1
{
    self.page ++;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"product1:"];
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    if([[userdefault objectForKey:@"category_id"] length] == 0)
    {
        [dataprovider productWithcity_id:[userdefault objectForKey:@"diquweizhi_id"] category_id:@"0" is_maker:@"0" is_sell:@"1" pagenumber:[NSString stringWithFormat:@"%ld",(long)self.page] pagesize:@"9"];
    }
    else
    {
        [dataprovider productWithcity_id:[userdefault objectForKey:@"diquweizhi_id"] category_id:[userdefault objectForKey:@"category_id"] is_maker:@"0" is_sell:@"1" pagenumber:[NSString stringWithFormat:@"%ld",(long)self.page]pagesize:@"9"];
    }
}

#pragma mark - 商城数据
- (void)product:(id )dict
{
    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];
    
    self.arr_data = nil;
    self.arr_all = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"productlist"])
            {
                WebStroe_Model * model = [[WebStroe_Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_data addObject:model];
            }
            
            if(self.arr_data != nil)
            {
                [self.arr_all addObject:self.arr_data];
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

- (void)product1:(id )dict
{
    //    NSLog(@"%@",dict);
    
    self.arr_data = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"productlist"])
            {
                WebStroe_Model * model = [[WebStroe_Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_data addObject:model];
            }
            
            if(self.arr_data != nil)
            {
                [self.arr_all addObject:self.arr_data];
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


-(void)fenleiBtnClick:(NSInteger)index
{
    NSString * str_category=[NSString stringWithFormat:@"%ld",index+19];
    set_sp(@"category_id", str_category);
    [self example01];
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

#pragma mark - 轮播数据
- (void)p_data2
{
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"Slide_type:"];
    
    [dataprovider getSlidesWithSlide_type:@"2"];
}

//数据
- (void)Slide_type:(id )dict
{
    //    NSLog(@"%@",dict);
    
    self.arr_lunboData = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"slidelist"])
            {
                [self.arr_lunboData addObject:dic[@"slide_img"]];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            [self lunsdsd];
        }
    }
    else
    {
        
    }
}

- (void)lunsdsd
{
    self.lunbo_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * (self.arr_lunboData.count + 2), 0);
    
    self.lunbo_pageControl.numberOfPages = self.arr_lunboData.count;
    
    self.lunbo_scrollView.scrollEnabled = YES;
    
    self.image4.hidden = YES;
    
    for (int i = 1; i <= self.arr_lunboData.count; i++)
    {
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, 200)];
        
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/slide/%@",Url_pic,self.arr_lunboData[i - 1]]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
        
        [self.lunbo_scrollView addSubview:image];
    }
    
    self.image1 = [[UIImageView alloc] init];
    self.image1.frame = CGRectMake(SCREEN_WIDTH * 0 , 0 , SCREEN_WIDTH, 200);
    [self.image1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/slide/%@",Url_pic,self.arr_lunboData[self.arr_lunboData.count - 1]]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
    [self.lunbo_scrollView addSubview:self.image1];
    
    self.image2 = [[UIImageView alloc] init];
    self.image2.frame = CGRectMake(SCREEN_WIDTH * (self.arr_lunboData.count + 1), 0 , SCREEN_WIDTH, 200);
    [self.image2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/slide/%@",Url_pic,self.arr_lunboData[0]]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
    [self.lunbo_scrollView addSubview:self.image2];
    
    
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

- (NSMutableArray *)arr_all
{
    if(_arr_all == nil)
    {
        self.arr_all = [NSMutableArray array];
    }
    return _arr_all;
}

- (NSMutableArray *)arr_lunboData
{
    if(_arr_lunboData == nil)
    {
        self.arr_lunboData = [NSMutableArray array];
    }
    return _arr_lunboData;
}

//-(UICollectionView *)classify_collectionView
//{
//    if (!_classify_collectionView) {
//        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
//        //每个item的大小
//        int  item_length = (SCREEN_WIDTH - 20) / 6;
//        layout.itemSize = CGSizeMake(item_length, item_length + 20);
//        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//        
//        _classify_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH - 20) / 3 + 70) collectionViewLayout:layout];
//        _classify_collectionView.delegate = self;
//        _classify_collectionView.dataSource = self;
//        
//        _classify_collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        
//        [_classify_collectionView registerClass:[JCCollectionViewCell class] forCellWithReuseIdentifier:@"cell_classify"];
//    }
//    return _classify_collectionView;
//}




@end

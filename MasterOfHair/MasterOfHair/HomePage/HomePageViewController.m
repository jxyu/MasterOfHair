//
//  HomePageViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/19.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "HomePageViewController.h"


#import "JCCollectionViewCell.h"
#import "JCStroeCollectionViewCell.h"
#import "JCVideoCollectionViewCell.h"
#import "SearchViewController.h"
#import "AppDelegate.h"

#import "AdvertiseViewController.h"

#import "BusinessSchoolViewController.h"

#import "wenxiulianmengViewController.h"
#import "MingshiViewController.h"
#import "chanpingxiangqingViewController.h"
#import "KechengbaomingViewController.h"
#import "ShangmengViewController.h"
@interface HomePageViewController ()  <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView * tableView;
//轮播图
@property (nonatomic, strong) UIScrollView * lunbo_scrollView;
@property (nonatomic, strong) UIPageControl * lunbo_pageControl;
@property (nonatomic, strong) NSTimer * lunbo_timer;
@property (nonatomic, assign) BOOL isplay;

//分类（10个）
@property (nonatomic, strong) UICollectionView * classify_collectionView;

//商品推荐
@property (nonatomic, strong) UILabel * store_detail;
@property (nonatomic, strong) UIButton * stroe_all;
@property (nonatomic, strong) UICollectionView * stroe_collectionView;

//视频列表
@property (nonatomic, strong) UICollectionView * video_collectionView;
@property (nonatomic, strong) UILabel * video_name;

//最上面的搜索框
@property (nonatomic, strong) UIView * search_view;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_navi];
    
    [self p_setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - navi
- (void)p_navi
{
    //左边为定位
    [self addLeftbuttontitle:@"临沂"];
    _btnLeft.frame = CGRectMake(10, _lblLeft.frame.origin.y + 5, 60, _lblLeft.frame.size.height - 10);
    _lblLeft.frame = CGRectMake(10, _lblLeft.frame.origin.y + 5, 60, _lblLeft.frame.size.height - 10);
    _lblLeft.font = [UIFont systemFontOfSize:15];
    _lblLeft.textAlignment = NSTextAlignmentCenter;
//    _lblLeft.backgroundColor = [UIColor orangeColor];
    
    //右边为签到
    [self addRightButton:@"01_03"];
    _imgRight.frame = CGRectMake(SCREEN_WIDTH - 5 - 40, _imgRight.frame.origin.y, _imgRight.frame.size.width, _imgRight.frame.size.height);
//    [self addRightbuttontitle:@"签到"];
    _btnRight.frame = CGRectMake(SCREEN_WIDTH - 10 - 40, _lblRight.frame.origin.y + 0, 40, _lblRight.frame.size.height - 10);
//    _btnRight.backgroundColor = [UIColor orangeColor];

    //中间为搜索框
    _lblTitle.hidden = YES;
    self.search_view = [[UIView alloc] initWithFrame:CGRectMake(80 , 25, SCREEN_WIDTH - 140, 34)];
    self.search_view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.search_view.layer.cornerRadius = 0.05 * SCREEN_WIDTH;
    [self.view addSubview:self.search_view];
    //图标
    UIImageView * search_image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 25, 25)];
    search_image.image = [UIImage imageNamed:@"iconfont-sousuo"];
    [self.search_view addSubview:search_image];
    //文字
    UILabel * search_text = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(search_image.frame) + 6, 5, 120, 25)];
    search_text.text = @"请输入关键字";
    search_text.font = [UIFont systemFontOfSize:15];
    search_text.textColor = [UIColor grayColor];
    [self.search_view addSubview:search_text];
    
    UIButton * search_btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    search_btn.frame = CGRectMake(0 , 0, self.search_view.frame.size.width, self.search_view.frame.size.height);
//    search_btn.backgroundColor = [UIColor orangeColor];
    [self.search_view addSubview:search_btn];
    [search_btn addTarget:self action:@selector(search_btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

//定位
- (void)clickLeftButton:(UIButton *)sender
{
    //这个调定位，不跳页，返回一个当前的位置就可
    NSLog(@"定位");
}

//签到
- (void)clickRightButton:(UIButton *)sender
{
    NSLog(@"签到");
}

//搜索框点击事件
- (void)search_btnAction:(UIButton *)sender
{
//    NSLog(@"搜索");
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] selectTableBarIndex:2];
}

//显示tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showTabBar];
}

#pragma mark - 总布局
- (void)p_setupView
{
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0 , 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:(UITableViewStylePlain)];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - tableView代理
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 200;
    }
    else if(indexPath.row == 1)
    {
        return (SCREEN_WIDTH - 20) / 3 + 70;
    }
    else if(indexPath.row == 2)
    {
        return (SCREEN_WIDTH ) / 4 + 105;
    }
    else if(indexPath.row == 3)
    {
        //判断奇数还是偶数
        //        if(8 % 2 == 0)
        //        {
        //            return 4 * (SCREEN_WIDTH / 4) + 100;
        //        }
        //        else
        //        {
        //            return ((7 + 1) / 2 )* (SCREEN_WIDTH / 4) + 100;
        //        }
        return 4 * (SCREEN_WIDTH / 4) + 100;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    if(indexPath.row == 0)
    {
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
        
        [self p_lunbotu];
        
        [cell addSubview:self.lunbo_scrollView];
        
        [cell addSubview:self.lunbo_pageControl];
    }
    else if (indexPath.row == 1)
    {
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH - 20) / 3 + 70);
        
        [self p_classify];
        
        [cell addSubview:self.classify_collectionView];
    }
    else if(indexPath.row == 2)
    {
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH ) / 4 + 105);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self p_stroe];
        
        [cell addSubview:self.store_detail];
        [cell addSubview:self.stroe_all];
        
        [cell addSubview:self.stroe_collectionView];
    }
    else if(indexPath.row == 3)
    {
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 4 * (SCREEN_WIDTH / 4) + 100);
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self p_videoList];
        
        [cell addSubview:self.video_name];
        [cell addSubview:self.video_collectionView];
    }
    
    return cell;
}

#pragma mark - 轮播图
- (void)p_lunbotu
{
    self.lunbo_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    //        self.lunbo_scrollView.backgroundColor = [UIColor orangeColor];
    self.lunbo_scrollView.pagingEnabled = YES;
    self.lunbo_scrollView.showsHorizontalScrollIndicator = NO;
    self.lunbo_scrollView.delegate = self;
    
    self.lunbo_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 8, 0);
    
    //6张图
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
    
    UIImageView * view6 = [[UIImageView alloc] init];
    view6.frame = CGRectMake(SCREEN_WIDTH * 5 , 0 , SCREEN_WIDTH, 200);
    [view6 sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
    [self.lunbo_scrollView addSubview:view6];
    
    UIImageView * view7 = [[UIImageView alloc] init];
    view7.frame = CGRectMake(SCREEN_WIDTH * 6 , 0 , SCREEN_WIDTH, 200);
    [view7 sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
    [self.lunbo_scrollView addSubview:view7];
    
    UIImageView * view8 = [[UIImageView alloc] init];
    view8.frame = CGRectMake(SCREEN_WIDTH * 7 , 0 , SCREEN_WIDTH, 200);
    [view8 sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
    [self.lunbo_scrollView addSubview:view8];
    
    //开始到第一个图
    //    self.lunbo_scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
    self.lunbo_pageControl = [[UIPageControl alloc] init];
    self.lunbo_pageControl.frame = CGRectMake(self.view.frame.size.width / 2 - 50, 180, 100, 18);
    self.lunbo_pageControl.numberOfPages = 6;
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
        case 3:
            break;
        case 4:
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
    
    if(count < 6)
    {
        count ++;
        [UIView animateWithDuration:0.7f animations:^{
            
            self.lunbo_scrollView.contentOffset = CGPointMake(count * SCREEN_WIDTH, 0);
            self.lunbo_pageControl.currentPage = count - 1;
            
        }];
    }
    else if(count == 6)
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
    
    if(count == 7)
    {
        self.lunbo_scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        self.lunbo_pageControl.currentPage = 0;
    }
    else if(count == 0)
    {
        self.lunbo_scrollView.contentOffset = CGPointMake(6 * SCREEN_WIDTH, 0);
        self.lunbo_pageControl.currentPage = 5;
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

#pragma mark - 分类的10个
- (void)p_classify
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //每个item的大小
    int  item_length = (SCREEN_WIDTH - 20) / 6;
    layout.itemSize = CGSizeMake(item_length, item_length + 20);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.classify_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH - 20) / 3 + 70) collectionViewLayout:layout];
    self.classify_collectionView.delegate = self;
    self.classify_collectionView.dataSource = self;
    
    self.classify_collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.classify_collectionView registerClass:[JCCollectionViewCell class] forCellWithReuseIdentifier:@"cell_classify"];
}

#pragma mark - classify_collectionView的代理
//有几个分区
- (NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1; 
}
//每个分区有多少个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if([collectionView isEqual:self.classify_collectionView])
    {
        return 10;
    }
    else if([collectionView isEqual:self.stroe_collectionView])
    {
        return 3;
    }
    else
    {
        return 7;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([collectionView isEqual:self.classify_collectionView])
    {
        JCCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_classify" forIndexPath:indexPath];
        switch (indexPath.row) {
            case 0:
            {
                cell.name.text = @"商学院";
                cell.imageView.image = [UIImage imageNamed:@"01_29"];
            }
                break;
            case 1:
            {
                cell.name.text = @"商城";
                cell.imageView.image = [UIImage imageNamed:@"01_32"];

            }
                break;
            case 2:
            {
                cell.name.text = @"纹绣联盟";
                cell.imageView.image = [UIImage imageNamed:@"01_35"];

            }
                break;
            case 3:
            {
                cell.name.text = @"名师名店";
                cell.imageView.image = [UIImage imageNamed:@"01_38"];

            }
                break;
            case 4:
            {
                cell.name.text = @"招聘";
                cell.imageView.image = [UIImage imageNamed:@"01_41"];

            }
                break;
            case 5:
            {
                cell.name.text = @"美业频道";
                cell.imageView.image = [UIImage imageNamed:@"01_59"];

            }
                break;
            case 6:
            {
                cell.name.text = @"说说";
                cell.imageView.image = [UIImage imageNamed:@"01_62"];

            }
                break;
            case 7:
            {
                cell.name.text = @"商盟";
                cell.imageView.image = [UIImage imageNamed:@"01_65"];

            }
                break;
            case 8:
            {
                cell.name.text = @"基金会";
                cell.imageView.image = [UIImage imageNamed:@"01_68"];

            }
                break;
            case 9:
            {
                cell.name.text = @"课程表名";
                cell.imageView.image = [UIImage imageNamed:@"01_71"];

            }
                break;
            default:
                break;
        }
        return cell;
    }
    else if([collectionView isEqual:self.stroe_collectionView])
    {
        JCStroeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_store" forIndexPath:indexPath];
        
        [cell.image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long"]];
        
        return cell;
    }
    else
    {
        JCVideoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_video" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [cell.image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long"]];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([collectionView isEqual:self.classify_collectionView])
    {
        NSLog(@"%ld",(long)indexPath.item);
        switch (indexPath.row) {
            case 0:
            {//跳转商学院
                
                [(AppDelegate *)[[UIApplication sharedApplication] delegate] selectTableBarIndex:1];
            }
                break;
            case 1:
            {//商城
                [(AppDelegate *)[[UIApplication sharedApplication] delegate] selectTableBarIndex:2];
            }
                break;
            case 2:
            {//纹绣联盟
                wenxiulianmengViewController * wenxiulianmeng = [[wenxiulianmengViewController alloc] init];
                
                [self showViewController:wenxiulianmeng sender:nil];
                
            }
                break;
            case 3:
            {
                MingshiViewController * mingshiViewController = [[MingshiViewController alloc] init];
                
                [self showViewController:mingshiViewController sender:nil];
            }
                break;
            case 4:
            {//招聘
                AdvertiseViewController * advertistVC=[[AdvertiseViewController alloc] init];
                
                [self.navigationController pushViewController:advertistVC animated:YES];
            }
                break;
            case 5:
            {
                
            }
                break;
            case 6:
            {
                
            }
                break;
            case 7:
            {
                ShangmengViewController * shangmengViewController = [[ShangmengViewController alloc] init];
                
                [self showViewController:shangmengViewController sender:nil];
            }
                break;
            case 8:
            {
                
            }
                break;
            case 9:
            {
                KechengbaomingViewController * kechengbaomingViewController = [[KechengbaomingViewController alloc] init];
                [self showViewController:kechengbaomingViewController sender:nil];
            }
                break;
            default:
                break;
        }
    }
    else if([self.stroe_collectionView isEqual:collectionView])
    {
        NSLog(@"111 ~~ %ld",(long)indexPath.item);
        
        chanpingxiangqingViewController * chanpingxiangqing = [[chanpingxiangqingViewController alloc] init];
        
        [self showViewController:chanpingxiangqing sender:nil];
    }
    else
    {
        NSLog(@"%ld",(long)indexPath.item);
    }
    
}

#pragma mark - 商品推荐
- (void)p_stroe
{
    self.store_detail = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 70, 27)];
    self.store_detail.text = @"商品推荐";
    
    self.stroe_all = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.stroe_all.frame = CGRectMake(SCREEN_WIDTH - 5 - 80, 15, 80, 25);
    [self.stroe_all setTitle:@"查看所有 >" forState:(UIControlStateNormal)];
    [self.stroe_all setTintColor:[UIColor blackColor]];
    //加点击方法
    [self.stroe_all addTarget:self action:@selector(store_detailAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //每个item的大小
    int  item_length = (SCREEN_WIDTH ) / 4;
    layout.itemSize = CGSizeMake(item_length + 11, item_length + 40);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.stroe_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.store_detail.frame) , SCREEN_WIDTH, (SCREEN_WIDTH ) / 4 + 105 - CGRectGetMaxY(self.store_detail.frame) - 5) collectionViewLayout:layout];
    self.stroe_collectionView.delegate = self;
    self.stroe_collectionView.dataSource = self;
    self.stroe_collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.stroe_collectionView registerClass:[JCStroeCollectionViewCell class] forCellWithReuseIdentifier:@"cell_store"];
}

//所有的商品推荐
- (void)store_detailAction:(UIButton *)sender
{
//    NSLog(@"所有的商品推荐");
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] selectTableBarIndex:2];
}

#pragma mark - 下面的视频列表
- (void )p_videoList
{
    self.video_name = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 200, 27)];
    self.video_name.text = @"精选热门视频";
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //每个item的大小
    int  item_length = (SCREEN_WIDTH ) / 3;
    layout.itemSize = CGSizeMake(item_length / 3 * 4.13, item_length / 4 * 3);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.video_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.video_name.frame) , SCREEN_WIDTH, 4 * (SCREEN_WIDTH / 4) + 100 - CGRectGetMaxY(self.video_name.frame) - 5) collectionViewLayout:layout];
    self.video_collectionView.delegate = self;
    self.video_collectionView.dataSource = self;
    self.video_collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.video_collectionView registerClass:[JCVideoCollectionViewCell class] forCellWithReuseIdentifier:@"cell_video"];
}

@end

//
//  HomePageViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/19.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "HomePageViewController.h"
#import "CCLocationManager.h"


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
#import "JinkahuiyuanViewController.h"
#import "TuwenViewController.h"
#import "VideoDetailViewController.h"
#import "ShuoshuoViewController.h"
#import "WebStroe_Model.h"
#import "TuWen_Models.h"
#import "LoginViewController.h"

#import "CreditViewController.h"
#import "CreditWebViewController.h"
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

////轮播图
@property (nonatomic, strong) UIImageView * image1;
@property (nonatomic, strong) UIImageView * image2;
@property (nonatomic, strong) UIImageView * image4;

//数据
@property (nonatomic, strong) NSMutableArray * arr_lunboData;

//获取产品热门列表
@property (nonatomic, strong) NSMutableArray * arr_chanpin;

//获取视频
@property (nonatomic, strong) NSMutableArray * arr_video;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self p_location];
    
    [self p_login];
    
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
    [self addLeftbuttontitle:@"定位"];
    
    _btnLeft.frame = CGRectMake(5, _lblLeft.frame.origin.y + 5, 55, _lblLeft.frame.size.height - 10);
    _lblLeft.frame = CGRectMake(5, _lblLeft.frame.origin.y + 5, 55, _lblLeft.frame.size.height - 10);
    _lblLeft.font = [UIFont systemFontOfSize:15];
    _lblLeft.textAlignment = NSTextAlignmentCenter;
//    _lblLeft.backgroundColor = [UIColor orangeColor];
    
    //右边为签到
    [self addRightButton:@"01_03"];
    _imgRight.frame = CGRectMake(SCREEN_WIDTH - 5 - 40 + 2.5, _imgRight.frame.origin.y + 2.5, _imgRight.frame.size.width - 5, _imgRight.frame.size.height - 5);
//    [self addRightbuttontitle:@"签到"];
    _btnRight.frame = CGRectMake(SCREEN_WIDTH - 10 - 40, _lblRight.frame.origin.y + 0, 40, _lblRight.frame.size.height - 10);
//    _btnRight.backgroundColor = [UIColor orangeColor];

    //中间为搜索框
    _lblTitle.hidden = YES;
    self.search_view = [[UIView alloc] initWithFrame:CGRectMake(65 , 25, SCREEN_WIDTH - 120, 34)];
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
//    NSLog(@"定位");
}

//签到
- (void)clickRightButton:(UIButton *)sender
{
//    NSLog(@"签到");
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    if([[userdefault objectForKey:@"member_id"] length] == 0)
    {
        LoginViewController * loginViewController = [[LoginViewController alloc] init];
        
        [self showViewController:loginViewController sender:nil];
    }
    else
    {//都有
        
        [SVProgressHUD showWithStatus:@"加载数据中,请稍等..." maskType:SVProgressHUDMaskTypeBlack];

        DataProvider * dataprovider=[[DataProvider alloc] init];
        [dataprovider setDelegateObject:self setBackFunctionName:@"CreateAutoLoginUrl:"];
        
        [dataprovider CreateAutoLoginUrlWithMember_id:[userdefault objectForKey:@"member_username"]];
    }
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
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
    [self example01];
    
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
    
    
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self p_chanpinliebiao];
        
        [self p_videoData];
        
        [self p_data2];
        //        self.isplay = 0;
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
        return (SCREEN_WIDTH ) / 3.87 + 100;
    }
    else if(indexPath.row == 3)
    {
        //判断奇数还是偶数
        
//        NSLog(@"%ld",self.arr_video.count);
        if(self.arr_video.count % 2 == 0)
        {
            return (self.arr_video.count / 2) * (SCREEN_WIDTH / 4) + 100;
        }
        else
        {
            return ((self.arr_video.count + 1) / 2 )* (SCREEN_WIDTH / 4) + 100;
        }
//        return 4 * (SCREEN_WIDTH / 4) + 100;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
- (void)tapGesture:(id)sender
{    
//    NSLog(@"%ld",self.lunbo_pageControl.currentPage);
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
        return self.arr_video.count;
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
                cell.name.text = @"开通会员";
                cell.imageView.image = [UIImage imageNamed:@"01_68"];

            }
                break;
            case 9:
            {
                cell.name.text = @"课程报名";
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
        
        if(self.arr_chanpin.count != 0)
        {
            WebStroe_Model * model = self.arr_chanpin[indexPath.item];
            
            NSString * str =  [NSString stringWithFormat:@"%@uploads/product/%@",Url_pic,model.list_img];
            [cell.image sd_setImageWithURL:[NSURL URLWithString:str]placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
            
            cell.price.text = [NSString stringWithFormat:@"￥ %@",model.sell_price];
            cell.detail.text = [NSString stringWithFormat:@"%@",model.production_name];
            
            cell.image_iocn.hidden = YES;

        }
        else
        {
            [cell.image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
        }
        return cell;
    }
    else
    {
        
        JCVideoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_video" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        if(self.arr_video.count != 0)
        {
            TuWen_Models * model = self.arr_video[indexPath.item];
            
            [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/video/%@",Url_pic,model.video_img]] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
            
            cell.name.text = model.video_title;
            
            if([model.is_free isEqualToString:@"0"])
            {
                cell.isFree.image = [UIImage imageNamed:@"01weuiwueiwu_48"];

            }
            else
            {
                cell.isFree.image = [UIImage imageNamed:@"01jskjdksjdksjkdjsk_55"];
            }
        }

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
                TuwenViewController * tuwenViewController = [[TuwenViewController alloc] init];
                tuwenViewController.isTeacher = 0;
                
                NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
                [userdefault setObject:@"1" forKey:@"TuwenFeilei"];
                
                [self showViewController:tuwenViewController sender:nil];
            }
                break;
            case 6:
            {//说说
                NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
                
                if([[userdefault objectForKey:@"member_id"] length] == 0)
                {
                    LoginViewController * loginViewController = [[LoginViewController alloc] init];
                    
                    [self showViewController:loginViewController sender:nil];
                }
                else
                {//都有
                    ShuoshuoViewController * shuoshuoViewController = [[ShuoshuoViewController alloc] init];
                    
                    [self showViewController:shuoshuoViewController sender:nil];
                }
            }
                break;
            case 7:
            {
                NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
                
                if([[userdefault objectForKey:@"member_id"] length] == 0)
                {
                    LoginViewController * loginViewController = [[LoginViewController alloc] init];
                    
                    [self showViewController:loginViewController sender:nil];
                }
                else
                {
                    if([[userdefault objectForKey:@"member_type"] isEqualToString:@"3"])
                    {
                        ShangmengViewController * shangmengViewController = [[ShangmengViewController alloc] init];
                        
                        [self showViewController:shangmengViewController sender:nil];
                    }
                    else
                    {
                        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"只有代理商才有权限进入" preferredStyle:(UIAlertControllerStyleAlert)];
                        
                        [self presentViewController:alert animated:YES completion:^{
                            
                        }];
                        
                        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                            
                        }];
                        
                        [alert addAction:action];
                    }
                }    
            }
                break;
            case 8:
            {//金卡会员
                NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
                
                
                if([[userdefault objectForKey:@"member_type"] isEqualToString:@"1"])
                {
                    JinkahuiyuanViewController * jinkahuiyuanViewController = [[JinkahuiyuanViewController alloc] init];
                    
                    [self showViewController:jinkahuiyuanViewController sender:nil];
                }
                else if([[userdefault objectForKey:@"member_id"] length] == 0)
                {
                    LoginViewController * loginViewController = [[LoginViewController alloc] init];
                    
                    [self showViewController:loginViewController sender:nil];
                }
                else
                {
                    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已经是金卡会员了" preferredStyle:(UIAlertControllerStyleAlert)];
                    
                    [self presentViewController:alert animated:YES completion:^{
                        
                    }];
                    
                    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    
                    [alert addAction:action];
                    
                }

            }
                break;
            case 9:
            {//报名
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
        
        if(self.arr_chanpin.count != 0)
        {
            WebStroe_Model * model = self.arr_chanpin[indexPath.item];
            
            chanpingxiangqingViewController * chanpingxiangqing = [[chanpingxiangqingViewController alloc] init];
            
            
            chanpingxiangqing.production_id = model.production_id;
            
            
            [self showViewController:chanpingxiangqing sender:nil];
        }
//        WebStroe_Model * model = self.arr_chanpin[indexPath.item];
//        
//        chanpingxiangqingViewController * chanpingxiangqing = [[chanpingxiangqingViewController alloc] init];
//        
//        
//        chanpingxiangqing.production_id = model.production_id;
//        
//        
//        [self showViewController:chanpingxiangqing sender:nil];
    }
    else
    {
//        NSLog(@"%ld",(long)indexPath.item);
        
        
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        
        if([[userdefault objectForKey:@"member_id"] length] == 0)
        {
            LoginViewController * loginViewController = [[LoginViewController alloc] init];
            
            [self showViewController:loginViewController sender:nil];
        }
        else
        {
            TuWen_Models * model = self.arr_video[indexPath.item];
            
            VideoDetailViewController * videoDetailViewController = [[VideoDetailViewController alloc] init];
            
            videoDetailViewController.video_id = model.video_id;
            
            [self showViewController:videoDetailViewController sender:nil];
        }
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
    int  item_length = (SCREEN_WIDTH ) / 3.87;
    layout.itemSize = CGSizeMake(item_length + 11, item_length + 40);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.stroe_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.store_detail.frame) , SCREEN_WIDTH, (SCREEN_WIDTH ) / 3.87 + 105 - CGRectGetMaxY(self.store_detail.frame) - 5) collectionViewLayout:layout];
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

#pragma mark - 判断是否登陆
- (void)p_login
{
    //判断是否处于登陆状态
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"login_register:"];
    [dataprovider loginWithMember_username:[userdefault objectForKey:@"account"] member_password:[userdefault objectForKey:@"password"]];
}

#pragma mark - 判断登陆接口
- (void)login_register:(id )dict
{
//    NSLog(@"%@",dict);
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSLog(@"存在用户");
            [userdefault setObject:@"1" forKey:@"Login_Success"];
            
//            NSLog(@"%@",dict[@"data"][@"member_nickname"]);
            //保存用户信息（后期可能更多）
            [userdefault setObject:[NSString stringWithFormat:@"%@",dict[@"data"][@"member_headpic"]] forKey:@"member_headpic"];
            [userdefault setObject:[NSString stringWithFormat:@"%@",dict[@"data"][@"member_id"]] forKey:@"member_id"];
            [userdefault setObject:[NSString stringWithFormat:@"%@",dict[@"data"][@"member_nickname"]] forKey:@"member_nickname"];
            [userdefault setObject:[NSString stringWithFormat:@"%@",dict[@"data"][@"member_type"]] forKey:@"member_type"];
            [userdefault setObject:[NSString stringWithFormat:@"%@",dict[@"data"][@"member_username"]] forKey:@"member_username"];

            
            [userdefault setObject:@"" forKey:@"category_name"];
            [userdefault setObject:@"" forKey:@"category_id"];
            [userdefault setObject:@"" forKey:@"channel_name"];
            [userdefault setObject:@"" forKey:@"TuwenFeilei"];
            [userdefault setObject:@"" forKey:@"city_id"];
            [userdefault setObject:@"" forKey:@"city_name"];
            
            [userdefault setObject:@"" forKey:@"diquweizhi_id"];
            [userdefault setObject:@"" forKey:@"diquweizhi"];
            
//            /纹绣联盟
            [userdefault setObject:@"" forKey:@"diquweizhi_id1"];
            [userdefault setObject:@"" forKey:@"diquweizhi1"];


            [userdefault setObject:@"" forKey:@"diquweizhi_id2"];
            [userdefault setObject:@"" forKey:@"diquweizhi2"];
            //招聘
            [userdefault setObject:@"" forKey:@"zhaopingfei_name"];
            [userdefault setObject:@"" forKey:@"zhaopingfei_id"];
            
            //招聘
            [userdefault setObject:@"" forKey:@"zhaopingxinzi_name"];
            [userdefault setObject:@"" forKey:@"zhaopingxinzi_id"];
            
            
            NSLog(@"%@",[userdefault objectForKey:@"diquweizhi"]);
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {

        }
    }
    else
    {
        NSLog(@"不存在用户");
        [userdefault setObject:@"0" forKey:@"Login_Success"];
        
        [userdefault setObject:@"" forKey:@"diquweizhi_id"];
        [userdefault setObject:@"" forKey:@"diquweizhi"];
        
        //纹绣联盟
        [userdefault setObject:@"" forKey:@"diquweizhi_id1"];
        [userdefault setObject:@"" forKey:@"diquweizhi1"];
        
        [userdefault setObject:@"" forKey:@"diquweizhi_id2"];
        [userdefault setObject:@"" forKey:@"diquweizhi2"];
        
        [userdefault setObject:@"" forKey:@"zhaopingfei_name"];
        [userdefault setObject:@"" forKey:@"zhaopingfei_id"];
        
        //招聘
        [userdefault setObject:@"" forKey:@"zhaopingxinzi_name"];
        [userdefault setObject:@"" forKey:@"zhaopingxinzi_id"];
    }
}

#pragma mark - 轮播图的数据
- (void)p_data2
{
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"Slide_type:"];
    
    [dataprovider getSlidesWithSlide_type:@"1"];
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

//
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




#pragma mark - 下拉刷新
- (void)example01
{
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.header endRefreshing];
    });
    
}

#pragma mark - 产品数据
- (void)p_chanpinliebiao
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getRecommendProducts:"];
    
    if([[userdefault objectForKey:@"city_id"] length] == 0)
    {
        [dataprovider getRecommendProductsWithCity_id:@"183" is_sell:@"1"];
    }
    else
    {
        [dataprovider getRecommendProductsWithCity_id:[userdefault objectForKey:@"city_id"] is_sell:@"1"];

    }
}

//数据
- (void)getRecommendProducts:(id )dict
{
//    NSLog(@"%@",dict);
    
    self.arr_chanpin = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {//[@"productlist"]
            for (NSDictionary * dic in dict[@"data"])
            {
                WebStroe_Model * model = [[WebStroe_Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_chanpin addObject:model];
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
        
    }
}


#pragma mark - 视频的数据
- (void)p_videoData
{
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"GetRecommendVideoList:"];
    
    [dataprovider GetRecommendVideoList];
}

//数据
- (void)GetRecommendVideoList:(id )dict
{
//    NSLog(@"%@",dict);
    
    self.arr_video = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"videolist"])
            {
                TuWen_Models * model = [[TuWen_Models alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_video addObject:model];
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
        
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)arr_lunboData
{
    if(_arr_lunboData == nil)
    {
        self.arr_lunboData = [NSMutableArray array];
    }
    return _arr_lunboData;
}

- (NSMutableArray *)arr_chanpin
{
    if(_arr_chanpin == nil)
    {
        self.arr_chanpin = [NSMutableArray array];
    }
    return _arr_chanpin;
}

- (NSMutableArray *)arr_video
{
    if(_arr_video == nil)
    {
        self.arr_video = [NSMutableArray array];
    }
    return _arr_video;
}


#pragma mark - 定位
- (void)p_location
{
    [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        
        NSLog(@"%lf",locationCorrrdinate.latitude);
        NSLog(@"%lf",locationCorrrdinate.longitude);
        
        DataProvider * dataprovider=[[DataProvider alloc] init];
        [dataprovider setDelegateObject:self setBackFunctionName:@"getCity:"];
        
        [dataprovider getCityWithLng:[NSString stringWithFormat:@"%f",locationCorrrdinate.longitude] lat:[NSString stringWithFormat:@"%f",locationCorrrdinate.latitude]];
    }];
}

#pragma mark - 定位数据
- (void)getCity:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];

            [userdefault setObject:[NSString stringWithFormat:@"%@",dict[@"data"][@"city_id"]] forKey:@"city_id"];
            [userdefault setObject:[NSString stringWithFormat:@"%@",dict[@"data"][@"city_name"]] forKey:@"city_name"];
            
            [self addLeftbuttontitle:dict[@"data"][@"city_name"]];
            
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
//        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] maskType:SVProgressHUDMaskTypeBlack];
        
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        //183
        [userdefault setObject:[NSString stringWithFormat:@""] forKey:@"city_id"];
        [userdefault setObject:[NSString stringWithFormat:@""] forKey:@"city_name"];
        
        _lblLeft.text = @"定位";
    }
}


#pragma mark - 签到
- (void)CreateAutoLoginUrl:(id )dict
{
//    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            CreditWebViewController *web=[[CreditWebViewController alloc]initWithUrl:[NSString stringWithFormat:@"%@",dict[@"data"][@"loginUrl"]]];//实际中需要改为开发者服务器的地址，开发者服务器再重定向到一个带签名的自动登录地址
            [self.navigationController pushViewController:web animated:YES];
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {

        }
    }
    else
    {
        
    }
}



@end

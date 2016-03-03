//
//  BusinessSchoolViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/19.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "BusinessSchoolViewController.h"

#import "JCCollectionViewCell.h"
#import "PicAndVideoCollectionViewCell.h"
#import "JCVideoCollectionViewCell.h"
#import "AppDelegate.h"

#import "TuwenViewController.h"
#import "TextDetailViewController.h"
#import "VideoDetailViewController.h"
#import "Shipintuwen_Models.h"

@interface BusinessSchoolViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView * tableView;

//轮播图
@property (nonatomic, strong) UIScrollView * lunbo_scrollView;
@property (nonatomic, strong) UIPageControl * lunbo_pageControl;
@property (nonatomic, strong) NSTimer * lunbo_timer;
@property (nonatomic, assign) BOOL isplay;

//分类10个
@property (nonatomic, strong) UILabel * classify_detail;
@property (nonatomic, strong) UICollectionView * classify_collectionView;

//视频和图文
@property (nonatomic, strong) UIView * view_video;
@property (nonatomic, strong) UIView * view_pic;

//图文推荐
@property (nonatomic, strong) UILabel * store_detail;
@property (nonatomic, strong) UIButton * stroe_all;
@property (nonatomic, strong) UICollectionView * stroe_collectionView;

//视频列表
@property (nonatomic, strong) UICollectionView * video_collectionView;
@property (nonatomic, strong) UILabel * video_name;

////轮播图
@property (nonatomic, strong) UIImageView * image1;
@property (nonatomic, strong) UIImageView * image2;
@property (nonatomic, strong) UIImageView * image4;

//数据
@property (nonatomic, strong) NSMutableArray * arr_lunboData;

//图片
@property (nonatomic, strong) NSMutableArray * arr_pic;

@end

@implementation BusinessSchoolViewController

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
    _lblTitle.text = @"商学院";
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
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self p_dataPic];
        
        [self p_data2];
        //        self.isplay = 0;
        [weakSelf.tableView reloadData];
        [weakSelf loadNewData];
    }];
}

#pragma mark - tableView的代理方法
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 200;
            break;
        case 1:
            return 150;
            break;
        case 2:
            return 100;
            break;
        case 3:
            return (SCREEN_WIDTH ) / 4 + 105;
            break;
        case 4:
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
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    
    switch (indexPath.row) {
        case 0:
        {
            cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            [self p_lunbotu];
            
            [cell addSubview:self.lunbo_scrollView];
            
            [cell addSubview:self.lunbo_pageControl];
        }
            break;
        case 1:
        {
            cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIView * view_white = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 140)];
            view_white.backgroundColor = [UIColor whiteColor];
            
            [self p_classify];
            
            [view_white addSubview:self.classify_detail];
            [view_white addSubview:self.classify_collectionView];
            
            [cell addSubview:view_white];
        }
            break;
        case 2:
        {
            cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIView * view_top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
            view_top.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            [self p_videoAndPic];
            
            [cell addSubview:view_top];
            [cell addSubview:self.view_video];
            [cell addSubview:self.view_pic];
            
            UIButton * video_btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
            video_btn.frame = self.view_video.frame;
            [cell addSubview:video_btn];
            [video_btn addTarget:self action:@selector(video_btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            
            UIButton * pic_btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
            pic_btn.frame = self.view_pic.frame;
            [cell addSubview:pic_btn];
            [pic_btn addTarget:self action:@selector(pic_btn1Action:) forControlEvents:(UIControlEventTouchUpInside)];
        }
            break;
        case 3:
        {
            cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH ) / 4 + 105);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            [self p_stroe];
            
            [cell addSubview:self.store_detail];
            [cell addSubview:self.stroe_all];
            
            [cell addSubview:self.stroe_collectionView];
        }
            break;
        case 4:
        {
            cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 4 * (SCREEN_WIDTH / 4) + 100);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            [self p_videoList];
            
            [cell addSubview:self.video_name];
            [cell addSubview:self.video_collectionView];
        }
            break;
        default:
            break;
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


#pragma mark - 分类10个
- (void)p_classify
{
    self.classify_detail = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 200, 25)];
    self.classify_detail.text = @"视频图文分类";
    self.classify_detail.textColor = [UIColor grayColor];
    self.classify_detail.font = [UIFont systemFontOfSize:15];
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //每个item的大小
    int  item_length = (SCREEN_WIDTH - 20) / 6;
    layout.itemSize = CGSizeMake(item_length, item_length + 20);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.classify_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.classify_detail.frame) + 5, SCREEN_WIDTH, 105) collectionViewLayout:layout];
    self.classify_collectionView.delegate = self;
    self.classify_collectionView.dataSource = self;
    
    self.classify_collectionView.backgroundColor = [UIColor whiteColor];
    self.classify_collectionView.showsHorizontalScrollIndicator = NO;
    
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
        
        if(self.arr_pic.count != 0)
        {
            Shipintuwen_Models * model = self.arr_pic[indexPath.item];
            
            cell.name.text=[[NSString stringWithFormat:@"%@",model.channel_name] isEqual:@"<null>"]?@"":[NSString stringWithFormat:@"%@",model.channel_name];
            
            NSString * str =  [NSString stringWithFormat:@"%@appbackend/uploads/channel/%@",Url,model.channel_image];
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str]placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
        }
        else
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.name.text = @"美业";
                    cell.imageView.image = [UIImage imageNamed:@"placeholder_short.jpg"];
                }
                    break;
                case 1:
                {
                    cell.name.text = @"美发";
                    cell.imageView.image = [UIImage imageNamed:@"placeholder_short.jpg"];
                }
                    break;
                case 2:
                {
                    cell.name.text = @"美容";
                    cell.imageView.image = [UIImage imageNamed:@"placeholder_short.jpg"];
                }
                    break;
                case 3:
                {
                    cell.name.text = @"纹绣";
                    cell.imageView.image = [UIImage imageNamed:@"placeholder_short.jpg"];
                }
                    break;
                case 4:
                {
                    cell.name.text = @"纹身";
                    cell.imageView.image = [UIImage imageNamed:@"placeholder_short.jpg"];
                }
                    break;
                case 5:
                {
                    cell.name.text = @"足浴";
                    cell.imageView.image = [UIImage imageNamed:@"placeholder_short.jpg"];
                }
                    break;
                case 6:
                {
                    cell.name.text = @"化妆";
                    cell.imageView.image = [UIImage imageNamed:@"placeholder_short.jpg"];
                }
                    break;
                case 7:
                {
                    cell.name.text = @"美甲";
                    cell.imageView.image = [UIImage imageNamed:@"placeholder_short.jpg"];
                }
                    break;
                case 8:
                {
                    cell.name.text = @"扎发";
                    cell.imageView.image = [UIImage imageNamed:@"placeholder_short.jpg"];
                }
                    break;
                case 9:
                {
                    cell.name.text = @"更多";
                    cell.imageView.image = [UIImage imageNamed:@"placeholder_short.jpg"];
                }
                    break;
                default:
                    break;
            }

        }
        
        return cell;
    }
    else if([collectionView isEqual:self.stroe_collectionView])
    {
        PicAndVideoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_store" forIndexPath:indexPath];
        
        [cell.image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
        
        return cell;
    }
    else
    {
        JCVideoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_video" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [cell.image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
        
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
            {
                //    NSLog(@"视频页");
                TuwenViewController * tuwenViewController = [[TuwenViewController alloc] init];
                tuwenViewController.isTeacher = 0;
                
                [self showViewController:tuwenViewController sender:nil];
                
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                
            }
                break;
            case 3:
            {
                
            }
                break;
            case 4:
            {
                
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
                
            }
                break;
            case 8:
            {
                
            }
                break;
            case 9:
            {
                
            }
                break;
            default:
                break;
        }
    }
    else if ([collectionView isEqual:self.stroe_collectionView])
    {
        NSLog(@"%ld",(long)indexPath.item);
        
        TextDetailViewController * textDetailViewController = [[TextDetailViewController alloc] init];
        
        [self showViewController:textDetailViewController sender:nil];
    }
    else
    {
        NSLog(@"%ld",(long)indexPath.item);
        
        VideoDetailViewController * videoDetailViewController = [[VideoDetailViewController alloc] init];
        
        [self showViewController:videoDetailViewController sender:nil];
    }
}

#pragma mark - 视频和图文
- (void)p_videoAndPic
{
    CGFloat length_x = (SCREEN_WIDTH - 15) / 2;
    self.view_video = [[UIView alloc] initWithFrame:CGRectMake(5, 15 + 3, length_x, 77)];
    self.view_video.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel * video_text = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 25)];
    video_text.text = @"视频";
//    video_text.backgroundColor = [UIColor orangeColor];
    video_text.textColor = navi_bar_bg_color;
    [self.view_video addSubview:video_text];
    
    UILabel * video_detail = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(video_text.frame) + 5, 80, 25)];
    video_detail.text = @"视频推荐说明";
    video_detail.font = [UIFont systemFontOfSize:13];
//    video_detail.backgroundColor = [UIColor orangeColor];
    [self.view_video addSubview:video_detail];
    
    UIImageView * video_image = [[UIImageView alloc] initWithFrame:CGRectMake(length_x - 60, 11, 55, 55)];
    video_image.layer.cornerRadius = 55 / 2;
    video_image.layer.masksToBounds = YES;
    video_image.backgroundColor = [UIColor orangeColor];
    video_image.image = [UIImage imageNamed:@""];
    [self.view_video addSubview:video_image];
    

    self.view_pic = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view_video.frame) + 5, 15 + 3, length_x, 77)];
    self.view_pic.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel * pic_text = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 25)];
    pic_text.text = @"图文";
    //    pic_text.backgroundColor = [UIColor orangeColor];
    pic_text.textColor = navi_bar_bg_color;
    [self.view_pic addSubview:pic_text];
    
    UILabel * pic_detail = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(pic_text.frame) + 5, 80, 25)];
    pic_detail.text = @"图文推荐说明";
    pic_detail.font = [UIFont systemFontOfSize:13];
    //    pic_detail.backgroundColor = [UIColor orangeColor];
    [self.view_pic addSubview:pic_detail];
    
    UIImageView * pic_image = [[UIImageView alloc] initWithFrame:CGRectMake(length_x - 60, 11, 55, 55)];
    pic_image.layer.cornerRadius = 55 / 2;
    pic_image.layer.masksToBounds = YES;
    pic_image.backgroundColor = [UIColor orangeColor];
    pic_image.image = [UIImage imageNamed:@""];
    [self.view_pic addSubview:pic_image];
    
}

#pragma mark - btn (图文和视频的)
- (void)video_btnAction:(UIButton *)sender
{
//    NSLog(@"视频页");
    TuwenViewController * tuwenViewController = [[TuwenViewController alloc] init];
    tuwenViewController.isTeacher = 0;

    [self showViewController:tuwenViewController sender:nil];
}

- (void)pic_btn1Action:(UIButton *)sender
{
//    NSLog(@"图文页");
    TuwenViewController * tuwenViewController = [[TuwenViewController alloc] init];
    tuwenViewController.isTeacher = 1;
    
    [self showViewController:tuwenViewController sender:nil];
}

#pragma mark - 商品推荐
- (void)p_stroe
{
    self.store_detail = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 120, 27)];
    self.store_detail.text = @"精选图文推荐";
    
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
    
    [self.stroe_collectionView registerClass:[PicAndVideoCollectionViewCell class] forCellWithReuseIdentifier:@"cell_store"];
}

//所有的商品推荐
- (void)store_detailAction:(UIButton *)sender
{
//    NSLog(@"所有的精选图文推荐");
    TuwenViewController * tuwenViewController = [[TuwenViewController alloc] init];
    tuwenViewController.isTeacher = 1;
    
    [self showViewController:tuwenViewController sender:nil];
}


#pragma mark - 下面的视频列表
- (void )p_videoList
{
    self.video_name = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 200, 27)];
    self.video_name.text = @"人气视频";
    
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

#pragma mark - 轮播图的数据
- (void)p_data2
{
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"Slide_type:"];
    
    [dataprovider getSlidesWithSlide_type:@"3"];
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
        
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@appbackend/uploads/slide/%@",Url,self.arr_lunboData[i - 1]]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
        
        [self.lunbo_scrollView addSubview:image];
    }
    
    self.image1 = [[UIImageView alloc] init];
    self.image1.frame = CGRectMake(SCREEN_WIDTH * 0 , 0 , SCREEN_WIDTH, 200);
    [self.image1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@appbackend/uploads/slide/%@",Url,self.arr_lunboData[self.arr_lunboData.count - 1]]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
    [self.lunbo_scrollView addSubview:self.image1];
    
    self.image2 = [[UIImageView alloc] init];
    self.image2.frame = CGRectMake(SCREEN_WIDTH * (self.arr_lunboData.count + 1), 0 , SCREEN_WIDTH, 200);
    [self.image2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@appbackend/uploads/slide/%@",Url,self.arr_lunboData[0]]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
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

#pragma mark - 获取所有分类
- (void)p_dataPic
{
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getChannels:"];
    
    [dataprovider getChannels];
}

- (void)getChannels:(id )dict
{
//    NSLog(@"%@",dict);
    
    self.arr_pic = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSArray * arr = dict[@"data"][@"channellist"];
            
            for (NSDictionary * dic in arr.firstObject)
            {
                Shipintuwen_Models * model = [[Shipintuwen_Models alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_pic addObject:model];
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
- (NSMutableArray *)arr_lunboData
{
    if(_arr_lunboData == nil)
    {
        self.arr_lunboData = [NSMutableArray array];
    }
    return _arr_lunboData;
}

- (NSMutableArray *)arr_pic
{
    if(_arr_pic == nil)
    {
        self.arr_pic = [NSMutableArray array];
    }
    
    return _arr_pic;
}

@end

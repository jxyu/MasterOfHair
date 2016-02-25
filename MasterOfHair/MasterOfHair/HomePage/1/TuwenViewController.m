//
//  TuwenViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/31.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "TuwenViewController.h"

#import "JCVideoCollectionViewCell.h"
#import "VCollectionReusableView.h"

#import "ShipintuwenfenleiViewController.h"
#import "SearchVideoTextViewController.h"
#import "PicAndVideoCollectionViewCell.h"
#import "TCollectionReusableView.h"
#import "TextDetailViewController.h"
#import "VideoDetailViewController.h"
#import "TuWen_Models.h"
#import "SearchTextViewController.h"
@interface TuwenViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//上面的btn
@property (nonatomic, strong) UIView * top_white;
@property (nonatomic, strong) UIButton * top_btnPeople;
@property (nonatomic, strong) UIButton * top_btnFactory;
@property (nonatomic, strong) UIView * top_viewPeople;
@property (nonatomic, strong) UIView * top_viewFactory;

@property (nonatomic, strong) UICollectionView * video_collectionView;

//
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger page1;

//数据
@property (nonatomic, strong) NSMutableArray * arr_tuwen;

@property (nonatomic, strong) NSMutableArray * arr_shipin;

@property (nonatomic, copy) NSString * str_type;


@end

@implementation TuwenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.str_type = @"";
    
    [self p_navi];
    
    [self p_topView];
    
    [self p_setupView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navi
- (void)p_navi
{
    _lblTitle.text = [NSString stringWithFormat:@"商学院"];
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
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
    [self example01];

    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    if(self.isTeacher == 0)
    {
        //变颜色
        [self.top_btnFactory setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
        self.top_viewFactory.hidden = NO;
        
        [self.top_btnPeople setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        self.top_viewPeople.hidden = YES;
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        //每个item的大小
        int  item_length = (SCREEN_WIDTH ) / 3;
        layout.itemSize = CGSizeMake(item_length / 3 * 4.13, item_length / 4 * 3);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        [layout setHeaderReferenceSize:CGSizeMake(SCREEN_WIDTH, 35)];
        self.video_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.top_white.frame) + 5, SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.top_white.frame) - 5) collectionViewLayout:layout];
        self.video_collectionView.delegate = self;
        self.video_collectionView.dataSource = self;
        self.video_collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        
        [self.view addSubview:self.video_collectionView];
        [self.video_collectionView registerClass:[JCVideoCollectionViewCell class] forCellWithReuseIdentifier:@"cell_video"];
        
        [self.video_collectionView registerClass:[VCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cell_videoCollectionReusableView"];

    }
    else
    {
        //变颜色
        [self.top_btnFactory setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        self.top_viewFactory.hidden = YES;
        
        [self.top_btnPeople setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
        self.top_viewPeople.hidden = NO;
        
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        //每个item的大小
        int  item_length = (SCREEN_WIDTH ) / 4;
        layout.itemSize = CGSizeMake(item_length + 11, item_length + 40);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        [layout setHeaderReferenceSize:CGSizeMake(SCREEN_WIDTH, 35)];

        self.video_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.top_white.frame) + 5, SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.top_white.frame) - 5) collectionViewLayout:layout];
        self.video_collectionView.delegate = self;
        self.video_collectionView.dataSource = self;
        self.video_collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self.view addSubview:self.video_collectionView];
        //注册
        [self.video_collectionView registerClass:[PicAndVideoCollectionViewCell class] forCellWithReuseIdentifier:@"cell_text"];
        
        [self.video_collectionView registerClass:[TCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cell_TCollectionReusableView"];
    }
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.video_collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self p_dataTuwen];
        
        [self p_shipinData:self.str_type];
        
        [weakSelf.video_collectionView reloadData];
        
        [weakSelf loadNewData];
        
    }];
    
    self.video_collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self p_NextDataTuWen];
        
        [self p_NextshipinData:self.str_type];
        
        [weakSelf.video_collectionView reloadData];
        
        [weakSelf loadNewData];
    }];

}

#pragma mark - collectionView代理方法
- (NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.isTeacher == 0)
    {
        return self.arr_shipin.count;
    }
    else
    {
        return self.arr_tuwen.count;
    }
}

- (void )collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isTeacher == 0)
    {
        TuWen_Models * model = self.arr_shipin[indexPath.item];
//        NSLog(@"跳视频页 %ld",(long)indexPath.item);
        
        VideoDetailViewController * videoDetailViewController = [[VideoDetailViewController alloc] init];
        
        videoDetailViewController.video_id = model.video_id;
        
        [self showViewController:videoDetailViewController sender:nil];
    }
    else
    {
//        NSLog(@"跳图文页 %ld",(long)indexPath.item);
        
        TextDetailViewController * textDetailViewController = [[TextDetailViewController alloc] init];
        
        
        
        [self showViewController:textDetailViewController sender:nil];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isTeacher == 0)
    {
        TuWen_Models * model = self.arr_shipin[indexPath.item];
        
        JCVideoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_video" forIndexPath:indexPath];
        [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@appbackend/uploads/video/%@",Url,model.video_img]] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];

        cell.name.text = model.video_title;
        if([model.is_free isEqualToString:@"1"])
        {
            cell.isFree.image = [UIImage imageNamed:@"01jskjdksjdksjkdjsk_55"];
        }
        else
        {
            cell.isFree.image = [UIImage imageNamed:@"01weuiwueiwu_48"];
        }
        
        return cell;
    }
    else
    {
        
        TuWen_Models * model = self.arr_tuwen[indexPath.item];
        
        PicAndVideoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_text" forIndexPath:indexPath];
        
        [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@appbackend/uploads/article/%@",Url,model.article_pic]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
        
        cell.detail.text = model.article_title;
        
        return cell;
    }
}

//设置头尾部内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;

    if(self.isTeacher == 0)
    {
        //定制头部视图的内容
        VCollectionReusableView *headerV = (VCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cell_videoCollectionReusableView" forIndexPath:indexPath];
        
        [headerV.type_all addTarget:self action:@selector(type_allAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [headerV.search addTarget:self action:@selector(searchAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [headerV.all addTarget:self action:@selector(allAction:) forControlEvents:(UIControlEventTouchUpInside)];
        headerV.all.tag = 10000;
        [headerV.free addTarget:self action:@selector(freeAction:) forControlEvents:(UIControlEventTouchUpInside)];
        headerV.free.tag = 20000;
        [headerV.vip addTarget:self action:@selector(vipAction:) forControlEvents:(UIControlEventTouchUpInside)];
        headerV.vip.tag = 30000;
        
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        
        if([[userdefault objectForKey:@"channel_name"] length] == 0)
        {
            [headerV.type_all setTitle:@"分类" forState:UIControlStateNormal];
        }
        else
        {
            [headerV.type_all setTitle:[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"channel_name"]] forState:UIControlStateNormal];
        }
        
        
        if([self.str_type isEqualToString:@""])
        {
            [headerV.all setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
            [headerV.free setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
            [headerV.vip setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        }
        else if([self.str_type isEqualToString:@"0"])
        {
            [headerV.all setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
            [headerV.vip setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
            [headerV.free setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
        }
        else
        {
            [headerV.all setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
            [headerV.free setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
            [headerV.vip setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
        }

        reusableView = headerV;
    }
    else
    {
        //定制头部视图的内容
        TCollectionReusableView *headerV = (TCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cell_TCollectionReusableView" forIndexPath:indexPath];
        
        [headerV.type_all addTarget:self action:@selector(type_allAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [headerV.search addTarget:self action:@selector(searchAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        
        if([[userdefault objectForKey:@"channel_name"] length] == 0)
        {
            [headerV.type_all setTitle:@"分类" forState:UIControlStateNormal];
        }
        else
        {
            [headerV.type_all setTitle:[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"channel_name"]] forState:UIControlStateNormal];
        }
        
        reusableView = headerV;
    }

    return reusableView;
}
//设置头尾的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.frame.size.width, 35);
}

#pragma mark - btn视频的btn
- (void)type_allAction:(UIButton *)sender
{
    ShipintuwenfenleiViewController * fenleiViewController = [[ShipintuwenfenleiViewController alloc] init];
    [self showViewController:fenleiViewController sender:nil];
}


- (void)searchAction:(UIButton *)sender
{
    if(self.isTeacher == 0)
    {
        SearchVideoTextViewController * searchViewController = [[SearchVideoTextViewController alloc] init];
        [self showViewController:searchViewController sender:nil];
    }
    else
    {
        SearchTextViewController * searchTextViewController = [[SearchTextViewController alloc] init];
        
        [self showViewController:searchTextViewController sender:nil];
    }
}

- (void)allAction:(UIButton *)sender
{
    self.str_type = @"";

    //刷新
    [self example01];
}

- (void)freeAction:(UIButton *)sender
{
    self.str_type = @"0";
    
    [self example01];
}

- (void)vipAction:(UIButton *)sender
{
    self.str_type = @"1";
    //刷新
    [self example01];
}

#pragma mark - btn 视频 图文

- (void)p_topView
{
    self.top_white = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50)];
    self.top_white.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.top_white];
    
    int length_x = SCREEN_WIDTH / 2;
    
    //合作店
    self.top_btnFactory = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.top_btnFactory.frame = CGRectMake(0, 0, length_x, 50);
    [self.top_btnFactory setTitle:@"视频" forState:(UIControlStateNormal)];
    [self.top_btnFactory setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    self.top_btnFactory.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.top_white addSubview:self.top_btnFactory];
    
    [self.top_btnFactory addTarget:self action:@selector(top_btnFactoryAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.top_viewFactory = [[UIView alloc] initWithFrame:CGRectMake(length_x / 2 - 40, 48, 80, 2)];
    self.top_viewFactory.backgroundColor = navi_bar_bg_color;
    [self.top_white addSubview:self.top_viewFactory];
    
    
    //纹绣师
    self.top_btnPeople = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.top_btnPeople.frame = CGRectMake(length_x, 0, length_x, 50);
    [self.top_btnPeople setTitle:@"图文" forState:(UIControlStateNormal)];
    [self.top_btnPeople setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.top_btnPeople.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.top_white addSubview:self.top_btnPeople];
    
    [self.top_btnPeople addTarget:self action:@selector(top_btnPeopleAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.top_viewPeople = [[UIView alloc] initWithFrame:CGRectMake(length_x +  length_x / 2 - 40, 48, 80, 2)];
    self.top_viewPeople.backgroundColor = navi_bar_bg_color;
    [self.top_white addSubview:self.top_viewPeople];
    self.top_viewPeople.hidden = YES;
}

#pragma mark - 合作店 和 纹绣师的btn
//合作店的btn
- (void)top_btnFactoryAction:(UIButton *)sender
{
    self.isTeacher = NO;
    
    [self p_video];
}

//纹绣师的btn
- (void)top_btnPeopleAction:(UIButton *)sender
{
    self.isTeacher = YES;
    
    [self p_text];
}

#pragma mark - 下拉刷新
- (void)example01
{
    // 马上进入刷新状态
    [self.video_collectionView.header beginRefreshing];
}

-(void)example02
{
    
    [self.video_collectionView.footer beginRefreshing];
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.video_collectionView.header endRefreshing];
        [self.video_collectionView.footer endRefreshing];
    });
    
}

#pragma mark - 视频 和 图文的布局

- (void)p_video
{
    //变颜色
    [self.top_btnFactory setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    self.top_viewFactory.hidden = NO;
    
    [self.top_btnPeople setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.top_viewPeople.hidden = YES;
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //每个item的大小
    int  item_length = (SCREEN_WIDTH ) / 3;
    layout.itemSize = CGSizeMake(item_length / 3 * 4.13, item_length / 4 * 3);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [layout setHeaderReferenceSize:CGSizeMake(SCREEN_WIDTH, 35)];
    self.video_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.top_white.frame) + 5, SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.top_white.frame) - 5) collectionViewLayout:layout];
    self.video_collectionView.delegate = self;
    self.video_collectionView.dataSource = self;
    self.video_collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.video_collectionView];
    
    [self.view addSubview:self.video_collectionView];
    [self.video_collectionView registerClass:[JCVideoCollectionViewCell class] forCellWithReuseIdentifier:@"cell_video"];
    
    [self.video_collectionView registerClass:[VCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cell_videoCollectionReusableView"];
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.video_collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self p_shipinData:self.str_type];
        
        [weakSelf.video_collectionView reloadData];
        
        [weakSelf loadNewData];
        
    }];
    
    self.video_collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self p_NextshipinData:self.str_type];
        
        [weakSelf.video_collectionView reloadData];
        
        [weakSelf loadNewData];
    }];

    [self example01];
}

- (void)p_text
{
    //变颜色
    [self.top_btnFactory setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.top_viewFactory.hidden = YES;
    
    [self.top_btnPeople setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    self.top_viewPeople.hidden = NO;
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //每个item的大小
    int  item_length = (SCREEN_WIDTH ) / 4;
    layout.itemSize = CGSizeMake(item_length + 11, item_length + 40);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [layout setHeaderReferenceSize:CGSizeMake(SCREEN_WIDTH, 35)];
    
    self.video_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.top_white.frame) + 5, SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.top_white.frame) - 5) collectionViewLayout:layout];
    self.video_collectionView.delegate = self;
    self.video_collectionView.dataSource = self;
    self.video_collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.video_collectionView];
    //注册
    [self.video_collectionView registerClass:[PicAndVideoCollectionViewCell class] forCellWithReuseIdentifier:@"cell_text"];
    
    [self.video_collectionView registerClass:[TCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cell_TCollectionReusableView"];
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.video_collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self p_dataTuwen];
        
        [weakSelf.video_collectionView reloadData];
        
        [weakSelf loadNewData];
        
    }];
    
    self.video_collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self p_NextDataTuWen];
        
        [weakSelf.video_collectionView reloadData];
        
        [weakSelf loadNewData];
    }];
    
    [self example01];

}

#pragma mark - 图文数据
- (void)p_dataTuwen
{
    self.page = 1;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getArticleList:"];
    
    [dataprovider getArticleListWithChannel_id:@"6" status_code:@"1" pagenumber:@"1" pagesize:@"12"];
}

- (void)p_NextDataTuWen
{
    self.page ++;
//    NSLog(@"%ld",self.page);
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getArticleList1:"];
    
    [dataprovider getArticleListWithChannel_id:@"6" status_code:@"1" pagenumber:[NSString stringWithFormat:@"%ld",self.page] pagesize:@"12"];
}

- (void)getArticleList:(id )dict
{
//    NSLog(@"%@",dict);
    
    self.arr_tuwen = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"articlelist"])
            {
                TuWen_Models * model = [[TuWen_Models alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_tuwen addObject:model];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新tableView(记住,要更新放在主线程中)
                [self.video_collectionView reloadData];
            });
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] maskType:SVProgressHUDMaskTypeBlack];
    }
}

- (void)getArticleList1:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"articlelist"])
            {
                TuWen_Models * model = [[TuWen_Models alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_tuwen addObject:model];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新tableView(记住,要更新放在主线程中)
                [self.video_collectionView reloadData];
            });
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] maskType:SVProgressHUDMaskTypeBlack];
    }
}


#pragma mark - 视频的数据
- (void)p_shipinData:(NSString * )is_free
{
    self.page1 = 1;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getArticleListshiping:"];
    
    [dataprovider getArticleListWithVideo_type:@"3" is_free:is_free pagenumber:@"1" pagesize:@"10"];
}

- (void)p_NextshipinData:(NSString * )is_free
{
    self.page1 ++ ;
    NSLog(@"%ld",self.page);
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getArticleListshiping1:"];
    
    [dataprovider getArticleListWithVideo_type:@"3" is_free:is_free pagenumber:[NSString stringWithFormat:@"%ld",self.page1] pagesize:@"10"];
}

- (void)getArticleListshiping:(id )dict
{
//    NSLog(@"%@",dict);
    
    self.arr_shipin = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"videolist"])
            {
                TuWen_Models * model = [[TuWen_Models alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_shipin addObject:model];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新tableView(记住,要更新放在主线程中)
                [self.video_collectionView reloadData];
            });
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] maskType:SVProgressHUDMaskTypeBlack];
    }
}

- (void)getArticleListshiping1:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"videolist"])
            {
                TuWen_Models * model = [[TuWen_Models alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_shipin addObject:model];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新tableView(记住,要更新放在主线程中)
                [self.video_collectionView reloadData];
            });
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] maskType:SVProgressHUDMaskTypeBlack];
    }
}


#pragma mark - 懒加载
- (NSMutableArray *)arr_tuwen
{
    if(_arr_tuwen == nil)
    {
        self.arr_tuwen = [NSMutableArray array];
    }
    
    return _arr_tuwen;
}

- (NSMutableArray *)arr_shipin
{
    if(_arr_shipin == nil)
    {
        self.arr_shipin = [NSMutableArray array];
    }
    
    return _arr_shipin;
}

@end

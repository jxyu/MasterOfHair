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


#import "FenleiViewController.h"
#import "SearchViewController.h"
#import "PicAndVideoCollectionViewCell.h"
@interface TuwenViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//上面的btn
@property (nonatomic, strong) UIView * top_white;
@property (nonatomic, strong) UIButton * top_btnPeople;
@property (nonatomic, strong) UIButton * top_btnFactory;
@property (nonatomic, strong) UIView * top_viewPeople;
@property (nonatomic, strong) UIView * top_viewFactory;

@property (nonatomic, strong) UICollectionView * video_collectionView;


@property (nonatomic, strong) UICollectionView * stroe_collectionView;

@end

@implementation TuwenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
        
        [self.video_collectionView registerClass:[VCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cell_videoCollectionReusableView"];
    }
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.video_collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf.video_collectionView reloadData];
        
        [weakSelf loadNewData];
        
    }];
    
    self.video_collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
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
        return 11;
    }
    else
    {
        return 15;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isTeacher == 0)
    {
        JCVideoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_video" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor orangeColor];
        
        return cell;
    }
    else
    {
        PicAndVideoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_text" forIndexPath:indexPath];
        
        return cell;
    }
}

//设置头尾部内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;

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
    reusableView = headerV;

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
    FenleiViewController * fenleiViewController = [[FenleiViewController alloc] init];
    [self showViewController:fenleiViewController sender:nil];
}

- (void)searchAction:(UIButton *)sender
{
    SearchViewController * searchViewController = [[SearchViewController alloc] init];
    [self showViewController:searchViewController sender:nil];
}

- (void)allAction:(UIButton *)sender
{
    [sender setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    
    UIButton * btn1 = [self.view viewWithTag:20000];
    [btn1 setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    UIButton * btn2 = [self.view viewWithTag:30000];
    [btn2 setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    //刷新
    [self example01];
}

- (void)freeAction:(UIButton *)sender
{
    [sender setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    
    UIButton * btn1 = [self.view viewWithTag:10000];
    [btn1 setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    UIButton * btn2 = [self.view viewWithTag:30000];
    [btn2 setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    //刷新
    [self example01];
}

- (void)vipAction:(UIButton *)sender
{
    [sender setTitleColor:navi_bar_bg_color forState:(UIControlStateNormal)];
    
    UIButton * btn1 = [self.view viewWithTag:20000];
    [btn1 setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    UIButton * btn2 = [self.view viewWithTag:10000];
    [btn2 setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
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
        
        [weakSelf.video_collectionView reloadData];
        
        [weakSelf loadNewData];
        
    }];
    
    self.video_collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
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
    
    [self.video_collectionView registerClass:[VCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cell_videoCollectionReusableView"];
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.video_collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf.video_collectionView reloadData];
        
        [weakSelf loadNewData];
        
    }];
    
    self.video_collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf.video_collectionView reloadData];
        
        [weakSelf loadNewData];
    }];
    
    [self example01];

}





@end

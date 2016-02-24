//
//  chanpingxiangqingViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/25.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "chanpingxiangqingViewController.h"
#import "AppDelegate.h"


#import "VOTagList.h"
#import "querendingdanViewController.h"
#import "Chanpingxiangqing_Models.h"
@interface chanpingxiangqingViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

//第一行 轮播图
@property (nonatomic, strong) UIScrollView * lunbo_scrollView;
@property (nonatomic, strong) UIPageControl * lunbo_pageControl;
@property (nonatomic, strong) NSTimer * lunbo_timer;
@property (nonatomic, assign) BOOL isplay;


//第二行 产品 
@property (nonatomic, strong) UILabel * name;
@property (nonatomic, strong) UILabel * price;
@property (nonatomic, strong) UIButton * btn_share;
@property (nonatomic, strong) UILabel * old_price;

//规格
@property (nonatomic, strong) VOTagList * tagList;

//底部栏
@property (nonatomic, strong) UIButton * btn_collect;
@property (nonatomic, strong) UIButton * btn_addShopping;
@property (nonatomic, strong) UIButton * btn_buy;


////轮播图
@property (nonatomic, strong) UIImageView * image1;
@property (nonatomic, strong) UIImageView * image2;
@property (nonatomic, strong) UIImageView * image4;

//数据
@property (nonatomic, strong) NSMutableArray * arr_pic;
@property (nonatomic, strong) NSMutableArray * arr_guige;
//规格列表
@property (nonatomic, strong) NSMutableArray * arr_list;


@property (nonatomic, copy) NSString * shop_name;



@end

@implementation chanpingxiangqingViewController

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
    _lblTitle.text = [NSString stringWithFormat:@"产品详情"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    
    [self addRightButton:@"01shoppingCar_03"];
    _imgRight.frame = CGRectMake(SCREEN_WIDTH - 20 - 40, _imgRight.frame.origin.y, _imgRight.frame.size.width, _imgRight.frame.size.height);
    //    [self addRightbuttontitle:@"签到"];
}

//返回
- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

- (void)clickRightButton:(UIButton *)sender
{
    NSLog(@"跳到购物车");
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] selectTableBarIndex:3];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:(UITableViewStylePlain)];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self p_bottomView];
    
    //加数据
    [self p_data];
}

#pragma mark - tableView
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
        return SCREEN_WIDTH + 10;
    }
    else if(indexPath.row == 1)
    {
        return 95;
    }
    else if (indexPath.row == 2)
    {
        if(self.arr_list.count < 3)
        {
            return 95;
        }
        else
        {
            return 150;
        }
    }
    return SCREEN_HEIGHT / 3 * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    
    if (indexPath.row == 0)
    {
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH + 10);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self p_lunbotu];
        
        [cell addSubview:self.lunbo_scrollView];
        
        [cell addSubview:self.lunbo_pageControl];
    }
    else if(indexPath.row == 1)
    {
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 20, 20)];
        image.image = [UIImage imageNamed:@"01dian_07"];
//        image.backgroundColor = [UIColor orangeColor];
        [cell addSubview:image];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame) + 10, 6, 100, 20)];
        label.text = @"商铺名称";
        label.font = [UIFont systemFontOfSize:15];
        [cell addSubview:label];
        
        UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame) + 5, SCREEN_WIDTH, 1)];
        view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [cell addSubview:view_line];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(15, 35 + 5, SCREEN_WIDTH - 60, 25)];
        self.name.font = [UIFont systemFontOfSize:14];
        [cell addSubview:self.name];
        
        if([self.shop_name length] == 0)
        {
            self.name.text = @"店铺名称，店铺名称";
        }
        else
        {
            self.name.text = self.shop_name;
        }
        
        Chanpingxiangqing_Models * model = self.arr_guige.firstObject;
        
        self.price = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.name.frame) + 3, 70, 25)];
        self.price.textColor = [UIColor orangeColor];
//        self.price.text = @"¥ 100.00";
        self.price.font = [UIFont systemFontOfSize:16];
        [cell addSubview:self.price];
        
        if([model.sell_price length] == 0)
        {
            self.price.text = @"";
        }
        else
        {
            self.price.text = [NSString stringWithFormat:@"¥ %@",model.sell_price];
        }
        
        
        self.old_price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.price.frame) + 5, CGRectGetMinY(self.price.frame) + 3, 70, 20)];
        self.old_price.text = @"¥ 1000.00";
        self.old_price.font = [UIFont systemFontOfSize:11];
        [cell addSubview:self.old_price];
        
        UIView * view_line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 50, 1)];
        view_line1.backgroundColor = [UIColor grayColor];
        [self.old_price addSubview:view_line1];
        
        if([model.net_price length] == 0)
        {
            self.old_price.text = @"";
            view_line1.hidden = YES;
        }
        else
        {
            view_line1.hidden = NO;
            self.old_price.text = [NSString stringWithFormat:@"¥ %@",model.net_price];
        }
        
        
        self.btn_share = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btn_share.frame = CGRectMake(SCREEN_WIDTH - 50, 35 + 10, 40, 40);
//        self.btn_share.backgroundColor = [UIColor orangeColor];
        [self.btn_share setImage:[UIImage imageNamed:@"01share_21"] forState:(UIControlStateNormal)];
        [self.btn_share setTintColor:[UIColor grayColor]];
        [cell addSubview:self.btn_share];
        
        [self.btn_share addTarget:self action:@selector(shareAction:) forControlEvents:(UIControlEventTouchUpInside)];
            
        //添加tag值
    }
    else if (indexPath.row == 2)
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [cell addSubview:view_line];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 100, 20)];
        label.text = @"选择规格";
        label.font = [UIFont systemFontOfSize:15];
        [cell addSubview:label];
        
        UIView * view_line1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame) + 10, SCREEN_WIDTH, 1)];
        view_line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [cell addSubview:view_line1];
        
        //使用第三方
        
        NSArray *tags = self.arr_list;
//        NSLog(@"%ld",self.arr_list.count);
        self.tagList = [[VOTagList alloc] initWithTags:tags];

        if(self.arr_list.count < 3)
        {
            self.tagList.frame = CGRectMake(20, CGRectGetMaxY(view_line1.frame) + 8, SCREEN_WIDTH - 40, (150 - CGRectGetMaxY(view_line1.frame) - 10) / 2 - 13);
            
//            self.tagList.backgroundColor = [UIColor orangeColor];
        }
        else
        {
            self.tagList.frame = CGRectMake(20, CGRectGetMaxY(view_line1.frame) + 8, SCREEN_WIDTH - 40, 150 - CGRectGetMaxY(view_line1.frame) - 10);

        }
        self.tagList.multiLine = YES;
        self.tagList.multiSelect = NO;
        self.tagList.allowNoSelection = YES;
        self.tagList.vertSpacing = 20;
        self.tagList.horiSpacing = 20;
//        self.tagList.selectedTextColor = [UIColor whiteColor];
        self.tagList.tagBackgroundColor = [UIColor groupTableViewBackgroundColor];
        self.tagList.selectedTagBackgroundColor = [UIColor orangeColor];
        self.tagList.tagCornerRadius = 2;
        self.tagList.tagEdge = UIEdgeInsetsMake(6, 6, 6, 6);
        [self.tagList addTarget:self action:@selector(selectedTagsChanged:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:self.tagList];
    }
    else
    {
//        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [cell addSubview:view_line];

        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 100, 20)];
        label.text = @"产品详情";
        label.font = [UIFont systemFontOfSize:15];
        [cell addSubview:label];
        
        UIView * view_line1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame) + 10, SCREEN_WIDTH, 1)];
        view_line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [cell addSubview:view_line1];
        
        //添加web界面
        UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_line1.frame) + 5, SCREEN_WIDTH, SCREEN_HEIGHT / 3 * 2 - CGRectGetMaxY(view_line1.frame) - 5)];
        
        NSString * path = @"http://www.baidu.com";
        NSURL * url = [NSURL URLWithString:path];
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
        
        [cell addSubview:webView];
        
//        UIScrollView *tempView=(UIScrollView *)[webView.subviews objectAtIndex:0];
//        tempView.scrollEnabled=NO;
    }
    
    return cell;
}

#pragma mark - 点击分享 和规格
- (void)shareAction:(UIButton *)sender
{
    NSLog(@"分享");
}

- (void)selectedTagsChanged: (VOTagList *)tagList{
    
    NSLog(@"selected: %ld", tagList.selectedIndexSet.firstIndex);
    
    Chanpingxiangqing_Models * model = self.arr_guige[tagList.selectedIndexSet.firstIndex];
    
    self.old_price.text = [NSString stringWithFormat:@"¥ %@",model.net_price];
    self.price.text =[NSString stringWithFormat:@"¥ %@",model.sell_price];
}


#pragma mark - 底部栏
- (void)p_bottomView
{
    self.btn_collect = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_collect.frame = CGRectMake(15, SCREEN_HEIGHT - 45 , 40, 40);
//    self.btn_collect.backgroundColor = [UIColor orangeColor];
    [self.btn_collect setImage:[UIImage imageNamed:@"01collect_16"] forState:(UIControlStateNormal)];
    [self.btn_collect setTintColor:[UIColor grayColor]];
    [self.view addSubview:self.btn_collect];
    
    [self.btn_collect addTarget:self action:@selector(btn_collectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    CGFloat length_x = (SCREEN_WIDTH - CGRectGetMaxX(self.btn_collect.frame) - 60) / 2;
    
    self.btn_addShopping = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_addShopping.frame = CGRectMake(CGRectGetMaxX(self.btn_collect.frame) + 20, SCREEN_HEIGHT - 45, length_x, 40);
//    self.btn_addShopping.backgroundColor = [UIColor orangeColor];
    self.btn_addShopping.layer.cornerRadius = 5;
    self.btn_addShopping.layer.borderWidth = 1;
    self.btn_addShopping.layer.borderColor = [UIColor orangeColor].CGColor;
    [self.btn_addShopping setTitle:@"加入购物车" forState:(UIControlStateNormal)];
    [self.btn_addShopping setTintColor:[UIColor orangeColor]];
    self.btn_addShopping.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.btn_addShopping];
    [self.btn_addShopping addTarget:self action:@selector(btn_addShoppingAction:) forControlEvents:(UIControlEventTouchUpInside)];

    
    self.btn_share = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_share.frame = CGRectMake(CGRectGetMaxX(self.btn_addShopping.frame) + 20, SCREEN_HEIGHT - 45, length_x, 40);
    self.btn_share.backgroundColor = [UIColor orangeColor];
    self.btn_share.layer.cornerRadius = 5;
    self.btn_share.layer.borderWidth = 1;
    self.btn_share.layer.borderColor = [UIColor orangeColor].CGColor;
    [self.btn_share setTitle:@"立即购买" forState:(UIControlStateNormal)];
    [self.btn_share setTintColor:[UIColor whiteColor]];
    [self.view addSubview:self.btn_share];
    [self.btn_share addTarget:self action:@selector(btn_shareAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

#pragma mark - 底部的3个按钮的单机事件
//收藏
- (void)btn_collectAction:(UIButton *)sender
{
    NSLog(@"收藏");
}
//购物车
- (void)btn_addShoppingAction:(UIButton *)sender
{
//    NSLog(@"购物车");
    
    if(self.tagList.selectedIndexSet.count == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择规格后再加入购物车" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else
    {
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        Chanpingxiangqing_Models * model = self.arr_guige[self.tagList.selectedIndexSet.firstIndex];
        
        DataProvider * dataprovider=[[DataProvider alloc] init];
        [dataprovider setDelegateObject:self setBackFunctionName:@"create:"];
        
        [dataprovider createWithProduction_id:self.production_id number:@"1" price:model.sell_price member_id:[userdefault objectForKey:@"member_id"] specs_id:model.specs_id];
    }
}
//购买
- (void)btn_shareAction:(UIButton *)sender
{
//    NSLog(@"购买");
    
    if(self.tagList.selectedIndexSet.count == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择规格后再确定下单" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else
    {
        NSLog(@"跳页");
        
        querendingdanViewController * querendingdan = [[querendingdanViewController alloc] init];
        [self showViewController:querendingdan sender:nil];
    }
}

#pragma mark - 轮播图
- (void)p_lunbotu
{
    self.lunbo_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
//      self.lunbo_scrollView.backgroundColor = [UIColor orangeColor];
    self.lunbo_scrollView.pagingEnabled = YES;
    self.lunbo_scrollView.showsHorizontalScrollIndicator = NO;
    self.lunbo_scrollView.delegate = self;
    
    self.lunbo_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * (self.arr_pic.count + 2), 0);
    
    
    if(self.arr_pic.count == 0)
    {
        self.image4.hidden = NO;
        
        self.lunbo_scrollView.scrollEnabled = NO;
        
        self.image4 = [[UIImageView alloc] init];
        self.image4.frame = CGRectMake(SCREEN_WIDTH * 1, 0 , SCREEN_WIDTH, SCREEN_WIDTH);
        [self.image4 sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
        [self.lunbo_scrollView addSubview:self.image4];
        
        
        self.image1 = [[UIImageView alloc] init];
        self.image1.frame = CGRectMake(SCREEN_WIDTH * 0 , 0 , SCREEN_WIDTH, SCREEN_WIDTH);
        [self.image1 sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
        [self.lunbo_scrollView addSubview:self.image1];
    }
    else
    {
        self.lunbo_scrollView.scrollEnabled = YES;
        
        self.image4.hidden = YES;
        
        for (int i = 1; i <= self.arr_pic.count; i++)
        {
            UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
            
            [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@appbackend/uploads/product/%@",Url,self.arr_pic[i - 1]]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
            
            [self.lunbo_scrollView addSubview:image];
        }
        
        self.image1 = [[UIImageView alloc] init];
        self.image1.frame = CGRectMake(SCREEN_WIDTH * 0 , 0 , SCREEN_WIDTH, SCREEN_WIDTH);
        [self.image1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@appbackend/uploads/product/%@",Url,self.arr_pic[self.arr_pic.count - 1]]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
        [self.lunbo_scrollView addSubview:self.image1];
        
        self.image2 = [[UIImageView alloc] init];
        self.image2.frame = CGRectMake(SCREEN_WIDTH * (self.arr_pic.count + 1), 0 , SCREEN_WIDTH, SCREEN_WIDTH);
        [self.image2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@appbackend/uploads/product/%@",Url,self.arr_pic[0]]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
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
    
    //
    self.lunbo_pageControl = [[UIPageControl alloc] init];
    self.lunbo_pageControl.frame = CGRectMake(self.view.frame.size.width / 2 - 50, SCREEN_WIDTH - 20, 100, 18);
    self.lunbo_pageControl.numberOfPages = self.arr_pic.count;
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
    
    if(count < self.arr_pic.count)
    {
        count ++;
        [UIView animateWithDuration:0.7f animations:^{
            
            self.lunbo_scrollView.contentOffset = CGPointMake(count * SCREEN_WIDTH, 0);
            self.lunbo_pageControl.currentPage = count - 1;
            
        }];
    }
    else if(count == self.arr_pic.count)
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
    
    if(count == self.arr_pic.count + 1)
    {
        self.lunbo_scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        self.lunbo_pageControl.currentPage = 0;
    }
    else if(count == 0)
    {
        self.lunbo_scrollView.contentOffset = CGPointMake(self.arr_pic.count * SCREEN_WIDTH, 0);
        self.lunbo_pageControl.currentPage = self.arr_pic.count - 1;
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

#pragma mark - 请求数据
- (void)p_data
{
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getProducts:"];
    [dataprovider getProductsWithProduction_id:self.production_id];
}

#pragma mark - 商城数据
- (void)getProducts:(id )dict
{
//    NSLog(@"%@",dict);
    
    self.arr_pic  = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSArray * arr = dict[@"data"][@"productlist"];
            
            for (NSDictionary * dic in arr.firstObject[@"imglist"])
            {
                [self.arr_pic addObject:dic[@"picture_path"]];
            }
            
            self.shop_name = [NSString stringWithFormat:@"%@",arr.firstObject[@"shop_name"]];
            
            for (NSDictionary * dic in arr.firstObject[@"specslist"])
            {
                Chanpingxiangqing_Models * model = [[Chanpingxiangqing_Models alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_list addObject:dic[@"specs_name"]];
                
                [self.arr_guige addObject:model];
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

#pragma mark  - 加入购物车的接口
- (void)create:(id )dict
{
    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"加入购物城成功" maskType:(SVProgressHUDMaskTypeBlack)];
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
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] maskType:SVProgressHUDMaskTypeBlack];
    }

}

#pragma mark - 懒加载
- (NSMutableArray *)arr_pic
{
    if(_arr_pic == nil)
    {
        self.arr_pic = [NSMutableArray array];
    }
    return _arr_pic;
}

- (NSMutableArray *)arr_guige
{
    if(_arr_guige == nil)
    {
        self.arr_guige = [NSMutableArray array];
    }
    return _arr_guige;
}

- (NSMutableArray *)arr_list
{
    if(_arr_list == nil)
    {
        self.arr_list = [NSMutableArray array];
    }
    return _arr_list;
}


@end

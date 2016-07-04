//
//  ChanpinshoucangViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/2.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "ChanpinshoucangViewController.h"

#import "WebStroeCollectionViewCell.h"
#import "chanpingxiangqingViewController.h"
#import "WebStroe_Model.h"
@interface ChanpinshoucangViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//翻页
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) UICollectionView * stroe_collectionView;

@property (nonatomic, strong) NSMutableArray * arr_data;

//保存要删除的数组
@property (nonatomic, strong) NSMutableArray * arr_delect;

@end

@implementation ChanpinshoucangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SVProgressHUD showWithStatus:@"加载数据中,请稍等..."];
    
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
    _lblTitle.text = [NSString stringWithFormat:@"收藏的产品"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    _lblLeft.text=@"返回";
    _lblLeft.textAlignment=NSTextAlignmentLeft;
    [self addRightbuttontitle:@"编辑"];
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
    
    [self example01];
}

- (void )clickRightButton:(UIButton *)sender
{
//    NSLog(@"编辑");
    
    if([_lblRight.text isEqualToString:@"编辑"])
    {
        _lblRight.text = @"删除";
        
        self.arr_delect = nil;
    }
    else
    {
        
        if(self.arr_delect.count != 0)
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除该收藏产品" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
                for (int i = 0 ; i < self.arr_data.count; i ++)
                {
                    UIImageView * image = [self.view viewWithTag:i + 10];
                    image.hidden = YES;
                    
                    WebStroeCollectionViewCell * cell = [self.view viewWithTag:i + 10000];
                    
                    cell.layer.borderColor = [UIColor whiteColor].CGColor;
                    cell.layer.borderWidth = 1;
                }
                
                _lblRight.text = @"编辑";
                
                [self example01];
            }];
            
            [alert addAction:action];
            
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
                for (int i = 0 ; i < self.arr_data.count; i ++)
                {
                    UIImageView * image = [self.view viewWithTag:i + 10];
                    image.hidden = YES;
                    
                    WebStroeCollectionViewCell * cell = [self.view viewWithTag:i + 10000];
                    
                    cell.layer.borderColor = [UIColor whiteColor].CGColor;
                    cell.layer.borderWidth = 1;
                }
                
                NSMutableString * str = [NSMutableString string];
                
                for (NSString * str_id in self.arr_delect)
                {
                    NSString * s = [NSString stringWithFormat:@"%@,",str_id];
                    
                    [str appendString:s];
                }
                //获取订单列表
                NSInteger x =  [str length];
                NSString * str_data = [str substringToIndex:x - 1];
                
                NSLog(@"%@",str_data);
                
                DataProvider * dataprovider=[[DataProvider alloc] init];
                [dataprovider setDelegateObject:self setBackFunctionName:@"ProductionFavorite:"];
                
                [dataprovider ProductionFavoriteWithFavorite_id:str_data];
                
            }];
            
            [alert addAction:action1];

        }
        else
        {
            _lblRight.text = @"编辑";
            
            [self example01];
        }
    }
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //每个item的大小
    int  item_length = (SCREEN_WIDTH ) / 4;
    layout.itemSize = CGSizeMake(item_length + 11, item_length + 40);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.stroe_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:layout];
    self.stroe_collectionView.delegate = self;
    self.stroe_collectionView.dataSource = self;
    self.stroe_collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.stroe_collectionView];
    
    //注册
    [self.stroe_collectionView registerClass:[WebStroeCollectionViewCell class] forCellWithReuseIdentifier:@"cell_store"];
    
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.stroe_collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self p_dataCollect];
        
        [weakSelf.stroe_collectionView reloadData];
        [weakSelf loadNewData];
    }];
    
//    self.stroe_collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        
//        [self p_dataCollect1];
//        
//        [weakSelf.stroe_collectionView reloadData];
//        [weakSelf loadNewData];
//    }];
}

#pragma mark - 代理
- (NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr_data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WebStroeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_store" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];

    cell.tag = indexPath.row + 10000;
    cell.image_iocn.tag = indexPath.row + 10;
    
    if(self.arr_data.count != 0)
    {
        WebStroe_Model * model = self.arr_data[indexPath.item];
        
        //价格
        cell.price.text = [NSString stringWithFormat:@"¥%@",model.sell_price];
        
        cell.old_price.text = [NSString stringWithFormat:@"¥%@",model.net_price];
        
        cell.detail.text = model.production_name;
        
        [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/product/%@",Url_pic,model.list_img]] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
        
        if(![[NSString stringWithFormat:@"%@",model.city_id] isEqualToString:@"0"])
        {
            cell.image_class.hidden = YES;
        }
    }
    else
    {
        [cell.image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%ld",(long )indexPath.item);
    
    if([_lblRight.text isEqualToString:@"编辑"])
    {
        if(self.arr_data.count != 0)
        {
            WebStroe_Model * model = self.arr_data[indexPath.item];
            
            chanpingxiangqingViewController * chanpingxiangqing = [[chanpingxiangqingViewController alloc] init];
            
            chanpingxiangqing.production_id = model.production_id;
            
            [self showViewController:chanpingxiangqing sender:nil];
        }
    }
    else
    {
        UIImageView * image = [self.view viewWithTag:indexPath.row + 10];
        
        WebStroe_Model * model = self.arr_data[indexPath.item];
        
        WebStroeCollectionViewCell * cell = [self.view viewWithTag:indexPath.row + 10000];
        if(image.isHidden == 0)
        {
            image.hidden = YES;
            
            cell.layer.borderColor = [UIColor whiteColor].CGColor;
            cell.layer.borderWidth = 1;
            
            //移除数组中
            [self.arr_delect removeObject:[NSString stringWithFormat:@"%@",model.favorite_id]];
        }
        else
        {
            image.hidden = NO;
            
            cell.layer.borderColor = navi_bar_bg_color.CGColor;
            cell.layer.borderWidth = 1;
            
            //加在数组里
            [self.arr_delect addObject:[NSString stringWithFormat:@"%@",model.favorite_id]];
        }
        
//        NSLog(@"%ld(unsigned long)",self.arr_delect.count);
    }
}

#pragma mark - 下拉刷新
- (void)example01
{
    // 马上进入刷新状态
    [self.stroe_collectionView.mj_header beginRefreshing];
}

-(void)example02
{
    [self.stroe_collectionView.mj_footer beginRefreshing];
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.stroe_collectionView.mj_header endRefreshing];
        [self.stroe_collectionView.mj_footer endRefreshing];
    });
    
}

#pragma mark - 获取某会员的收藏列表并分页
- (void)p_dataCollect
{
    self.page = 1;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getProductionFavoriteList:"];
    
    [dataprovider getProductionFavoriteListWithMember_id:[userdefault objectForKey:@"member_id"] pagenumber:@"1" pagesize:@"15"];
}

- (void)p_dataCollect1
{
    self.page ++ ;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getProductionFavoriteList1:"];
    
    [dataprovider getProductionFavoriteListWithMember_id:[userdefault objectForKey:@"member_id"] pagenumber:[NSString stringWithFormat:@"%ld",(long)self.page] pagesize:@"15"];
}


#pragma mark - 数据加载
- (void)getProductionFavoriteList:(id )dict
{
//    NSLog(@"%@",dict);
    [SVProgressHUD dismiss];
    
    self.arr_data = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"favoritelist"])
            {
                WebStroe_Model * model = [[WebStroe_Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_data addObject:model];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            if(self.arr_data.count >= 14)
            {
                __weak __typeof(self) weakSelf = self;
                
                self.stroe_collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    
                    [self p_dataCollect1];
                    
                    [weakSelf.stroe_collectionView reloadData];
                    [weakSelf loadNewData];
                }];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新tableView(记住,要更新放在主线程中)
                
                [self.stroe_collectionView reloadData];
            });
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"]];
    }
}


#pragma mark - 数据加载
- (void)getProductionFavoriteList1:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"favoritelist"])
            {
                WebStroe_Model * model = [[WebStroe_Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_data addObject:model];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新tableView(记住,要更新放在主线程中)
                
                [self.stroe_collectionView reloadData];
            });
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"]];
    }
}


#pragma mark - 删除接口
- (void)ProductionFavorite:(id )dict
{
    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            _lblRight.text = @"编辑";
            
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            
            [self example01];

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
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"]];
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

- (NSMutableArray *)arr_delect
{
    if(_arr_delect == nil)
    {
        self.arr_delect = [NSMutableArray array];
    }
    
    return _arr_delect;
}

@end

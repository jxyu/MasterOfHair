//
//  ChanpinshoucangViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/2.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "ChanpinshoucangViewController.h"

#import "JCStroeCollectionViewCell.h"
#import "chanpingxiangqingViewController.h"
@interface ChanpinshoucangViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * stroe_collectionView;

@end

@implementation ChanpinshoucangViewController

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
    _lblTitle.text = [NSString stringWithFormat:@"收藏的产品"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    
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
    }
    else
    {
        //删除全部的
        _lblRight.text = @"编辑";
        
        [self example01];
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
    [self.stroe_collectionView registerClass:[JCStroeCollectionViewCell class] forCellWithReuseIdentifier:@"cell_store"];
    
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.stroe_collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf.stroe_collectionView reloadData];
        [weakSelf loadNewData];
    }];
    
    self.stroe_collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf.stroe_collectionView reloadData];
        [weakSelf loadNewData];
    }];
}

#pragma mark - 代理
- (NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 22;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JCStroeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_store" forIndexPath:indexPath];
    cell.tag = indexPath.row + 10000;
    
    [cell.image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
    
    cell.image_iocn.tag = indexPath.row + 10;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long )indexPath.item);
    
    if([_lblRight.text isEqualToString:@"编辑"])
    {
        chanpingxiangqingViewController * chanpingxiangqing = [[chanpingxiangqingViewController alloc] init];
        
        [self showViewController:chanpingxiangqing sender:nil];
    }
    else
    {
        UIImageView * image = [self.view viewWithTag:indexPath.row + 10];
        JCStroeCollectionViewCell * cell = [self.view viewWithTag:indexPath.row + 10000];
        if(image.isHidden == 0)
        {
            image.hidden = YES;
            
            cell.layer.borderColor = [UIColor whiteColor].CGColor;
            cell.layer.borderWidth = 1;
            
            //移除数组中
        }
        else
        {
            image.hidden = NO;
            
            cell.layer.borderColor = navi_bar_bg_color.CGColor;
            cell.layer.borderWidth = 1;
            
            //加在数组里
        }
    }
}

#pragma mark - 下拉刷新
- (void)example01
{
    // 马上进入刷新状态
    [self.stroe_collectionView.header beginRefreshing];
}

-(void)example02
{
    [self.stroe_collectionView.footer beginRefreshing];
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.stroe_collectionView.header endRefreshing];
        [self.stroe_collectionView.footer endRefreshing];
    });
    
}



@end

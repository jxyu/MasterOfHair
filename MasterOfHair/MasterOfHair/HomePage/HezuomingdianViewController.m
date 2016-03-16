//
//  HezuomingdianViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/3/16.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "HezuomingdianViewController.h"

#import "JCCollectionViewCell.h"
#import "Wenxiulianmeng_Model.h"
@interface HezuomingdianViewController () <UITableViewDataSource, UITableViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) UICollectionView * classify_collectionView;

@property (nonatomic, strong) NSMutableArray * arr_teacher;
@end

@implementation HezuomingdianViewController

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
    _lblTitle.text = [NSString stringWithFormat:@"合作店名"];
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
    [self p_data_teacher];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}


#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:(UITableViewStylePlain)];
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - 代理
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 125;
    }
    else
    {
        return 300;
    }
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    
    if(indexPath.row == 0)
    {
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 125);
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView * view_white = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 105)];
        view_white.backgroundColor = [UIColor whiteColor];
        
        [self p_classify];

        [view_white addSubview:self.classify_collectionView];
        
        [cell addSubview:view_white];
    }
    else
    {
        
    }
    
    return cell;
}

#pragma mark - 分类1行
- (void)p_classify
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    //每个item的大小
    int  item_length = (SCREEN_WIDTH - 20) / 5.5;
    layout.itemSize = CGSizeMake(item_length, item_length + 20);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.classify_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 95) collectionViewLayout:layout];
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
    return self.arr_teacher.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JCCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_classify" forIndexPath:indexPath];
    cell.name.font = [UIFont systemFontOfSize:11];
    cell.imageView.layer.masksToBounds = YES;

//    cell.layer.borderColor = navi_bar_bg_color.CGColor;
//    cell.layer.borderWidth = 1;
//    cell.image_iocn.hidden = NO;
    
    if(self.arr_teacher.count != 0)
    {
        Wenxiulianmeng_Model * model = self.arr_teacher[indexPath.item];
        
        NSString * str1 =  [NSString stringWithFormat:@"%@uploads/technician/%@",Url,model.technician_image];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str1]placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
        
        cell.name.text = model.technician_name;
    }
    
    return cell;
}

#pragma mark - 列表1数据
- (void)p_data_teacher
{
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"SeniorTechnician:"];
    
    [dataprovider SeniorTechnicianWithcity_id:@"109" pagenumber:@"1" pagesize:@"15"];
}

//数据
- (void)SeniorTechnician:(id )dict
{
    NSLog(@"%@",dict);
    
    self.arr_teacher = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"seniortechnicianlist"])
            {
                Wenxiulianmeng_Model * model = [[Wenxiulianmeng_Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_teacher addObject:model];
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
- (NSMutableArray *)arr_teacher
{
    if(_arr_teacher == nil)
    {
        self.arr_teacher = [NSMutableArray array];
    }
    return _arr_teacher;
}



@end

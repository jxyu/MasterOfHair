//
//  FenleiViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/31.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "FenleiViewController.h"

#import "FenleiCollectionViewCell.h"
#import "FenleiCollectionReusableView.h"
@interface FenleiViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton * btn_all;
@property (nonatomic, strong) UIImageView * image_select;
@property (nonatomic, assign) BOOL isselect;


@property (nonatomic, strong) UICollectionView * collectionView;



@end

@implementation FenleiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self p_navi];

    [self p_allView];
    
    [self p_setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navi
- (void)p_navi
{
    _lblTitle.text = [NSString stringWithFormat:@"选择级别"];
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
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

#pragma mark - 布局

- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //每个item的大小
    int  item_length = (SCREEN_WIDTH ) / 4.8;
    layout.itemSize = CGSizeMake(item_length, item_length / 2);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    [layout setHeaderReferenceSize:CGSizeMake(SCREEN_WIDTH, 25)];

    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64 + 55, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 55) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.collectionView];

    //2个注册
    [self.collectionView registerClass:[FenleiCollectionViewCell class] forCellWithReuseIdentifier:@"cell_fenlei"];
    
    [self.collectionView registerClass:[FenleiCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cell_HeaderView"];
}

#pragma mark - collection代理
//代理
- (NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}

- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 7;
    }
    else if(section == 1)
    {
        return 9;
    }
    else
    {
        return 3;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FenleiCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_fenlei" forIndexPath:indexPath];
    
    cell.image.tag = indexPath.section * 10 + indexPath.item;
    cell.name.tag = (indexPath.section + 1) * 100 + indexPath.item;
    
    return cell;
}

//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"item");

    UIImageView * image = [self.view viewWithTag:(indexPath.section * 10 + indexPath.item)];
    image.hidden = NO;
    
    UILabel * label = [self.view viewWithTag:((indexPath.section + 1) * 100 + indexPath.item)];
    label.layer.borderColor = navi_bar_bg_color.CGColor;

    [self.navigationController popViewControllerAnimated:YES];
    
}

//设置头尾部内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    //定制头部视图的内容
    FenleiCollectionReusableView *headerV = (FenleiCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cell_HeaderView" forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            headerV.name.text = @"美发产品";
            break;
        case 1:
            headerV.name.text = @"美容产品";
            break;
        case 2:
            headerV.name.text = @"纹绣产品";
            break;
        case 3:
            headerV.name.text = @"美甲产品";
            break;
        case 4:
            headerV.name.text = @"化妆产品";
            break;
        case 5:
            headerV.name.text = @"足浴";
            break;
        case 6:
            headerV.name.text = @"纹身产品";
            break;
        case 7:
            headerV.name.text = @"美业服饰";
            break;
        case 8:
            headerV.name.text = @"国际品牌";
            break;
        case 9:
            headerV.name.text = @"教学资料";
            break;
        default:
            break;
    }
    reusableView = headerV;
    
    return reusableView;
}
//设置头尾的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
   return CGSizeMake(self.view.frame.size.width, 25);
}

#pragma mark - 头视图中的 btn
- (void)p_allView
{
    self.btn_all = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    self.btn_all.frame = CGRectMake(10, 64 + 10, SCREEN_WIDTH - 20, 40);
    self.btn_all.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.btn_all.layer.borderColor = [UIColor blackColor].CGColor;
    self.btn_all.layer.borderWidth = 1;
    self.btn_all.layer.cornerRadius = 5;
    [self.btn_all setTitle:@"全部" forState:(UIControlStateNormal)];
    self.btn_all.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.btn_all setTintColor:[UIColor blackColor]];
    self.isselect = 0;
    [self.view addSubview:self.btn_all];
    
    self.image_select = [[UIImageView alloc] initWithFrame:CGRectMake(self.btn_all.frame.size.width - 15, 40 - 15, 15, 15)];
    self.image_select.image = [UIImage imageNamed:@"01sdjsidjisjdijsidjs_03"];
    [self.btn_all addSubview:self.image_select];
    self.image_select.hidden = YES;
    
    
    [self.btn_all addTarget:self action:@selector(btn_allAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)btn_allAction:(UIButton *)sender
{
    NSLog(@"点击全部");
    
    if(self.isselect == 0)
    {
        self.image_select.hidden = NO;
        self.btn_all.layer.borderColor = navi_bar_bg_color.CGColor;

        self.isselect = 1;
    }
    else
    {
        self.image_select.hidden = YES;
        self.btn_all.layer.borderColor = [UIColor blackColor].CGColor;

        self.isselect = 0;
    }
    
    
}












@end

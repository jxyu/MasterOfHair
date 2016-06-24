//
//  SearchViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/22.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "SearchViewController.h"


#import "WebStroe_Model.h"
#import "AppDelegate.h"
#import "WebStroeCollectionViewCell.h"
#import "chanpingxiangqingViewController.h"
#import "HYSegmentedControl.h"
#import "ShangmengViewController.h"
#import "TuwenViewController.h"



@interface SearchViewController () <UITextFieldDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,HYSegmentedControlDelegate>

@property (nonatomic, strong) UITextField * search_text;
//数据
@property (nonatomic, strong) NSMutableArray * arr_data;

//collectionView
@property (nonatomic, strong) UICollectionView * stroe_collectionView;

@end

@implementation SearchViewController
{
    HYSegmentedControl *segmentedControl;
}

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
    [self addLeftButton:@"iconfont-fanhui"];
    _lblLeft.text=@"返回";
    _lblLeft.textAlignment=NSTextAlignmentLeft;
//    _btnLeft.backgroundColor = [UIColor orangeColor];
    
    //右边为搜索
    [self addRightbuttontitle:@"搜索"];
    _lblRight.font = [UIFont systemFontOfSize:18];
//    _lblRight.backgroundColor = [UIColor orangeColor];
    _lblRight.frame = CGRectMake(SCREEN_WIDTH - 65, 20, 50, 44);
    _btnRight.frame = _lblRight.frame;
    
    
    //搜索框
    _lblTitle.hidden = YES;
    UIView * view_bg = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_btnLeft.frame) + 0, 24, SCREEN_WIDTH - 135, 35)];
    view_bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
    view_bg.layer.cornerRadius = 0.05 * SCREEN_WIDTH;
    [self.view addSubview:view_bg];
    //图标
    UIImageView * search_image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 25, 25)];
    search_image.image = [UIImage imageNamed:@"iconfont-sousuo"];
    [view_bg addSubview:search_image];
    
    self.search_text = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(search_image.frame) + 5, 5, CGRectGetWidth(view_bg.frame) - 50, 25)];
    self.search_text.placeholder = @"请您输入关键字";
    self.search_text.font = [UIFont systemFontOfSize:15];
    self.search_text.clearButtonMode = UITextFieldViewModeAlways;
    self.search_text.returnKeyType = UIReturnKeySearch;
    self.search_text.delegate = self;
    [view_bg addSubview:self.search_text];
    
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.search_text resignFirstResponder];
}

//左返回
- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//右搜索
- (void)clickRightButton:(UIButton *)sender
{
//    NSLog(@"可编辑的搜索");
    
    [self.search_text resignFirstResponder];
    //进行检索
    
    if([self.search_text.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入搜索的关键字" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else
    {
        DataProvider * dataprovider=[[DataProvider alloc] init];
        [dataprovider setDelegateObject:self setBackFunctionName:@"getProductList:"];
        
//        NSLog(@"%@  -------   %@",self.search_text.text,self.is_maker);
        
        [dataprovider getProductListWithProduction_keyword:self.search_text.text is_maker:self.is_maker is_sell:@"1"];
        
        [SVProgressHUD showWithStatus:@"正在搜索" maskType:(SVProgressHUDMaskTypeBlack)];
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
    layout.sectionInset = UIEdgeInsetsMake(5, 10, 0, 10);
    
    
    
    segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:64 Titles:@[@"商城", @"视频",@"图文",@"商盟",@"名师联盟", @"高级技师",@"名师名店",@"招聘应聘"] delegate:self] ;
    [self.view addSubview:segmentedControl];
    
    
    
    
    
    self.stroe_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(segmentedControl.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(segmentedControl.frame)) collectionViewLayout:layout];
    self.stroe_collectionView.delegate = self;
    self.stroe_collectionView.dataSource = self;
    self.stroe_collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.stroe_collectionView];
    
    //
    [self.stroe_collectionView registerClass:[WebStroeCollectionViewCell class] forCellWithReuseIdentifier:@"cell_webStroe"];
}


#pragma mark HYSegmentedControl的代理
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] selectTableBarIndex:2];
        }
            break;
        case 1://视频
        {
            TuwenViewController * tuwenViewController = [[TuwenViewController alloc] init];
            tuwenViewController.isTeacher = 0;
            
            [self showViewController:tuwenViewController sender:nil];
        }
            break;
        case 2://图文
        {
            TuwenViewController * tuwenViewController = [[TuwenViewController alloc] init];
            tuwenViewController.isTeacher = 1;
            
            [self showViewController:tuwenViewController sender:nil];
        }
            break;
        case 3:
        {
            if(![get_sp(@"member_type") isEqualToString:@"1"])
            {
                ShangmengViewController * shangmengViewController = [[ShangmengViewController alloc] init];
                
                [self showViewController:shangmengViewController sender:nil];
            }
            else
            {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"普通会员无法进入" preferredStyle:(UIAlertControllerStyleAlert)];
                
                [self presentViewController:alert animated:YES completion:^{
                    
                }];
                
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alert addAction:action];
            }
        }
            break;
        default:
            break;
    }
}

//代理
- (NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr_data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    WebStroe_Model * model = self.arr_data[indexPath.item];
    
    WebStroeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_webStroe" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    //价格
    cell.price.text = [NSString stringWithFormat:@"¥%@",model.sell_price];
    
    cell.old_price.text = [NSString stringWithFormat:@"¥%@",model.net_price];
    
    cell.detail.text = model.production_name;
    
    [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/product/%@",Url_pic,model.list_img]] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
    
    if(![model.city_id isEqualToString:@"0"])
    {
        cell.image_class.hidden = YES;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"第几行tableView   %ld",collectionView.tag + 1);
    //    NSLog(@"%ld",(long)indexPath.item);
    
    WebStroe_Model * model = self.arr_data[indexPath.item];
    
    chanpingxiangqingViewController * chanpingxiangqing = [[chanpingxiangqingViewController alloc] init];
    
    chanpingxiangqing.production_id = model.production_id;
    
    [self showViewController:chanpingxiangqing sender:nil];
}

#pragma mark - textField的代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.search_text resignFirstResponder];
    
    if([self.search_text.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入搜索的关键字" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else
    {
        DataProvider * dataprovider=[[DataProvider alloc] init];
        [dataprovider setDelegateObject:self setBackFunctionName:@"getProductList:"];
        
        //        NSLog(@"%@  -------   %@",self.search_text.text,self.is_maker);
        
        [dataprovider getProductListWithProduction_keyword:self.search_text.text is_maker:self.is_maker is_sell:@"1"];
        
        [SVProgressHUD showWithStatus:@"正在搜索" maskType:(SVProgressHUDMaskTypeBlack)];
    }
    
    //进行检索
    return YES;
}

#pragma mark - 数据
- (void)getProductList:(id )dict
{
//    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];
    
    self.arr_data = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"productlist"])
            {
                WebStroe_Model * modle = [[WebStroe_Model alloc] init];
                
                [modle setValuesForKeysWithDictionary:dic];
                
                [self.arr_data addObject:modle];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            if([self.arr_data count] == 0)
            {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"抱歉，没有找到符合的产品" preferredStyle:(UIAlertControllerStyleAlert)];
                
                [self presentViewController:alert animated:YES completion:^{
                    
                }];
                
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alert addAction:action];
            }
            else
            {
                [SVProgressHUD showSuccessWithStatus:@"搜索成功" maskType:(SVProgressHUDMaskTypeBlack)];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新tableView(记住,要更新放在主线程中)
                
                [self.stroe_collectionView reloadData];
            });
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] maskType:SVProgressHUDMaskTypeBlack];
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



@end

//
//  SearchVideoTextViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/25.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "SearchVideoTextViewController.h"


#import "TuWen_Models.h"
#import "AppDelegate.h"
#import "JCVideoCollectionViewCell.h"
#import "VideoDetailViewController.h"
@interface SearchVideoTextViewController () <UITextFieldDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITextField * search_text;
//数据
@property (nonatomic, strong) NSMutableArray * arr_data;

//collectionView
@property (nonatomic, strong) UICollectionView * video_collectionView;

@end

@implementation SearchVideoTextViewController

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
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
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
        
        [dataprovider getVideoListWithVideo_keyword:self.search_text.text pagenumber:@"1" pagesize:@"1000"];
        
        [SVProgressHUD showWithStatus:@"正在搜索" maskType:(SVProgressHUDMaskTypeBlack)];
    }
}

#pragma mark - 布局
- (void)p_setupView
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //每个item的大小
    int  item_length = (SCREEN_WIDTH ) / 3;
    layout.itemSize = CGSizeMake(item_length / 3 * 4.13, item_length / 4 * 3);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.video_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:layout];
    self.video_collectionView.delegate = self;
    self.video_collectionView.dataSource = self;
    self.video_collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    [self.view addSubview:self.video_collectionView];
    
    [self.video_collectionView registerClass:[JCVideoCollectionViewCell class] forCellWithReuseIdentifier:@"cell_video"];
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
    
    TuWen_Models * model = self.arr_data[indexPath.item];
    
    JCVideoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_video" forIndexPath:indexPath];
    //
    cell.name.text = model.video_title;
    
    [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/video/%@",Url_pic,model.video_img]] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
    
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"第几行tableView   %ld",collectionView.tag + 1);
    //    NSLog(@"%ld",(long)indexPath.item);
    
    TuWen_Models * model = self.arr_data[indexPath.item];
    
    VideoDetailViewController * videoDetailViewController = [[VideoDetailViewController alloc] init];
    
    videoDetailViewController.video_id = model.video_id;
    
    [self showViewController:videoDetailViewController sender:nil];
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
        
        [dataprovider getVideoListWithVideo_keyword:self.search_text.text pagenumber:@"1" pagesize:@"1000"];
        
        [SVProgressHUD showWithStatus:@"正在搜索" maskType:(SVProgressHUDMaskTypeBlack)];

    }
    
    //进行检索
    return YES;
}

#pragma mark - 数据
- (void)getProductList:(id )dict
{
//    NSLog(@"%@",dict);
    
    self.arr_data = nil;
    
    [SVProgressHUD dismiss];
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"videolist"])
            {
                TuWen_Models * modle = [[TuWen_Models alloc] init];
                
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
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"抱歉，没有找到符合的视频" preferredStyle:(UIAlertControllerStyleAlert)];
                
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
- (NSMutableArray *)arr_data
{
    if(_arr_data == nil)
    {
        self.arr_data = [NSMutableArray array];
    }
    
    return _arr_data;
}


@end

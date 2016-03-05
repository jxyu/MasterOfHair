//
//  ShoppingCarViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/19.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "ShoppingCarViewController.h"

#import "AppDelegate.h"
#import "ShoppingCarTableViewCell.h"
//#import "querendingdanViewController.h"
#import "GouwuchengdingdanViewController.h"
#import "ShoppingCar_Model.h"

@interface ShoppingCarViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

//下面的结算栏
@property (nonatomic, strong) UIView * bottom_view;

@property (nonatomic, strong) UIButton * bottom_Btnselect;
@property (nonatomic, strong) UILabel * bottom_price;

@property (nonatomic, strong) UIButton * bottom_clearing;


//数组
@property (nonatomic, strong) NSMutableArray * arr_data;

@property (nonatomic, strong) NSMutableArray * arr_baocun;


@end

@implementation ShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self p_navi];
    
    [self p_setupView];
    
    [self p_bottom];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navi
- (void)p_navi
{
    _lblTitle.text = @"购物车";
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
//    [self addRightbuttontitle:@"删除"];
}

////点击设置按钮
//- (void)clickRightButton:(UIButton *)sender
//{
//    NSLog(@"这个删除可要可不要");
//}

//显示tabbar
-(void)viewWillAppear:(BOOL)animated
{
    self.arr_baocun = nil;
    self.arr_data = nil;
    
    [self p_data];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showTabBar];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49 - 50) style:(UITableViewStylePlain)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //注册
    [self.tableView registerClass:[ShoppingCarTableViewCell class] forCellReuseIdentifier:@"cell_shoppingCar"];
}

#pragma mark - 结算栏
- (void)p_bottom
{
    self.bottom_view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, 50)];
    self.bottom_view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottom_view];
    
//全选
    self.bottom_Btnselect = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.bottom_Btnselect.frame = CGRectMake(10, 12.5, 25, 25);
    [self.bottom_view addSubview:self.bottom_Btnselect];
    [self.bottom_Btnselect setBackgroundImage:[UIImage imageNamed:@"01_03＿_031111"] forState:(UIControlStateNormal)];
    [self.bottom_Btnselect addTarget:self action:@selector(bottom_BtnselectAction:) forControlEvents:(UIControlEventTouchUpInside)];

    //
    UILabel * lable_select = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.bottom_Btnselect.frame) + 6, 10, 35, 30)];
    lable_select.text = @"全选";
    lable_select.font = [UIFont systemFontOfSize:15];
    [self.bottom_view addSubview:lable_select];
    
    
    //结算
    self.bottom_clearing = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.bottom_clearing.frame = CGRectMake(SCREEN_WIDTH - 70, 0, 70, 50);
    self.bottom_clearing.backgroundColor = navi_bar_bg_color;
    [self.bottom_view addSubview:self.bottom_clearing];
    [self.bottom_clearing setTitle:@"结算" forState:(UIControlStateNormal)];
    [self.bottom_clearing setTintColor:[UIColor whiteColor]];
    self.bottom_clearing.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [self.bottom_clearing addTarget:self action:@selector(bottom_clearingAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
//合计
    UILabel * label_sum = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lable_select.frame) + 20, 10.5, 30, 30)];
    label_sum.text = @"合计:";
//    label_sum.backgroundColor = [UIColor orangeColor];
    label_sum.font = [UIFont systemFontOfSize:13];
    [self.bottom_view addSubview:label_sum];
    
    self.bottom_price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_sum.frame) + 3, 10.5, SCREEN_WIDTH - 80 - CGRectGetMaxX(label_sum.frame), 30)];
//    self.bottom_price.backgroundColor = [UIColor cyanColor];
    self.bottom_price.text = @"¥ 0.00";
    self.bottom_price.font = [UIFont systemFontOfSize:13];
    self.bottom_price.textColor = [UIColor orangeColor];
    [self.bottom_view addSubview:self.bottom_price];
}

#pragma mark - tableView的代理方法

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr_data.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingCar_Model * model = self.arr_data[indexPath.row];
    
    ShoppingCarTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_shoppingCar"];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    //加数据
    [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@appbackend/uploads/product/%@",Url,model.image]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
    cell.title.text = [NSString stringWithFormat:@"%@",model.production_name];
    cell.detail.text = [NSString stringWithFormat:@"%@",model.specs_name];
    cell.price.text = [NSString stringWithFormat:@"¥ %@",model.price];
    cell.number.text = [NSString stringWithFormat:@"%@",model.number];
    
    
    [cell.btn_select addTarget:self action:@selector(btn_selectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.btn_select.selected = NO;
    [cell.btn_select setTintColor:[UIColor groupTableViewBackgroundColor]];
    [cell.btn_select setBackgroundImage:[UIImage imageNamed:@"01_03＿_031111"] forState:(UIControlStateNormal)];
    cell.btn_select.tag = indexPath.row * 100;
    
    [cell.btn_Add addTarget:self action:@selector(btn_AddAction:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.btn_Add.tag = indexPath.row + 1001;
    
    
    [cell.btn_Subtract addTarget:self action:@selector(btn_SubtractAction:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.btn_Subtract.tag = indexPath.row + 100001;
    
    
    
    for (ShoppingCar_Model * model1 in self.arr_baocun)
    {
        if([model1.shopcart_id isEqualToString:model.shopcart_id])
        {
            cell.btn_select.selected = YES;
            [cell.btn_select setTintColor:[UIColor groupTableViewBackgroundColor]];
            [cell.btn_select setBackgroundImage:[UIImage imageNamed:@"01_03＿_061111"] forState:(UIControlStateNormal)];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 结算栏的点击事件
//全选
- (void)bottom_BtnselectAction:(UIButton *)sender
{
//    NSLog(@"全选，可能改变右边的价格");
    if(sender.selected == 0)
    {//全部选中
        sender.selected = 1;
        
        [sender setTintColor:[UIColor whiteColor]];
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_061111"] forState:(UIControlStateNormal)];
        

        //
        NSInteger count = self.arr_data.count;
        
        for (int i = 0 ; i < count; i ++)
        {
            ShoppingCar_Model * model = self.arr_data[i];
            
            BOOL is_ok = NO;
            
            for (ShoppingCar_Model * model_baocun in self.arr_baocun)
            {
                if([model.shopcart_id isEqualToString:model_baocun.shopcart_id])
                {
                    is_ok = YES;
                }
            }
            
            if(is_ok == NO)
            {
                [self.arr_baocun addObject:model];
            }
        }
    }
    else
    {
        sender.selected = 0;
        
        [sender setTintColor:[UIColor whiteColor]];
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_031111"] forState:(UIControlStateNormal)];
        
        self.arr_baocun = nil;
    }
    
    [self p_price];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //刷新tableView(记住,要更新放在主线程中)
        
        [self.tableView reloadData];
    });
    
    NSLog(@"%ld",self.arr_baocun.count);
}

//结算
- (void)bottom_clearingAction:(UIButton *)sender
{
//    NSLog(@"结算所有选中的商品");
    if(self.arr_baocun.count == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择一个商品后再点击结算" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else
    {
        GouwuchengdingdanViewController * querendingdan = [[GouwuchengdingdanViewController alloc] init];
        
        querendingdan.arr_baocun = self.arr_baocun;
        
        [self showViewController:querendingdan sender:nil];
    }
}

#pragma mark - cell的点击事件
- (void)btn_selectAction:(UIButton *)sender
{
//    NSLog(@"点击选中");
    NSInteger count = sender.tag / 100;
    ShoppingCar_Model * model = self.arr_data[count];
    
    if(sender.selected == 0)
    {//选中
        sender.selected = YES;
        
        [sender setTintColor:[UIColor groupTableViewBackgroundColor]];
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_061111"] forState:(UIControlStateNormal)];
        
        [self.arr_baocun addObject:model];
        
        //可能底部全选
        if(self.arr_baocun.count == self.arr_data.count)
        {
            self.bottom_Btnselect.selected = YES;
            [self.bottom_Btnselect setTintColor:[UIColor whiteColor]];
            [self.bottom_Btnselect setBackgroundImage:[UIImage imageNamed:@"01_03＿_061111"] forState:(UIControlStateNormal)];
        }
    }
    else
    {
        sender.selected = NO;
        
        [sender setTintColor:[UIColor groupTableViewBackgroundColor]];
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_031111"] forState:(UIControlStateNormal)];
        
        [self.arr_baocun removeObject:model];
        
        //底部全选
        if(self.bottom_Btnselect.selected == YES)
        {
            self.bottom_Btnselect.selected = NO;
            [self.bottom_Btnselect setTintColor:[UIColor whiteColor]];
            [self.bottom_Btnselect setBackgroundImage:[UIImage imageNamed:@"01_03＿_031111"] forState:(UIControlStateNormal)];
        }
    }
    
    [self p_price];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //刷新tableView(记住,要更新放在主线程中)
        
        [self.tableView reloadData];
    });
    
    NSLog(@"%ld",self.arr_baocun.count);
}

#pragma mark - 加减
- (void)btn_AddAction:(UIButton *)sender
{
//    NSLog(@"加");
    NSInteger count = sender.tag - 1001;
    ShoppingCar_Model * model = self.arr_data[count];
    
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"create:"];
    
    [dataprovider createWithProduction_id:model.production_id number:@"1" member_id:[userdefault objectForKey:@"member_id"] specs_id:model.specs_id];
}

- (void)btn_SubtractAction:(UIButton *)sender
{
//    NSLog(@"减");
    NSInteger count = sender.tag - 100001;
    ShoppingCar_Model * model = self.arr_data[count];
    
    if([model.number integerValue] == 1)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"购物车数量不能小于1" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else
    {
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        
        DataProvider * dataprovider=[[DataProvider alloc] init];
        [dataprovider setDelegateObject:self setBackFunctionName:@"create:"];
        
        [dataprovider createWithProduction_id:model.production_id number:@"-1" member_id:[userdefault objectForKey:@"member_id"] specs_id:model.specs_id];
    }
}

//数据
- (void)create:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [self p_data];
            
//            [SVProgressHUD showSuccessWithStatus:@"操作成功" maskType:(SVProgressHUDMaskTypeBlack)];

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



#pragma mark - 左滑删除

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定从购物车中删除该商品" preferredStyle:(UIAlertControllerStyleAlert)];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        //做删除操作，并调接口删除后台数据
        
        ShoppingCar_Model * model = self.arr_data[indexPath.row];
        
        DataProvider * dataprovider=[[DataProvider alloc] init];
        [dataprovider setDelegateObject:self setBackFunctionName:@"delete:"];
        
        [dataprovider deleteWithShopcart_id:model.shopcart_id];
    }];
    
    [alert addAction:action1];
}

//掉数据
- (void)delete:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [self p_data];
            
            [SVProgressHUD showSuccessWithStatus:@"删除成功" maskType:(SVProgressHUDMaskTypeBlack)];
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


#pragma mark - 接口
- (void)p_data
{
    self.bottom_price.text = @"¥ 0.00";
    
    self.bottom_Btnselect.selected = NO;
    [self.bottom_Btnselect setBackgroundImage:[UIImage imageNamed:@"01_03＿_031111"] forState:(UIControlStateNormal)];
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"shopcart:"];
    
    NSLog(@"%@",[userdefault objectForKey:@"member_id"]);
    [dataprovider shopcartWithMember_id:[userdefault objectForKey:@"member_id"]];
}

#pragma mark - 商城数据
- (void)shopcart:(id )dict
{
    NSLog(@"%@",dict);
    
    self.arr_baocun = nil;
    self.arr_data = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"shopcartlist"])
            {
                ShoppingCar_Model * model = [[ShoppingCar_Model alloc] init];
                
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
- (NSMutableArray *)arr_data
{
    if(_arr_data == nil)
    {
        self.arr_data = [NSMutableArray array];
    }
    
    return _arr_data;
}

- (NSMutableArray *)arr_baocun
{
    if(_arr_baocun == nil)
    {
        self.arr_baocun = [NSMutableArray array];
    }
    
    return _arr_baocun;
}

#pragma mark - 计算价格
- (void)p_price
{
    
    float price_sum = 0.00;
    
    for (int i = 0; i < self.arr_baocun.count; i ++)
    {
        ShoppingCar_Model * modle = self.arr_baocun[i];
        
        price_sum = [modle.price floatValue] * [modle.number floatValue] + price_sum;
    }
    
    self.bottom_price.text = [NSString stringWithFormat:@"¥ %.2f",price_sum];

}



@end

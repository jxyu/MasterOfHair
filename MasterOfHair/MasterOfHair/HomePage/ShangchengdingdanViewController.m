//
//  ShangchengdingdanViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/3/14.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "ShangchengdingdanViewController.h"
#import "DINGDAN_Model.h"
#import "Pingpp.h"
#import "MineViewController.h"
#import "chanpingxiangqingViewController.h"

#import "SetPayPwdViewController.h"
#import "TXTradePasswordView.h"

#import "shangchengdingdanDetailViewController.h"

@interface ShangchengdingdanViewController () <UITableViewDataSource, UITableViewDelegate,TXTradePasswordViewDelegate>

@property (nonatomic, strong) UIView * top_white;

@property (nonatomic, strong) UIButton * btn_1;
@property (nonatomic, strong) UIButton * btn_2;
@property (nonatomic, strong) UIButton * btn_3;
@property (nonatomic, strong) UIButton * btn_4;
@property (nonatomic, strong) UIButton * btn_5;

@property (nonatomic, strong) UIView * view_1;
@property (nonatomic, strong) UIView * view_2;
@property (nonatomic, strong) UIView * view_3;
@property (nonatomic, strong) UIView * view_4;
@property (nonatomic, strong) UIView * view_5;

//
@property (nonatomic, strong) UITableView * tableView;


@property (nonatomic, strong) NSMutableArray * arr_dataAll;

@property (nonatomic, strong) NSMutableArray * arr_dataList;

@property (nonatomic, copy) NSString * index;

@property (nonatomic, assign) NSInteger page;

@end

@implementation ShangchengdingdanViewController
{
    TXTradePasswordView *TXView;
    UIButton * btn_back;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [SVProgressHUD showWithStatus:@"加载数据中,请稍等..." maskType:SVProgressHUDMaskTypeBlack];
    
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
    _lblTitle.text = @"商城订单";
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
}

//返回
- (void)clickLeftButton:(UIButton *)sender
{
//    [self.navigationController popViewControllerAnimated:YES];
        
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    self.index = @"0";
    
    [self example01];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];

}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self topView];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.top_white.frame) + 1, SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.top_white.frame) - 1) style:(UITableViewStylePlain)];
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf.tableView reloadData];
        [weakSelf loadNewData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
//        if([self.index length] == 0 && [self.index isEqualToString:@"0"])
//        {
//            [self p_data1];
//        }
//        else
//        {
//            [self p_data_state1];
//        }
        
        [self p_data_state1];
        
        
        [weakSelf.tableView reloadData];
        [weakSelf loadNewData];
    }];
    
    //注册
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_dingdan"];
    
}

#pragma mark - 代理
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arr_dataAll.count;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3 + [self.arr_dataList[section] count];
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0 || indexPath.row == [self.arr_dataList[indexPath.section] count] + 1 || indexPath.row == [self.arr_dataList[indexPath.section] count] + 2)
    {
        return 50;
    }
    else
    {
        return 120;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%ld",(long)indexPath.row);
    
    if(indexPath.row == 0 || indexPath.row == [self.arr_dataList[indexPath.section] count] + 1 || indexPath.row == [self.arr_dataList[indexPath.section] count] + 2)
    {
        NSLog(@"1");
    }
    else
    {        
        if(self.arr_dataList.count != 0)
        {
            
            
//            DINGDAN_Model * model = self.arr_dataList[indexPath.section][indexPath.row - 1];
            
            DINGDAN_Model * model_all = self.arr_dataAll[indexPath.section];
//            chanpingxiangqingViewController * chanpingxiangqing = [[chanpingxiangqingViewController alloc] init];
//            
//            chanpingxiangqing.production_id = model.production_id;
//            
//            [self showViewController:chanpingxiangqing sender:nil];
            
            shangchengdingdanDetailViewController * shangchengdingdanDetail = [[shangchengdingdanDetailViewController alloc] init];
            
            shangchengdingdanDetail.model_all = model_all;
            shangchengdingdanDetail.arr_list = self.arr_dataList[indexPath.section];
            
            
            [self showViewController:shangchengdingdanDetail sender:nil];
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    
    if(indexPath.row == 0)
    {
        DINGDAN_Model * model = self.arr_dataAll[indexPath.section];
        
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12.5, 25, 25)];
        image.image = [UIImage imageNamed:@"01dian_07"];
        
        [cell addSubview:image];
        
        UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(image.frame) - 110, 30)];
        name.text = [NSString stringWithFormat:@"%@",model.shop_name];
        name.font = [UIFont systemFontOfSize:16];
        [cell addSubview:name];
        
        UILabel * type = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(name.frame) - 10, 30)];
        type.text = @"待发货待发货";
        type.textAlignment = NSTextAlignmentRight;
        type.textColor = [UIColor orangeColor];
        type.font = [UIFont systemFontOfSize:15];
        [cell addSubview:type];
        
        switch ([model.order_status integerValue])
        {
            case 1:
            {
                type.text = @"等待买家付款";
            }
                break;
            case 2:
            {
                type.text = @"等待卖家发货";
            }
                break;
            case 3:
            {
                type.text = @"等待买家收货";
            }
                break;
            case 4:
            {
                type.text = @"已完成";
            }
                break;
            case 5:
            {
                type.text = @"已取消";
            }
                break;
            default:
                break;
        }
    }
    else if(indexPath.row == [self.arr_dataList[indexPath.section] count] + 1)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        DINGDAN_Model * model = self.arr_dataAll[indexPath.section];
        
        UILabel * price = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 10, 90, 30)];
        price.tag = 10000 + indexPath.section;
        price.textColor = [UIColor orangeColor];
        price.font = [UIFont systemFontOfSize:14];
        [cell addSubview:price];
        
        price.text = [NSString stringWithFormat:@"¥ %@",model.orders_total];
        
        UILabel * sum = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90 - 5 - 40, 10, 40, 30)];
        sum.text = @"合计:";
        sum.font = [UIFont systemFontOfSize:14];
        [cell addSubview:sum];
    }
    else if(indexPath.row == [self.arr_dataList[indexPath.section] count] + 2)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//按钮
        DINGDAN_Model * model = self.arr_dataAll[indexPath.section];
        
        UIButton * btn_first = [UIButton buttonWithType:(UIButtonTypeSystem)];
        btn_first.frame = CGRectMake(SCREEN_WIDTH - 90, 7, 80, 36);
        [btn_first setTitle:@"付款" forState:(UIControlStateNormal)];
        [btn_first setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        btn_first.layer.cornerRadius = 5;
        btn_first.layer.borderColor = [UIColor orangeColor].CGColor;
        btn_first.layer.borderWidth = 1;
        [cell addSubview:btn_first];
        btn_first.tag = 100 + indexPath.section;
        [btn_first addTarget:self action:@selector(btn_first:) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        UIButton * btn_second = [UIButton buttonWithType:(UIButtonTypeSystem)];
        btn_second.frame = CGRectMake(SCREEN_WIDTH - 180, 7, 80, 36);
        [btn_second setTitle:@"取消订单" forState:(UIControlStateNormal)];
        [btn_second setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        btn_second.layer.cornerRadius = 5;
        btn_second.layer.borderColor = [UIColor grayColor].CGColor;
        btn_second.layer.borderWidth = 1;
        [cell addSubview:btn_second];
        
        btn_second.tag = 1000 + indexPath.section;
        btn_second.hidden = YES;
        [btn_second addTarget:self action:@selector(btn_second:) forControlEvents:(UIControlEventTouchUpInside)];

        
        switch ([model.order_status integerValue])
        {
            case 1:
            {
                btn_second.hidden = NO;
                
                [btn_first setTitle:@"付款" forState:(UIControlStateNormal)];
                [btn_first setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
                btn_first.layer.borderColor = [UIColor orangeColor].CGColor;
            }
                break;
            case 2:
            {
                btn_second.hidden = YES;
                
                [btn_first setTitle:@"取消订单" forState:(UIControlStateNormal)];
                [btn_first setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
                btn_first.layer.borderColor = [UIColor grayColor].CGColor;
            }
                break;
            case 3:
            {
                btn_second.hidden = YES;
                
                [btn_first setTitle:@"收货" forState:(UIControlStateNormal)];
                [btn_first setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
                btn_first.layer.borderColor = [UIColor orangeColor].CGColor;
            }
                break;
            case 4:
            {
                btn_second.hidden = YES;
                
                [btn_first setTitle:@"删除订单" forState:(UIControlStateNormal)];
                [btn_first setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
                btn_first.layer.borderColor = [UIColor grayColor].CGColor;
            }
                break;
            case 5:
            {
                btn_second.hidden = YES;
                
                [btn_first setTitle:@"删除订单" forState:(UIControlStateNormal)];
                [btn_first setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
                btn_first.layer.borderColor = [UIColor grayColor].CGColor;
            }
                break;
            default:
                break;
        }
    }
    else
    {
        if(self.arr_dataList.count != 0)
        {
            DINGDAN_Model * model = self.arr_dataList[indexPath.section][indexPath.row - 1];
            
            cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 100, 100)];
            [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/product/%@",Url_pic,model.list_img]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
            [cell addSubview:image];
            
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame) + 5, 15, SCREEN_WIDTH - CGRectGetMaxX(image.frame) - 15, 20)];
            //        name.text = @"VS 洗发水护发素护发素";
            name.text = [NSString stringWithFormat:@"%@",model.production_name];
            name.font = [UIFont systemFontOfSize:15];
            //        name.backgroundColor = [UIColor orangeColor];
            [cell addSubview:name];
            
            UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame) + 5, CGRectGetMaxY(name.frame) + 5, SCREEN_WIDTH - CGRectGetMaxX(image.frame) - 15, 30)];
            //        detail.text = @"VS 洗发水护发素护发素 VS 洗发水护发素护发素";
            detail.text = [NSString stringWithFormat:@"%@",model.specs_name];
            detail.textColor = [UIColor grayColor];
            detail.font = [UIFont systemFontOfSize:12];
            detail.numberOfLines = 2;
            //        detail.backgroundColor = [UIColor orangeColor];
            [cell addSubview:detail];
            
            
            UILabel * price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame) + 5, CGRectGetMaxY(detail.frame) + 15, 70, 20)];
            price.text = [NSString stringWithFormat:@"¥ %@",model.sell_price];
            //        price.backgroundColor = [UIColor blackColor];
            //        price.textAlignment = NSTextAlignmentRight;
            price.font = [UIFont systemFontOfSize:14];
            price.textColor = [UIColor orangeColor];
            [cell addSubview:price];
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(price.frame) + 5, CGRectGetMaxY(detail.frame) + 15, 10, 20)];
            label.font = [UIFont systemFontOfSize:14];
            label.text = @"X";
            [cell addSubview:label];
            
            UILabel * number = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 5, CGRectGetMaxY(detail.frame) + 15, 50, 20)];
            number.text = [NSString stringWithFormat:@"%@",model.production_count];
            number.font = [UIFont systemFontOfSize:14];
            [cell addSubview:number];
        }

    }
    
    return cell;
}

#pragma mark - 点击取消
- (void)btn_first:(UIButton *)sender
{
    NSInteger index_x = sender.tag - 100;
    
    DINGDAN_Model * model = self.arr_dataAll[index_x];
    
    NSLog(@"%@",model.order_status);
    
    switch ([model.order_status integerValue])
    {
        case 1:
        {//付款
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否直接付款该商品" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {

            }];
            
            [alert addAction:action];
            
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
                if([model.pay_method isEqualToString:@"1"])//钱包支付
                {
                    
                    if (get_sp(@"wallet_password")==nil) {
                        SetPayPwdViewController * setPayPWD=[[SetPayPwdViewController alloc] init];
                        setPayPWD.fatherVC=self;
                        [self.navigationController pushViewController:setPayPWD animated:YES];
                        return;
                    }
                    //输入支付密码
                    TXView = [[TXTradePasswordView alloc]initWithFrame:CGRectMake(0, 100,SCREEN_WIDTH, 200) WithTitle:@"请再次输入支付密码"];
                    TXView.tag=index_x;
                    TXView.backgroundColor=[UIColor whiteColor];
                    TXView.TXTradePasswordDelegate = self;
                    if (![TXView.TF becomeFirstResponder])
                    {
                        //成为第一响应者。弹出键盘
                        [TXView.TF becomeFirstResponder];
                    }
                    btn_back=[[UIButton alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
                    btn_back.backgroundColor=[UIColor lightGrayColor];
                    [self.view addSubview:btn_back];
                    
                    [self.view addSubview:TXView];
                    
                    return;

                    
                    
                    
                    
                    
//                    [SVProgressHUD showWithStatus:@"请稍等..." maskType:SVProgressHUDMaskTypeBlack];
                }
                else
                {
                    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
                    
                    DataProvider * dataprovider=[[DataProvider alloc] init];
                    [dataprovider setDelegateObject:self setBackFunctionName:@"dingdanzhifu:"];
                    
                    //            NSLog(@"%@",[userdefault objectForKey:@"member_id"]);
                    
                    [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] orders_id:model.orders_id pay_method:model.pay_method orders_total:model.orders_total andwallet_password:@""];
                    
                    [SVProgressHUD showWithStatus:@"请稍等..." maskType:SVProgressHUDMaskTypeBlack];
                }
                
                
            }];
            
            [alert addAction:action1];
            
            

        }
            break;
        case 2:
        {//取消订单
            
            DataProvider * dataprovider=[[DataProvider alloc] init];
            
            [dataprovider setDelegateObject:self setBackFunctionName:@"update:"];
            
            [dataprovider updateWithOrders_id:model.orders_id order_status:@"5"];
        }
            break;
        case 3:
        {//收货
            
            DataProvider * dataprovider=[[DataProvider alloc] init];
            
            [dataprovider setDelegateObject:self setBackFunctionName:@"update:"];
            
            [dataprovider updateWithOrders_id:model.orders_id order_status:@"4"];
            
        }
            break;
        case 4:
        {//删除订单
            DataProvider * dataprovider=[[DataProvider alloc] init];
            
            [dataprovider setDelegateObject:self setBackFunctionName:@"update:"];
            
            [dataprovider deleteWithOrders_id:model.orders_id];
        }
            break;
        case 5:
        {

        }
            break;
        default:
            break;
    }

}


- (void)btn_second:(UIButton *)sender
{
    NSInteger index_x = sender.tag - 1000;

    DINGDAN_Model * model = self.arr_dataAll[index_x];
    
    NSLog(@"%@",model.order_status);
    
    switch ([model.order_status integerValue])
    {
        case 1:
        {//取消订单
            DataProvider * dataprovider=[[DataProvider alloc] init];
            
            [dataprovider setDelegateObject:self setBackFunctionName:@"update:"];
            
            [dataprovider updateWithOrders_id:model.orders_id order_status:@"5"];
        }
            break;
        case 2:
        {

        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            
        }
            break;
        default:
            break;
    }

}

#pragma mark - 取消，收货数据
- (void)update:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"操作成功" maskType:(SVProgressHUDMaskTypeBlack)];
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            [self p_data_state];
            
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


#pragma mark - 支付
- (void)dingdanzhifu:(id )dict
{
    //    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict[@"data"][@"charge"] options:NSJSONWritingPrettyPrinted error:nil];
            NSString* str_data = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            [Pingpp createPayment:str_data
                   viewController:self
                     appURLScheme:@"MasterOfHair.zykj"
                   withCompletion:^(NSString *result, PingppError *error) {
                       if ([result isEqualToString:@"success"]) {
                           // 支付成功
                           [self.navigationController popViewControllerAnimated:YES];
                           [SVProgressHUD showSuccessWithStatus:@"支付成功~" maskType:SVProgressHUDMaskTypeBlack];
                       } else {
                           // 支付失败或取消
                           NSLog(@"Error: code=%lu msg=%@", error.code, [error getMsg]);
                           [SVProgressHUD showErrorWithStatus:@"支付失败~" maskType:SVProgressHUDMaskTypeBlack];
                       }
                   }];
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

- (void)dingdanzhifu1:(id )dict
{
//    NSLog(@"%@",dict);
    
    //    [SVProgressHUD dismiss];
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"支付成功" maskType:(SVProgressHUDMaskTypeBlack)];
            
            
            ShangchengdingdanViewController * shangchengdingdanViewController = [[ShangchengdingdanViewController alloc] init];
            
            [self showViewController:shangchengdingdanViewController sender:nil];
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
        [SVProgressHUD showErrorWithStatus:@"支付失败" maskType:SVProgressHUDMaskTypeBlack];
    }
}
















#pragma mark - 数据
//所有的
- (void)p_data
{
    self.page = 1;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getOrders:"];
    
    [dataprovider getOrdersWithMember_id:[userdefault objectForKey:@"member_id"] pagenumber:@"1" pagesize:@"15"];
}

- (void)p_data1
{
    self.page ++;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getOrders:"];
    
    [dataprovider getOrdersWithMember_id:[userdefault objectForKey:@"member_id"] pagenumber:[NSString stringWithFormat:@"%ld",(long)self.page] pagesize:@"15"];
}

#pragma mark - 数据加载
- (void)getOrders:(id )dict
{
//    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];
    
    if(self.page == 1)
    {
        self.arr_dataList = nil;
        self.arr_dataAll = nil;
    }
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"orderlist"])
            {
                DINGDAN_Model * model = [[DINGDAN_Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_dataAll addObject:model];
                
                NSMutableArray * arr_list = [NSMutableArray array];
                
                for (NSDictionary * dic_list in dic[@"production_info"])
                {
                    DINGDAN_Model * model = [[DINGDAN_Model alloc] init];
                    
                    [model setValuesForKeysWithDictionary:dic_list];
                    
                    [arr_list addObject:model];
                }
                
                [self.arr_dataList addObject:arr_list];
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

#pragma mark - 状态数据
//所有的
- (void)p_data_state
{
    self.page = 1;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getOrders:"];
    
    [dataprovider getOrdersWithMember_id:[userdefault objectForKey:@"member_id"] order_status:self.index pagenumber:@"1" pagesize:@"15"];

}

//所有的
- (void)p_data_state1
{
    self.page ++;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getOrders:"];
    
    [dataprovider getOrdersWithMember_id:[userdefault objectForKey:@"member_id"] order_status:self.index pagenumber:[NSString stringWithFormat:@"%ld",(long)self.page] pagesize:@"15"];
}



#pragma mark - 下拉刷新
- (void)example01
{
//    if([self.index length] == 0 || [self.index isEqualToString:@"0"])
//    {
//        [self p_data];
//    }
//    else
//    {
//        [self p_data_state];
//    }
    
    [self p_data_state];
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}

-(void)example02
{
    [self.tableView.mj_footer beginRefreshing];
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    });
    
}



























-(void)TXTradePasswordView:(TXTradePasswordView *)view WithPasswordString:(NSString *)Password
{
    [btn_back removeFromSuperview];
    [TXView removeFromSuperview];
    
    DINGDAN_Model * model = self.arr_dataAll[view.tag];
    
    DLog(@"view.tag:%ld",(long)view.tag);
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"dingdanzhifu1:"];
    
    //            NSLog(@"%@",[userdefault objectForKey:@"member_id"]);
    
    [dataprovider createWithMember_id:get_sp(@"member_id") orders_id:model.orders_id pay_method:model.pay_method orders_total:model.orders_total andwallet_password:Password
     ];
    
}











//上面的点击方法
- (void)topView
{
    self.top_white = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50)];
    self.top_white.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.top_white];
    
    int length_x = SCREEN_WIDTH / 5;
    //1
    self.btn_1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_1.frame = CGRectMake(0, 0, length_x, 50);
    [self.btn_1 setTitle:@"全部" forState:(UIControlStateNormal)];
    [self.btn_1 setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    self.btn_1.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.top_white addSubview:self.btn_1];
    
    [self.btn_1 addTarget:self action:@selector(btn_1Action:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.view_1 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, length_x, 2)];
    self.view_1.backgroundColor = [UIColor orangeColor];
    [self.top_white addSubview:self.view_1];
    
    
    //2
    self.btn_2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_2.frame = CGRectMake(length_x, 0, length_x, 50);
    [self.btn_2 setTitle:@"待付款" forState:(UIControlStateNormal)];
    [self.btn_2 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.btn_2.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.top_white addSubview:self.btn_2];
    
    [self.btn_2 addTarget:self action:@selector(btn_2Action:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.view_2 = [[UIView alloc] initWithFrame:CGRectMake(length_x, 49, length_x, 2)];
    self.view_2.backgroundColor = [UIColor orangeColor];
    [self.top_white addSubview:self.view_2];
    self.view_2.hidden = YES;
    
    
    //3
    self.btn_3 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_3.frame = CGRectMake(length_x * 2, 0, length_x, 50);
    [self.btn_3 setTitle:@"待发货" forState:(UIControlStateNormal)];
    [self.btn_3 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.btn_3.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.top_white addSubview:self.btn_3];
    
    [self.btn_3 addTarget:self action:@selector(btn_3Action:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.view_3 = [[UIView alloc] initWithFrame:CGRectMake(length_x * 2, 49, length_x, 2)];
    self.view_3.backgroundColor = [UIColor orangeColor];
    [self.top_white addSubview:self.view_3];
    self.view_3.hidden = YES;
    
    
    //4
    self.btn_4 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_4.frame = CGRectMake(length_x * 3, 0, length_x, 50);
    [self.btn_4 setTitle:@"待收货" forState:(UIControlStateNormal)];
    [self.btn_4 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.btn_4.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.top_white addSubview:self.btn_4];
    
    [self.btn_4 addTarget:self action:@selector(btn_4Action:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.view_4 = [[UIView alloc] initWithFrame:CGRectMake(length_x * 3, 49, length_x, 2)];
    self.view_4.backgroundColor = [UIColor orangeColor];
    [self.top_white addSubview:self.view_4];
    self.view_4.hidden = YES;
    
    
    //5
    self.btn_5 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_5.frame = CGRectMake(length_x * 4, 0, length_x, 50);
    [self.btn_5 setTitle:@"已完成" forState:(UIControlStateNormal)];
    [self.btn_5 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.btn_5.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.top_white addSubview:self.btn_5];
    
    [self.btn_5 addTarget:self action:@selector(btn_5Action:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.view_5 = [[UIView alloc] initWithFrame:CGRectMake(length_x * 4, 49, length_x, 2)];
    self.view_5.backgroundColor = [UIColor orangeColor];
    [self.top_white addSubview:self.view_5];
    self.view_5.hidden = YES;
}

//点击方法
- (void)btn_1Action:(UIButton *)sender
{
    self.index = @"0";
    
    [self example01];
    
    //变颜色
    [self.btn_1 setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    self.view_1.hidden = NO;
    
    [self.btn_2 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_2.hidden = YES;
    [self.btn_3 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_3.hidden = YES;
    [self.btn_4 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_4.hidden = YES;
    [self.btn_5 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_5.hidden = YES;
    

}

- (void)btn_2Action:(UIButton *)sender
{
    self.index = @"1";
    
    [self example01];
    
    //变颜色
    [self.btn_2 setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    self.view_2.hidden = NO;
    
    [self.btn_1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_1.hidden = YES;
    [self.btn_3 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_3.hidden = YES;
    [self.btn_4 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_4.hidden = YES;
    [self.btn_5 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_5.hidden = YES;
    

}

- (void)btn_3Action:(UIButton *)sender
{
    self.index = @"2";
    
    [self example01];
    
    //变颜色
    [self.btn_3 setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    self.view_3.hidden = NO;
    
    [self.btn_2 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_2.hidden = YES;
    [self.btn_1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_1.hidden = YES;
    [self.btn_4 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_4.hidden = YES;
    [self.btn_5 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_5.hidden = YES;
}

- (void)btn_4Action:(UIButton *)sender
{
    
    self.index = @"3";
    
    [self example01];
    
    //变颜色
    [self.btn_4 setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    self.view_4.hidden = NO;
    
    [self.btn_2 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_2.hidden = YES;
    [self.btn_3 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_3.hidden = YES;
    [self.btn_1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_1.hidden = YES;
    [self.btn_5 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_5.hidden = YES;
}

- (void)btn_5Action:(UIButton *)sender
{
    self.index = @"4";
    
    [self example01];
    
    //变颜色
    [self.btn_5 setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    self.view_5.hidden = NO;
    
    [self.btn_2 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_2.hidden = YES;
    [self.btn_3 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_3.hidden = YES;
    [self.btn_4 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_4.hidden = YES;
    [self.btn_1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.view_1.hidden = YES;
    

}

#pragma mark - 懒加载
- (NSMutableArray *)arr_dataAll
{
    if(_arr_dataAll == nil)
    {
        self.arr_dataAll = [NSMutableArray array];
    }
    return _arr_dataAll;
}

- (NSMutableArray *)arr_dataList
{
    if(_arr_dataList == nil)
    {
        self.arr_dataList = [NSMutableArray array];
    }
    return _arr_dataList;
}





@end

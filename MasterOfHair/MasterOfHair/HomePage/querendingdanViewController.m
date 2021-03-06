//
//  querendingdanViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/26.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "querendingdanViewController.h"
#import "TXTradePasswordView.h"
#import "AppDelegate.h"
#import "SelectshouhuoViewController.h"
#import "Shouhudizhi_Model.h"
#import "SetPayPwdViewController.h"
#import "Pingpp.h"
#import "ShangchengdingdanViewController.h"
@interface querendingdanViewController () <UITableViewDelegate, UITableViewDataSource,TXTradePasswordViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
//头视图
@property (nonatomic, strong) UIView * head_view;
@property (nonatomic, assign) BOOL isMoren;

@property (nonatomic, strong) UILabel * name;
@property (nonatomic, strong) UILabel * tel;
@property (nonatomic, strong) UILabel * address;

//
@property (nonatomic, strong) UIImageView * image_1;


//尾视图
@property (nonatomic, strong) UIView * bottom_view;

@property (nonatomic, strong) UILabel * price_sum;

@property (nonatomic, strong) UIButton * btn_myPurse;
@property (nonatomic, strong) UIButton * btn_zhifubo;
@property (nonatomic, strong) UIButton * btn_weixin;
//确认支付
@property (nonatomic, strong) UIButton * btn_zhifuOK;


//
@property (nonatomic, strong) NSMutableArray * arr_morenAddress;

@property (nonatomic, strong) UILabel * price;

@property (nonatomic, copy) NSString * str_zhifutype;
@property (nonatomic, copy) NSString * str_zhifusum;
@property (nonatomic,strong) NSString * pwdStr;
@end

@implementation querendingdanViewController
{
    TXTradePasswordView *TXView;
    UIButton * btn_back;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //清空
    [Single_Model singel].shouhudizhi_Model = nil;
    
//    [self p_data_moren];
    _pwdStr=@"";
    
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
    _lblTitle.text = @"确认订单";
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    _lblLeft.text=@"返回";
    _lblLeft.textAlignment=NSTextAlignmentLeft;
}
//返回
- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    if([Single_Model singel].shouhudizhi_Model == nil)
    {
        [self p_data_moren];
    }
    else
    {
        self.arr_morenAddress = nil;
        
        self.image_1.hidden = NO;
        self.name.hidden = NO;
        self.tel.hidden = NO;
        self.address.hidden = NO;
        
        Shouhudizhi_Model * model = [Single_Model singel].shouhudizhi_Model;
        
        NSString * str = [NSString stringWithFormat:@"%@%@%@%@",[model.province_name length]== 0 ? @"" : model.province_name,[model.city_name length]== 0 ? @"" : model.city_name,[model.area_name length]== 0 ? @"" : model.area_name ,[model.address length]== 0 ? @"" : model.address];
        
        self.name.text = model.consignee;
        self.tel.text = model.mobile;
        self.address.text = str;
        
        [self.arr_morenAddress addObject:[Single_Model singel].shouhudizhi_Model];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新tableView(记住,要更新放在主线程中)
            
            [self.tableView reloadData];
        });

    }
    
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    
    [self p_headView];
    [self p_bottomView];
    
    self.tableView.tableHeaderView = self.head_view;
    self.tableView.tableFooterView = self.bottom_view;
    
    //注册
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_queren"];
}


#pragma mark - tableView
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1 + 4;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0 || indexPath.row == 4 || indexPath.row == 3 || indexPath.row == 2)
    {
        return 50;
    }
    else
    {
        return 120;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    
    if(indexPath.row == 0)
    {
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
        image.image = [UIImage imageNamed:@"01dian_07"];
        
        [cell addSubview:image];
        
        UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(image.frame) - 20, 30)];
        
        name.text = [NSString stringWithFormat:@"%@",self.chanpinDetail.shop_name];
//        name.font = [UIFont systemFontOfSize:15];
        [cell addSubview:name];
    }
    else if (indexPath.row == 2)
    {
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 30)];
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"配送方式";
        [cell addSubview:label];
        
        UILabel * distribution = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 100, 10, 100, 30)];
        distribution.textAlignment = NSTextAlignmentRight;
        distribution.text = @"物流配送";
        distribution.font = [UIFont systemFontOfSize:14];
        distribution.tag = 100 + indexPath.section;
        [cell addSubview:distribution];
        
    }
    else if (indexPath.row == 3)
    {
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 30)];
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"买家留言:";
//        label.backgroundColor = [UIColor orangeColor];
        [cell addSubview:label];
        
        UITextField * text = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) , 11, SCREEN_WIDTH - CGRectGetMaxY(label.frame) - 10, 30)];
        text.userInteractionEnabled = NO;
        text.tag = 1000 + indexPath.section;
        text.font = [UIFont systemFontOfSize:14];
        text.placeholder = @"想对卖家说什么(选填)";
        [cell addSubview:text];
    }
    else if(indexPath.row == 4)
    {
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.price = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 10, 90, 30)];
        float sum_price = ([self.Chanpingxiangqing.sell_price floatValue] * self.good_Num) + [self.chanpinDetail.logistics_freight floatValue];
        
        self.str_zhifusum = [NSString stringWithFormat:@"%f",sum_price];
        
        self.price.text = [NSString stringWithFormat:@"¥ %.2f",sum_price];
        self.price_sum.text = self.price.text;
        self.price.textColor = [UIColor orangeColor];
        self.price.font = [UIFont systemFontOfSize:14];
        [cell addSubview:self.price];
        
        UILabel * sum = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90 - 5 - 40, 10, 40, 30)];
        sum.text = @"合计:";
        sum.font = [UIFont systemFontOfSize:14];
        [cell addSubview:sum];
    }
    else
    {
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 100, 100)];
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/product/%@",Url_pic,self.chanpinDetail.list_img]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
        [cell addSubview:image];
        
        UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame) + 5, 15, SCREEN_WIDTH - CGRectGetMaxX(image.frame) - 15, 20)];
//        name.text = @"VS 洗发水护发素护发素";
        name.text = [NSString stringWithFormat:@"%@",self.chanpinDetail.production_name];
        name.font = [UIFont systemFontOfSize:15];
//        name.backgroundColor = [UIColor orangeColor];
        [cell addSubview:name];
        
        UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame) + 5, CGRectGetMaxY(name.frame) + 5, SCREEN_WIDTH - CGRectGetMaxX(image.frame) - 15, 30)];
//        detail.text = @"VS 洗发水护发素护发素 VS 洗发水护发素护发素";
        detail.text = [NSString stringWithFormat:@"%@",self.Chanpingxiangqing.specs_name];
        detail.textColor = [UIColor grayColor];
        detail.font = [UIFont systemFontOfSize:12];
        detail.numberOfLines = 2;
//        detail.backgroundColor = [UIColor orangeColor];
        [cell addSubview:detail];
        
        
        UILabel * price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame) + 5, CGRectGetMaxY(detail.frame) + 15, 70, 20)];
        price.text = [NSString stringWithFormat:@"¥ %@",self.Chanpingxiangqing.sell_price];
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
        number.text = [NSString stringWithFormat:@"¥ %ld",(long)_good_Num];
        number.font = [UIFont systemFontOfSize:14];
        [cell addSubview:number];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == 2)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择配送方式" preferredStyle:(UIAlertControllerStyleActionSheet)];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action_1 = [UIAlertAction actionWithTitle:@"到店自取" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
           UILabel * peisong = [self.view viewWithTag:(100 + indexPath.section)];
            
            peisong.text = @"到店自取";
            
            float sum_price = [self.Chanpingxiangqing.sell_price floatValue]*self.good_Num;
            
            
            self.str_zhifusum = [NSString stringWithFormat:@"%f",sum_price];
            self.price.text = [NSString stringWithFormat:@"¥ %.2f",sum_price];
            self.price_sum.text = self.price.text;
            
            
        }];
        
        UIAlertAction * action_2 = [UIAlertAction actionWithTitle:@"同城派送" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            UILabel * peisong = [self.view viewWithTag:(100 + indexPath.section)];
            peisong.text = @"同城派送";
            
            float sum_price = [self.Chanpingxiangqing.sell_price floatValue]*self.good_Num + [self.chanpinDetail.city_freight floatValue];
            
            self.str_zhifusum = [NSString stringWithFormat:@"%f",sum_price];

            self.price.text = [NSString stringWithFormat:@"¥ %.2f",sum_price];
            self.price_sum.text = self.price.text;
            
        }];
        
        UIAlertAction * action_3 = [UIAlertAction actionWithTitle:@"物流配送" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            UILabel * peisong = [self.view viewWithTag:(100 + indexPath.section)];
            peisong.text = @"物流配送";
            
            float sum_price = [self.Chanpingxiangqing.sell_price floatValue]*self.good_Num + [self.chanpinDetail.logistics_freight floatValue];
            
            self.str_zhifusum = [NSString stringWithFormat:@"%f",sum_price];

            self.price.text = [NSString stringWithFormat:@"¥ %.2f",sum_price];
            self.price_sum.text = self.price.text;

        }];
        
        UIAlertAction * action_4 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action_1];
        [alert addAction:action_2];
        [alert addAction:action_3];
        [alert addAction:action_4];
        
    }
    else if (indexPath.row == 3)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"请输入对卖家的留言" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
            
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];
        
        UIAlertAction * action_ok = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            UITextField * textField = alert.textFields.firstObject;
            NSLog(@"%@",textField.text);
            
            UITextField * liuyan = [self.view viewWithTag:(1000 + indexPath.section)];
            liuyan.text = textField.text;
        }];
        
        UIAlertAction * action_cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            //不做任何操作
        }];
        
        [alert addAction:action_cancel];
        [alert addAction:action_ok];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];

    }
}

#pragma mark - 头视图
- (void)p_headView
{
    if([self.arr_morenAddress count] == 0)
    {
        self.head_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        self.head_view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UIView * view_white = [[UIView alloc] initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH, 70)];
        view_white.backgroundColor = [UIColor whiteColor];
        [self.head_view addSubview:view_white];
        
        UIImageView * head_image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 40, 40)];
        head_image.image = [UIImage imageNamed:@"05__03"];
        [view_white addSubview:head_image];
        
        UILabel * head_label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(head_image.frame) + 10, 20, 150, 30)];
        head_label.text = @"选择收货地址";
        [view_white addSubview:head_label];
        
        
        self.image_1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
        self.image_1.image = [UIImage imageNamed:@"white_bg"];
        [self.head_view addSubview:self.image_1];
        
        
        CGFloat length_x = (SCREEN_WIDTH - 50) / 2;
        
        self.name = [[UILabel alloc] init];
        self.name.frame = CGRectMake(20, 10, length_x, 25);
        self.name.text = @"哈啊哈";
        self.name.font = [UIFont systemFontOfSize:18];
        [self.head_view addSubview:self.name];
        
        
        self.tel = [[UILabel alloc] init];
        self.tel.frame = CGRectMake(CGRectGetMaxX(self.name.frame) + 10, 10, length_x, 25);
        self.tel.text = @"1888888888888";
        self.tel.textAlignment = NSTextAlignmentRight;
        [self.head_view addSubview:self.tel];
        
        
        self.address = [[UILabel alloc] init];
        self.address.frame = CGRectMake(20, CGRectGetMaxY(self.name.frame) + 13, SCREEN_WIDTH - 40, 34);
        self.address.text = @"山东省临沂市山东省临沂市山东省临沂市山东省临沂市";
        self.address.font = [UIFont systemFontOfSize:14];
        self.address.numberOfLines = 2;
        [self.head_view addSubview:self.address];
        
        //开启用户交互
        self.head_view.userInteractionEnabled = YES;
        //隐藏
        self.image_1.hidden = YES;
        self.name.hidden = YES;
        self.tel.hidden = YES;
        self.address.hidden = YES;
    }
    else
    {
        self.image_1.hidden = NO;
        self.name.hidden = NO;
        self.tel.hidden = NO;
        self.address.hidden = NO;
    }
    
    //新建tap手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    //设置点击次数和点击手指数
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.head_view addGestureRecognizer:tapGesture];
}

#pragma mark - 轻击手势触发方法
-(void)tapGesture:(id)sender
{
    NSLog(@"跳到选择页");
    
    SelectshouhuoViewController * Selectshouhuo = [[SelectshouhuoViewController alloc] init];
    
    [self showViewController:Selectshouhuo sender:nil];
}

#pragma mark - 尾视图
- (void)p_bottomView
{
    self.bottom_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    self.bottom_view.backgroundColor = [UIColor whiteColor];
    
    UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.bottom_view addSubview:view_line];
    
    
    self.price_sum = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, CGRectGetMaxY(view_line.frame) + 5, 90, 25)];
    self.price_sum.textColor = [UIColor orangeColor];
    self.price_sum.font = [UIFont systemFontOfSize:14];
//    self.price_sum.backgroundColor = [UIColor orangeColor];
    [self.bottom_view addSubview:self.price_sum];
    
    UILabel * sum = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90 - 5 - 40, CGRectGetMaxY(view_line.frame) + 5, 40, 25)];
    sum.text = @"合计:";
    sum.font = [UIFont systemFontOfSize:14];
    [self.bottom_view addSubview:sum];
    
    UILabel * line_1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sum.frame) + 5, SCREEN_WIDTH, 1)];
    line_1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.bottom_view addSubview:line_1];
    
    UILabel * type = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(line_1.frame) + 5, 100, 15)];
    type.text = @"选择支付方式";
    type.textColor = [UIColor grayColor];
    type.font = [UIFont systemFontOfSize:12];
    [self.bottom_view addSubview:type];
    
    CGFloat length_x = SCREEN_WIDTH / 3;
    //我的钱包
    self.btn_myPurse = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.btn_myPurse.frame = CGRectMake(15, CGRectGetMaxY(type.frame) + 7.5, 25, 25);
//    self.btn_myPurse.backgroundColor = [UIColor orangeColor];
    self.btn_myPurse.selected = 0;
    [self.bottom_view addSubview:self.btn_myPurse];
    [self.btn_myPurse addTarget:self action:@selector(btn_myPurseAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.btn_myPurse setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
    
    UILabel * label_myPurse = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.btn_myPurse.frame) + 5, CGRectGetMaxY(type.frame) + 5, length_x - CGRectGetMaxX(self.btn_myPurse.frame) - 5, 30)];
//    label_myPurse.backgroundColor = [UIColor orangeColor];
    label_myPurse.text = @"我的钱包";
    label_myPurse.font = [UIFont systemFontOfSize:12];
    [self.bottom_view addSubview:label_myPurse];
    
    //支付宝
    self.btn_zhifubo = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.btn_zhifubo.frame = CGRectMake(10 + length_x, CGRectGetMaxY(type.frame) + 7.5, 25, 25);
//    self.btn_zhifubo.backgroundColor = [UIColor orangeColor];
    self.btn_zhifubo.selected = 0;
    [self.bottom_view addSubview:self.btn_zhifubo];
    [self.btn_zhifubo addTarget:self action:@selector(btn_zhifuboAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.btn_zhifubo setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
    
    
    UILabel * label_zhifubo = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.btn_zhifubo.frame) + 5, CGRectGetMaxY(type.frame) + 5, length_x - CGRectGetMaxX(self.btn_myPurse.frame) , 30)];
//    label_zhifubo.backgroundColor = [UIColor orangeColor];
    label_zhifubo.text = @"支付宝支付";
    label_zhifubo.font = [UIFont systemFontOfSize:12];
    [self.bottom_view addSubview:label_zhifubo];
    
    //微信
    self.btn_weixin = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.btn_weixin.frame = CGRectMake(15 + length_x * 2, CGRectGetMaxY(type.frame) + 7.5, 25, 25);
//    self.btn_weixin.backgroundColor = [UIColor orangeColor];
    self.btn_weixin.selected = 0;
    [self.bottom_view addSubview:self.btn_weixin];
    [self.btn_weixin addTarget:self action:@selector(btn_weixinAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.btn_weixin setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
    
    UILabel * label_weixin = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.btn_weixin.frame) + 5, CGRectGetMaxY(type.frame) + 5, length_x - CGRectGetMaxX(self.btn_myPurse.frame) - 5, 30)];
//    label_weixin.backgroundColor = [UIColor orangeColor];
    label_weixin.text = @"微信支付";
    label_weixin.font = [UIFont systemFontOfSize:12];
    [self.bottom_view addSubview:label_weixin];
    
    //确认支付
    self.btn_zhifuOK = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_zhifuOK.frame = CGRectMake(15, CGRectGetMaxY(self.btn_zhifubo.frame) + 10, SCREEN_WIDTH - 30, 45);
    self.btn_zhifuOK.backgroundColor = navi_bar_bg_color;
    [self.btn_zhifuOK setTitle:@"确认支付" forState:(UIControlStateNormal)];
    [self.btn_zhifuOK setTintColor:[UIColor whiteColor]];
    self.btn_zhifuOK.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.bottom_view addSubview:self.btn_zhifuOK];
    
    [self.btn_zhifuOK addTarget:self action:@selector(btn_zhifuOKAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

#pragma mark - bottom的4个btn

- (void)btn_zhifuOKAction:(UIButton *)sender
{//做大量判断
//    NSLog(@"提交订单");
    
    Shouhudizhi_Model * model = self.arr_morenAddress.firstObject;

    if([model.address_id length] == 0 || (self.btn_myPurse.selected == 0 && self.btn_weixin.selected == 0 && self.btn_zhifubo.selected == 0))
    {
        if([model.address_id length] == 0)
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择收货地址" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
        }
        
        if(self.btn_myPurse.selected == 0 && self.btn_weixin.selected == 0 && self.btn_zhifubo.selected == 0)
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择支付方式" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
        }

    }
    else
    {
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        
        DataProvider * dataprovider=[[DataProvider alloc] init];
        [dataprovider setDelegateObject:self setBackFunctionName:@"chuangjiandangdan:"];
        
        //配送
        UILabel * label = [self.view viewWithTag:100];
        NSString * str_peisong = [NSString stringWithFormat:@""];
        if([label.text isEqualToString:@"同城派送"])
        {
            str_peisong = @"3";
        }
        else if([label.text isEqualToString:@"物流配送"])
        {
            str_peisong = @"1";
        }
        else
        {
            str_peisong = @"2";
        }
        
        //留言
        UITextField * text = [self.view viewWithTag:1000];
        NSString * str_liuyan = [NSString stringWithFormat:@""];
        if([text.text length] == 0)
        {
            str_liuyan = @"";
        }
        else
        {
            str_liuyan = text.text;
        }
        
        //支付方式
        NSString * str_zhifu = [NSString stringWithFormat:@""];
        if(self.btn_myPurse.selected == 1)
        {
            str_zhifu = @"1";
            if (get_sp(@"wallet_password")==nil) {
                SetPayPwdViewController * setPayPWD=[[SetPayPwdViewController alloc] init];
                setPayPWD.fatherVC=self;
                [self.navigationController pushViewController:setPayPWD animated:YES];
                return;
            }
            //输入支付密码
            TXView = [[TXTradePasswordView alloc]initWithFrame:CGRectMake(0, 100,SCREEN_WIDTH, 200) WithTitle:@"请再次输入支付密码"];
            TXView.tag=1;
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
        }
        if(self.btn_weixin.selected == 1)
        {
            str_zhifu = @"3";
        }
        if(self.btn_zhifubo.selected == 1)
        {
            str_zhifu = @"2";
        }
        
        
        
        NSMutableArray * arr_pro = [NSMutableArray array];
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:self.chanpinDetail.production_id,@"production_id",self.Chanpingxiangqing.specs_id,@"specs_id",@"1",@"production_count",nil];
        NSLog(@"%@",dict);
        
        [arr_pro addObject:dict];
        
        Shouhudizhi_Model * model = self.arr_morenAddress.firstObject;
        
        self.str_zhifutype = str_zhifu;
        
        [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] shop_id:self.chanpinDetail.shop_id shipping_method:str_peisong pay_method:str_zhifu address_id:model.address_id pay_status:@"0" leave_word:str_liuyan production_info:arr_pro andwallet_password:@""];
    }
}
-(void)TXTradePasswordView:(TXTradePasswordView *)view WithPasswordString:(NSString *)Password
{
    [btn_back removeFromSuperview];
    [TXView removeFromSuperview];
//    if ([Password isEqualToString:get_sp(@"wallet_password")]) {
    _pwdStr=Password;
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        
        DataProvider * dataprovider=[[DataProvider alloc] init];
        [dataprovider setDelegateObject:self setBackFunctionName:@"chuangjiandangdan:"];
        
        //配送
        UILabel * label = [self.view viewWithTag:100];
        NSString * str_peisong = [NSString stringWithFormat:@""];
        if([label.text isEqualToString:@"同城派送"])
        {
            str_peisong = @"3";
        }
        else if([label.text isEqualToString:@"物流配送"])
        {
            str_peisong = @"1";
        }
        else
        {
            str_peisong = @"2";
        }
        
        //留言
        UITextField * text = [self.view viewWithTag:1000];
        NSString * str_liuyan = [NSString stringWithFormat:@""];
        if([text.text length] == 0)
        {
            str_liuyan = @"";
        }
        else
        {
            str_liuyan = text.text;
        }
        
        //支付方式
        NSString * str_zhifu = [NSString stringWithFormat:@""];
        if(self.btn_myPurse.selected == 1)
        {
            str_zhifu = @"1";
            
            
        }
        if(self.btn_weixin.selected == 1)
        {
            str_zhifu = @"3";
        }
        if(self.btn_zhifubo.selected == 1)
        {
            str_zhifu = @"2";
        }
        
        
        
        
        
        NSMutableArray * arr_pro = [NSMutableArray array];
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:self.chanpinDetail.production_id,@"production_id",self.Chanpingxiangqing.specs_id,@"specs_id",@"1",@"production_count",nil];
        NSLog(@"%@",dict);
        
        [arr_pro addObject:dict];
        
        Shouhudizhi_Model * model = self.arr_morenAddress.firstObject;
        
        self.str_zhifutype = str_zhifu;
        
        [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] shop_id:self.chanpinDetail.shop_id shipping_method:str_peisong pay_method:str_zhifu address_id:model.address_id pay_status:@"0" leave_word:str_liuyan production_info:arr_pro andwallet_password:Password];
//    }
//    else
//    {
//        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付密码不正确" preferredStyle:(UIAlertControllerStyleAlert)];
//        
//        [self presentViewController:alert animated:YES completion:^{
//            
//        }];
//        
//        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        
//        [alert addAction:action];
//        return;
//    }
    
}

//
- (void)btn_myPurseAction:(UIButton *)sender
{
    if(sender.selected == 0)
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_06"] forState:(UIControlStateNormal)];
        sender.selected = 1;
        
        self.btn_zhifubo.selected = 0;
        [self.btn_zhifubo setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
        
        self.btn_weixin.selected = 0;
        [self.btn_weixin setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
        sender.selected = 0;
    }
}

- (void)btn_zhifuboAction:(UIButton *)sender
{
    if(sender.selected == 0)
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_06"] forState:(UIControlStateNormal)];
        sender.selected = 1;
        
        self.btn_myPurse.selected = 0;
        [self.btn_myPurse setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
        
        self.btn_weixin.selected = 0;
        [self.btn_weixin setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
        sender.selected = 0;
    }
}

- (void)btn_weixinAction:(UIButton *)sender
{
    if(sender.selected == 0)
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_06"] forState:(UIControlStateNormal)];
        sender.selected = 1;
        
        self.btn_zhifubo.selected = 0;
        [self.btn_zhifubo setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
        
        self.btn_myPurse.selected = 0;
        [self.btn_myPurse setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"01_03＿_03"] forState:(UIControlStateNormal)];
        sender.selected = 0;
    }
}


#pragma mark - 获取默认地址接口
- (void)p_data_moren
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getAddresses:"];
    
    [dataprovider getAddressesWithMember_id:[userdefault objectForKey:@"member_id"] is_default:@"1"];
}

- (void)getAddresses:(id )dict
{
//    NSLog(@"%@",dict);
    
    self.arr_morenAddress = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSArray * arr = dict[@"data"][@"addresslist"];
            
            Shouhudizhi_Model * model = [[Shouhudizhi_Model alloc] init];
            
            [model setValuesForKeysWithDictionary:arr.firstObject];
            
            if([model.address_id length] != 0)
            {
                [self.arr_morenAddress addObject:model];
                
                
                self.image_1.hidden = NO;
                self.name.hidden = NO;
                self.tel.hidden = NO;
                self.address.hidden = NO;
                
                Shouhudizhi_Model * model = self.arr_morenAddress.firstObject;
                
                NSString * str = [NSString stringWithFormat:@"%@%@%@%@",[model.province_name length]== 0 ? @"" : model.province_name,[model.city_name length]== 0 ? @"" : model.city_name,[model.area_name length]== 0 ? @"" : model.area_name ,[model.address length]== 0 ? @"" : model.address];
                
                self.name.text = model.consignee;
                self.tel.text = model.mobile;
                self.address.text = str;
            }
            else
            {
                self.image_1.hidden = YES;
                self.name.hidden = YES;
                self.tel.hidden = YES;
                self.address.hidden = YES;
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
//        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] ];
    }
}

#pragma mark - 创建订单
- (void)chuangjiandangdan:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
//            [SVProgressHUD showSuccessWithStatus:@"生成订单成功"  ];
            
            if([self.str_zhifutype isEqualToString:@"1"])
            {
                NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
                
                DataProvider * dataprovider=[[DataProvider alloc] init];
                [dataprovider setDelegateObject:self setBackFunctionName:@"dingdanzhifu1:"];
                
                NSLog(@"%@",[userdefault objectForKey:@"member_id"]);
                
                [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] orders_id:[NSString stringWithFormat:@"%@",dict[@"data"][@"order_id"]] pay_method:self.str_zhifutype orders_total:self.str_zhifusum andwallet_password:_pwdStr];
                
                [SVProgressHUD showWithStatus:@"请稍等..." ];
            }
            else
            {
                NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
                
                DataProvider * dataprovider=[[DataProvider alloc] init];
                [dataprovider setDelegateObject:self setBackFunctionName:@"dingdanzhifu:"];
                
                NSLog(@"%@",[userdefault objectForKey:@"member_id"]);
                
                [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] orders_id:[NSString stringWithFormat:@"%@",dict[@"data"][@"order_id"]] pay_method:self.str_zhifutype orders_total:self.str_zhifusum andwallet_password:_pwdStr];
                
                [SVProgressHUD showWithStatus:@"请稍等..." ];
            }
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
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] ];
    }
}

#pragma mark - 支付
- (void)dingdanzhifu:(id )dict
{
    NSLog(@"%@",dict);
    
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
                           [SVProgressHUD showSuccessWithStatus:@"支付成功~" ];
                       } else {
                           // 支付失败或取消
//                           NSLog(@"Error: code=%lu msg=%@", (unsigned long)error.code, [error getMsg]);
                           [SVProgressHUD showErrorWithStatus:@"支付失败~" ];
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
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] ];
    }
}


- (void)dingdanzhifu1:(id )dict
{
//    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"支付成功"  ];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            ShangchengdingdanViewController * shangchengdingdanViewController = [[ShangchengdingdanViewController alloc] init];
            
            [self showViewController:shangchengdingdanViewController sender:nil];
        }
    }
    else
    {
        NSLog(@"%@",dict[@"status"][@"message"]);
        [SVProgressHUD showErrorWithStatus:@"支付失败" ];
    }
}


#pragma mark - 懒加载
- (NSMutableArray *)arr_morenAddress
{
    if(_arr_morenAddress == nil)
    {
        self.arr_morenAddress = [NSMutableArray array];
    }
    
    return _arr_morenAddress;
}



@end

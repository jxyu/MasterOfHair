//
//  shangchengdingdanDetailViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/4/2.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "shangchengdingdanDetailViewController.h"
#import "Shouhudizhi_Model.h"

#import "chanpingxiangqingViewController.h"

@interface shangchengdingdanDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) UIView * view_bg;

@property (nonatomic, strong) UILabel * name;
@property (nonatomic, strong) UILabel * tel;
@property (nonatomic, strong) UILabel * address;

@property (nonatomic, copy) NSString * str1;
@property (nonatomic, copy) NSString * str2;
@property (nonatomic, copy) NSString * str3;


@end

@implementation shangchengdingdanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SVProgressHUD showWithStatus:@"加载订单中,请稍等..." ];
    
    [self p_data];
    
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
    _lblTitle.text = @"订单详情";
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
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    [self p_footView];
    self.tableView.tableFooterView = self.view_bg;
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - dibu
- (void)p_footView
{
    self.view_bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    self.view_bg.backgroundColor = [UIColor whiteColor];
    CGFloat length_x = (SCREEN_WIDTH - 50) / 2;
    
    self.name = [[UILabel alloc] init];
    self.name.frame = CGRectMake(20,  10, length_x, 25);
    //        self.name.text = @"哈啊哈";
    self.name.font = [UIFont systemFontOfSize:15];
    self.name.textColor = [UIColor grayColor];
    [self.view_bg addSubview:self.name];
    
    
    self.tel = [[UILabel alloc] init];
    self.tel.frame = CGRectMake(CGRectGetMaxX(self.name.frame) + 10, 10, length_x, 25);
    //self.tel.text = @"1888888888888";
    self.tel.textAlignment = NSTextAlignmentRight;
    self.tel.textColor = [UIColor grayColor];
    [self.view_bg addSubview:self.tel];
    
    
    self.address = [[UILabel alloc] init];
    self.address.frame = CGRectMake(20, CGRectGetMaxY(self.name.frame) + 13, SCREEN_WIDTH - 40, 34);
    //self.address.text = @"山东省临沂市山东省临沂市山东省临沂市山东省临沂市";
    self.address.font = [UIFont systemFontOfSize:14];
    self.address.numberOfLines = 2;
    self.address.textColor = [UIColor grayColor];
    [self.view_bg addSubview:self.address];
    
    if([self.str1 length] == 0)
    {
        self.name.text = self.str1;
    }

    if([self.str2 length] == 0)
    {
        self.tel.text = self.str2;
    }

    if([self.str3 length] == 0)
    {
        self.address.text = self.str3;
    }
    
}

#pragma mark - tableview代理

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7 + self.arr_list.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 60;
    }
    else if(indexPath.row == 1 || indexPath.row == self.arr_list.count + 2 || indexPath.row == self.arr_list.count + 3 || indexPath.row == self.arr_list.count + 4)
    {
        return 50;
    }
    else if(indexPath.row == self.arr_list.count + 5)
    {
        return 50;
    }
    else if(indexPath.row == self.arr_list.count + 6)
    {
        return 40;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView * viewline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        viewline.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [cell addSubview:viewline];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + 5, 80, 30)];
        label.text = @"订单编号:";
        [cell addSubview:label];
        
        UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) , 15, SCREEN_WIDTH - 110, 30)];
        name.textColor = [UIColor grayColor];
        name.text = self.model_all.order_number;
        [cell addSubview:name];
        
        UIView * viewline1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 10)];
        viewline1.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [cell addSubview:viewline1];
    }
    else if(indexPath.row == 1)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12.5, 25, 25)];
        image.image = [UIImage imageNamed:@"01dian_07"];
        
        [cell addSubview:image];
        
        UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(image.frame) - 110, 30)];
        name.text = [NSString stringWithFormat:@"%@",self.model_all.shop_name];
        name.font = [UIFont systemFontOfSize:16];
        [cell addSubview:name];
    }
    else if(indexPath.row == self.arr_list.count + 2)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UILabel * price = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 10, 90, 30)];
        price.textColor = [UIColor orangeColor];
        price.font = [UIFont systemFontOfSize:15];
        [cell addSubview:price];
        
        price.text = [NSString stringWithFormat:@"¥ %@",self.model_all.orders_total];
        
        UILabel * sum = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90 - 5 - 40, 10, 40, 30)];
        sum.text = @"合计:";
        sum.font = [UIFont systemFontOfSize:15];
        [cell addSubview:sum];
    }
    else if(indexPath.row == self.arr_list.count + 3)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 30)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"配送方式";
        [cell addSubview:label];

        UILabel * distribution = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 100, 10, 100, 30)];
        distribution.textAlignment = NSTextAlignmentRight;
        distribution.font = [UIFont systemFontOfSize:15];
        [cell addSubview:distribution];
        
        switch ([self.model_all.shipping_method integerValue])
        {
            case 1:
            {
                distribution.text = @"物流配送";
            }
                break;
            case 2:
            {
                distribution.text = @"到店自取";
            }
                break;
            case 3:
            {
                distribution.text = @"同城派送";
            }
                break;
            default:
                break;
        }
    }
    else if(indexPath.row == self.arr_list.count + 4)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 30)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"买家留言:";
        //        label.backgroundColor = [UIColor orangeColor];
        [cell addSubview:label];
        
        UILabel * text = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) , 11, SCREEN_WIDTH - 100 - 10, 30)];
        text.textAlignment = NSTextAlignmentRight;
        text.text = self.model_all.leave_word;
        text.font = [UIFont systemFontOfSize:15];
        
        [cell addSubview:text];
    }
    else if(indexPath.row == self.arr_list.count + 5)
    {
        UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
//        name.textColor = [UIColor grayColor];
        name.text = @"联系方式";
        name.font=[UIFont systemFontOfSize:15];
        name.textAlignment = NSTextAlignmentRight;
        [cell addSubview:name];
        
        UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 10, 1, 30)];
        view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [cell addSubview:view_line];
        
        
        UIView * view_call = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 0, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 10, 50)];
        //            view_call.backgroundColor = [UIColor orangeColor];
        [cell addSubview:view_call];
        
        UIImageView * image_ = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 15, 10, 30, 30)];
        image_.image = [UIImage imageNamed:@"yijianbohao"];
        //            image_.backgroundColor = [UIColor orangeColor];
        [cell addSubview:image_];
        
        UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image_.frame) , 10, 70, 30)];
        detail.textColor = navi_bar_bg_color;
        detail.text = @"一键拨号";
        
        [cell addSubview:detail];
    }
    else if(indexPath.row == self.arr_list.count + 6)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView * viewline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        viewline.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [cell addSubview:viewline];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 30)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"收货信息";
        [cell addSubview:label];
    }
    
    else
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        DINGDAN_Model * model = self.arr_list[indexPath.row - 2];
        
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if(indexPath.row == 0 || indexPath.row == 1 || indexPath.row == self.arr_list.count + 2 || indexPath.row == self.arr_list.count + 3 || indexPath.row == self.arr_list.count + 4)
    {
        
    }
    else if(indexPath.row == self.arr_list.count + 5)
    {
//        _model_all;
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"是否拨打商户电话" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * action_Cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action_Cancel];
        UIAlertAction * action_MakeCall=[UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model_all.shop_tel]]];
        }];
        [alert addAction:action_MakeCall];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
//        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        if(self.arr_list.count != 0)
        {
            
            DINGDAN_Model * model = self.arr_list[indexPath.row - 2];
            
            chanpingxiangqingViewController * chanpingxiangqing = [[chanpingxiangqingViewController alloc] init];

            chanpingxiangqing.production_id = model.production_id;

            [self showViewController:chanpingxiangqing sender:nil];
        }
    }
    
    
}

#pragma mark - 数据
- (void)p_data
{
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"update:"];
    
    [dataprovider getAddressesWithaddress_id:self.model_all.address_id];
}

#pragma mark - 取消，收货数据
- (void)update:(id )dict
{
//    NSLog(@"%@",dict);
    [SVProgressHUD dismiss];
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSArray * arr = dict[@"data"][@"addresslist"];

            Shouhudizhi_Model * model = [[Shouhudizhi_Model alloc] init];
            [model setValuesForKeysWithDictionary:arr.firstObject];
            
            NSString * str = [NSString stringWithFormat:@"%@%@%@%@",[model.province_name length]== 0 ? @"" : model.province_name,[model.city_name length]== 0 ? @"" : model.city_name,[model.area_name length]== 0 ? @"" : model.area_name ,[model.address length]== 0 ? @"" : model.address];
            
            self.name.text = model.area;
            self.tel.text = model.mobile;
            self.address.text = str;
            
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
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] ];
    }
}




@end

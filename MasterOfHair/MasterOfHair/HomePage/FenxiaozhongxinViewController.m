
//
//  FenxiaozhongxinViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/29.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "FenxiaozhongxinViewController.h"

#import "FenxiaozhongxinTableViewCell.h"
#import "NextFenxiaozhongxinViewController.h"
#import "NextFenxiaozhongxin1ViewController.h"
#import "FenxiaoDetialViewController.h"
#import "UMSocial.h"



@interface FenxiaozhongxinViewController () <UITableViewDelegate, UITableViewDataSource,UMSocialUIDelegate>

@property (nonatomic, strong) UITableView * tableView;

//头视图
@property (nonatomic, strong) UIView * head_View;
@property (nonatomic, strong) UIImageView * head_image;
@property (nonatomic, strong) UILabel * head_ID;

@property (nonatomic, strong) UILabel * num_sell;
@property (nonatomic, strong) UILabel * num_commission;

@property (nonatomic, copy) NSString * level1;
@property (nonatomic, copy) NSString * level2;
@property (nonatomic, copy) NSString * no_pay_order_brokerage;
@property (nonatomic, copy) NSString * pay_order_brokerage;
@property (nonatomic, copy) NSString * receive_order_brokerage;

@property (nonatomic, copy) NSString * wallet_balance;

@end

@implementation FenxiaozhongxinViewController
{
    UILabel * lbl_ketixianyue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD showWithStatus:@"正在加载数据..."  ];
    
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
    _lblTitle.text = [NSString stringWithFormat:@"分销中心"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    _lblLeft.text=@"返回";
    _lblLeft.textAlignment=NSTextAlignmentLeft;
    [self addRightbuttontitle:@"分享"];
}
-(void)clickRightButton:(UIButton *)sender
{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56e8cf6867e58ea9710004b8"
                                      shareText:@"快来下载剃头匠"
                                     shareImage:[UIImage imageNamed:@"sudisudiusidusidu"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,nil]
                                       delegate:self];
}

//返回
- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [self p_dataALL1];
    
    [self p_dataALL];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStyleGrouped)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    [self p_headView];
    self.tableView.tableHeaderView = self.head_View;
    self.tableView.tableFooterView = [[UIView alloc] init];
    //注册
    [self.tableView registerClass:[FenxiaozhongxinTableViewCell class] forCellReuseIdentifier:@"cell_fenxiao"];
}

#pragma mark - 代理tableView
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 3;
    }
    else
    {
        return 4;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FenxiaozhongxinTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_fenxiao" forIndexPath:indexPath];
    
    if(indexPath.section == 0)
    {
        cell.image.image = [UIImage imageNamed:@"woeiqwoeiowio"];
        if(indexPath.row == 0)
        {
            cell.name.text = @"一级会员";
//            cell.number.text = @"110人";
            cell.price.hidden = YES;
            
            if([self.level1 length] == 0)
            {
                cell.number.text = @"0人";
            }
            else
            {
                cell.number.text = [NSString stringWithFormat:@"%@人",self.level1];
            }
        }
        else if(indexPath.row==1)
        {
            cell.name.text = @"二级会员";
//            cell.number.text = @"11人";
            cell.price.hidden = YES;
            
            if([self.level2 length] == 0)
            {
                cell.number.text = @"0人";
            }
            else
            {
                cell.number.text = [NSString stringWithFormat:@"%@人",self.level2];
            }
        }
        else
        {
            cell.name.hidden=YES;
            cell.price.hidden=YES;
            cell.number.hidden=YES;
            cell.image_icon.hidden=YES;
            cell.image.hidden=YES;
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 1, 4, 2, 40)];
            view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [cell addSubview:view_line];
            CGFloat lenth_x = (SCREEN_WIDTH - 2) / 2;
            
            
            if (!self.num_sell) {
                UILabel * label_1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 9, 70, 30)];
                label_1.text = @"累计销售额:";
                label_1.font = [UIFont systemFontOfSize:13];
                //    label_1.backgroundColor = [UIColor orangeColor];
                [cell addSubview:label_1];
                self.num_sell = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_1.frame) + 5, 9, lenth_x - CGRectGetMaxX(label_1.frame) - 10, 30)];
                //    self.num_sell.backgroundColor = [UIColor orangeColor];
                self.num_sell.text = @"2";
                self.num_sell.textColor = [UIColor orangeColor];
                self.num_sell.font = [UIFont systemFontOfSize:13];
            }
            [cell addSubview:self.num_sell];
            
            if (!self.num_commission) {
                UILabel * label_2 = [[UILabel alloc] initWithFrame:CGRectMake(15 + CGRectGetMaxX(view_line.frame), 9, 70, 30)];
                label_2.text = @"累计佣金:";
                label_2.textAlignment = NSTextAlignmentCenter;
                label_2.font = [UIFont systemFontOfSize:13];
                //    label_1.backgroundColor = [UIColor orangeColor];
                [cell addSubview:label_2];
                
                self.num_commission = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 +85, 9, lenth_x - 91, 30)];
                //        self.num_commission.backgroundColor = [UIColor orangeColor];
                self.num_commission.text = @"333";
                self.num_commission.textColor = [UIColor orangeColor];
                self.num_commission.font = [UIFont systemFontOfSize:13];
            }
            [cell addSubview:self.num_commission];
        }
    }
    else
    {
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.image.image = [UIImage imageNamed:@"122323232323"];
        switch (indexPath.row) {
            case 0:
            {
                cell.name.text = @"我的累计佣金";
                cell.price.text = @"¥ 5112";
                cell.price.hidden=YES;
                cell.image_icon.hidden = YES;
                cell.number.hidden = NO;
                
                if([get_sp(@"member_brokerage") length] == 0)
                {
                    cell.number.text = @"¥ 0";
                }
                else
                {
                    cell.number.text = [NSString stringWithFormat:@"￥ %@",get_sp(@"member_brokerage")];
                }
            }
                break;
            case 1:
            {
                cell.name.text = @"未付款订单佣金";
                cell.price.text = @"¥ 1112";
                cell.price.hidden=YES;
                cell.image_icon.hidden = NO;
                cell.number.hidden = NO;
                
                if([self.no_pay_order_brokerage length] == 0)
                {
                    cell.number.text = @"¥ 0";
                }
                else
                {
                    cell.number.text = [NSString stringWithFormat:@"￥ %@",self.no_pay_order_brokerage];
                }
            }
                break;
            case 2:
            {
                cell.name.text = @"已付款订单佣金";
                cell.price.text = @"¥ 112";
                cell.price.hidden=YES;
                cell.image_icon.hidden = NO;
                cell.number.hidden = NO;
                
                if([self.pay_order_brokerage length] == 0)
                {
                    cell.number.text = @"¥ 0";
                }
                else
                {
                    cell.number.text = [NSString stringWithFormat:@"￥ %@",self.pay_order_brokerage];
                }
            }
                break;
            case 3:
            {
                cell.name.text = @"已收货订单佣金";
                cell.price.text = @"¥ 1312";
                cell.price.hidden=YES;
                cell.image_icon.hidden = NO;
                cell.number.hidden = NO;
                
                if([self.receive_order_brokerage length] == 0)
                {
                    cell.number.text = @"¥ 0";
                }
                else
                {
                    cell.number.text = [NSString stringWithFormat:@"￥ %@",self.receive_order_brokerage];
                }
            }
                break;
            
            default:
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            NextFenxiaozhongxinViewController * nextFenxiaozhongxinViewController = [[NextFenxiaozhongxinViewController alloc] init];
            
            [self showViewController:nextFenxiaozhongxinViewController sender:nil];
        }
        else if(indexPath.row==1)
        {
            NextFenxiaozhongxin1ViewController * nextFenxiaozhongxin1ViewController = [[NextFenxiaozhongxin1ViewController alloc] init];
            
            [self showViewController:nextFenxiaozhongxin1ViewController sender:nil];
        }
        else
        {
        }
    }else if (indexPath.section==1)
    {
        if (indexPath.row!=0) {
            FenxiaoDetialViewController * fenxiaoDetial=[[FenxiaoDetialViewController alloc] init];
            
            fenxiaoDetial.member_id=get_sp(@"member_id");
            
            switch (indexPath.row) {
                case 1:
                    fenxiaoDetial.Order_stute=@"1";
                    break;
                case 2:
                    fenxiaoDetial.Order_stute=@"2";
                    break;
                case 3:
                    fenxiaoDetial.Order_stute=@"4";
                    break;
                default:
                    break;
            }
            
            fenxiaoDetial.member_level=@"0";
            
            [self showViewController:fenxiaoDetial sender:nil ];
        }
        
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 30;
    }
    else
    {
        return 17;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"会员中心";
    }
    else
    {
        return @"我的佣金";
    }
}

#pragma mark - headView

- (void)p_headView
{
    self.head_View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 125)];
    self.head_View.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView * view_white = [[UIView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 120)];
    view_white.backgroundColor = [UIColor whiteColor];
    [self.head_View addSubview:view_white];
    
    
    self.head_image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 70, 70)];
//    self.head_image.backgroundColor = [UIColor orangeColor];
    self.head_image.layer.cornerRadius = 35;
    self.head_image.layer.masksToBounds = YES;
    [view_white addSubview:self.head_image];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.head_image.frame) + 10, CGRectGetMinY(self.head_image.frame), 60, 25)];
    label1.text = @"推广 ID:";
//    label1.backgroundColor = [UIColor orangeColor];
    label1.font = [UIFont systemFontOfSize:15];
    [view_white addSubview:label1];
    
    self.head_ID = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 5, CGRectGetMinY(self.head_image.frame), SCREEN_WIDTH - CGRectGetMaxX(label1.frame) - 15, 25)];
    self.head_ID.text = get_sp(@"member_username");
//    self.head_ID.backgroundColor = [UIColor orangeColor];
    self.head_ID.font = [UIFont systemFontOfSize:15];
    [view_white addSubview:self.head_ID];
    
    
    UIImageView * image_1 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.head_image.frame) + 10, CGRectGetMaxY(label1.frame) + 10, 30, 30)];
//    image_1.backgroundColor = [UIColor orangeColor];
    image_1.image = [UIImage imageNamed:@"05zuanshi1_03"];
    [view_white addSubview:image_1];
    
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image_1.frame) + 5, CGRectGetMinY(image_1.frame) + 4, 80, 22)];
    label2.backgroundColor = [UIColor whiteColor];
    label2.layer.cornerRadius = 5;
    label2.layer.borderColor = [UIColor orangeColor].CGColor;
    label2.layer.borderWidth = 1;
    label2.text = @"金卡会员";
    label2.textColor = [UIColor orangeColor];
    label2.font = [UIFont systemFontOfSize:15];
    label2.textAlignment = NSTextAlignmentCenter;
    [view_white addSubview:label2];
    
    
    lbl_ketixianyue=[[UILabel alloc] initWithFrame:CGRectMake(image_1.frame.origin.x, CGRectGetMaxY(label2.frame)+10, SCREEN_WIDTH-image_1.frame.origin.x-20, 20)];
    
    lbl_ketixianyue.text=@"可提现余额:￥0.00";
    lbl_ketixianyue.font=[UIFont systemFontOfSize:15];
    [view_white addSubview:lbl_ketixianyue];
    
}

#pragma mark - 数据数据
- (void)p_dataALL
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"StatisticalData:"];
    
    [dataprovider StatisticalDataWithMember_id:[userdefault objectForKey:@"member_id"]];
}

// 数据
- (void)StatisticalData:(id )dict
{
//    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSDictionary * dic = dict[@"data"][@"accumulative_info"];
            
            self.num_sell.text = [NSString stringWithFormat:@"￥ %@",dic[@"total_consume"]];
            self.num_commission.text = [NSString stringWithFormat:@"￥ %@",dic[@"total_brokerage"]];
            
            self.level1 = [NSString stringWithFormat:@"%@",dic[@"level1"]];
            self.level2 = [NSString stringWithFormat:@"%@",dic[@"level2"]];

            
            NSDictionary * dic1 = dict[@"data"][@"my_brokerage"];
            self.no_pay_order_brokerage = [NSString stringWithFormat:@"%@",dic1[@"no_pay_order_brokerage"]];
            self.pay_order_brokerage = [NSString stringWithFormat:@"%@",dic1[@"pay_order_brokerage"]];
            self.receive_order_brokerage = [NSString stringWithFormat:@"%@",dic1[@"receive_order_brokerage"]];
            
            lbl_ketixianyue.text=[NSString stringWithFormat:@"可提现余额:￥%@",self.wallet_balance];
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

#pragma mark - 数据数据
- (void)p_dataALL1
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"GetMembers:"];
    
    [dataprovider GetMembersWithMember_id:[userdefault objectForKey:@"member_id"]];
}

// 数据
- (void)GetMembers:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSArray * arr_ = dict[@"data"][@"memberlist"];
            
            NSDictionary * dic = arr_.firstObject;
            
            [self.head_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/member/%@",Url_pic,dic[@"member_headpic"]]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];

            if([dic[@"spread_id"] length] == 0 || [dic[@"spread_id"] isEqual:[NSNull null]])
            {
                self.head_ID.text = get_sp(@"member_username");
            }
            else
            {
                self.head_ID.text = [NSString stringWithFormat:@"%@",dic[@"spread_id"]];
            }
            
            self.wallet_balance = [NSString stringWithFormat:@"%@",dic[@"wallet_balance"]];
            
            
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

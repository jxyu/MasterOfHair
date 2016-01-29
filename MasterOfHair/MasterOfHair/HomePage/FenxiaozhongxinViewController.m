
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
@interface FenxiaozhongxinViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

//头视图
@property (nonatomic, strong) UIView * head_View;
@property (nonatomic, strong) UIImageView * head_image;
@property (nonatomic, strong) UILabel * head_ID;

@property (nonatomic, strong) UILabel * num_sell;
@property (nonatomic, strong) UILabel * num_commission;


@end

@implementation FenxiaozhongxinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        return 2;
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
            cell.number.text = @"110人";
            cell.price.hidden = YES;
        }
        else
        {
            cell.name.text = @"二级会员";
            cell.number.text = @"11人";
            cell.price.hidden = YES;
        }
    }
    else
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.image.image = [UIImage imageNamed:@"122323232323"];
        switch (indexPath.row) {
            case 0:
            {
                cell.name.text = @"未付款订单佣金";
                cell.price.text = @"¥ 1112";
                cell.image_icon.hidden = YES;
                cell.number.hidden = YES;
            }
                break;
            case 1:
            {
                cell.name.text = @"已付款订单佣金";
                cell.price.text = @"¥ 112";
                cell.image_icon.hidden = YES;
                cell.number.hidden = YES;
            }
                break;
            case 2:
            {
                cell.name.text = @"已收货订单佣金";
                cell.price.text = @"¥ 1312";
                cell.image_icon.hidden = YES;
                cell.number.hidden = YES;
            }
                break;
            case 3:
            {
                cell.name.text = @"可提现余额";
                cell.price.text = @"¥ 5112";
                cell.image_icon.hidden = YES;
                cell.number.hidden = YES;
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
        else
        {
            NextFenxiaozhongxin1ViewController * nextFenxiaozhongxin1ViewController = [[NextFenxiaozhongxin1ViewController alloc] init];
            
            [self showViewController:nextFenxiaozhongxin1ViewController sender:nil];
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
    self.head_View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    self.head_View.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView * view_white = [[UIView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 90)];
    view_white.backgroundColor = [UIColor whiteColor];
    [self.head_View addSubview:view_white];
    
    
    self.head_image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 70, 70)];
    self.head_image.backgroundColor = [UIColor orangeColor];
    self.head_image.layer.cornerRadius = 35;
    [view_white addSubview:self.head_image];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.head_image.frame) + 10, CGRectGetMinY(self.head_image.frame), 60, 25)];
    label1.text = @"推广 ID:";
//    label1.backgroundColor = [UIColor orangeColor];
    label1.font = [UIFont systemFontOfSize:15];
    [view_white addSubview:label1];
    
    self.head_ID = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 5, CGRectGetMinY(self.head_image.frame), SCREEN_WIDTH - CGRectGetMaxX(label1.frame) - 15, 25)];
    self.head_ID.text = @"1234567890";
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
    
    
    UIView * view_white1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_white.frame) + 5, SCREEN_WIDTH, 48)];
    view_white1.backgroundColor = [UIColor whiteColor];
    [self.head_View addSubview:view_white1];
    
    
    UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 1, 4, 2, 40)];
    view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view_white1 addSubview:view_line];
    
    CGFloat lenth_x = (SCREEN_WIDTH - 2) / 2;
    
    
    UILabel * label_1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 9, 70, 30)];
    label_1.text = @"累计销售额:";
    label_1.font = [UIFont systemFontOfSize:13];
//    label_1.backgroundColor = [UIColor orangeColor];
    [view_white1 addSubview:label_1];
    
    self.num_sell = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_1.frame) + 5, 9, lenth_x - CGRectGetMaxX(label_1.frame) - 10, 30)];
//    self.num_sell.backgroundColor = [UIColor orangeColor];
    self.num_sell.text = @"¥ 1000.00";
    self.num_sell.textColor = [UIColor orangeColor];
    self.num_sell.font = [UIFont systemFontOfSize:13];
    [view_white1 addSubview:self.num_sell];
    
    
    
    UILabel * label_2 = [[UILabel alloc] initWithFrame:CGRectMake(15 + CGRectGetMaxX(view_line.frame), 9, 70, 30)];
    label_2.text = @"累计佣金:";
    label_2.textAlignment = NSTextAlignmentCenter;
    label_2.font = [UIFont systemFontOfSize:13];
    //    label_1.backgroundColor = [UIColor orangeColor];
    [view_white1 addSubview:label_2];
    
    self.num_commission = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_2.frame) + 1, 9, lenth_x - CGRectGetMaxX(label_1.frame) - 5, 30)];
//        self.num_commission.backgroundColor = [UIColor orangeColor];
    self.num_commission.text = @"¥ 1000.00";
    self.num_commission.textColor = [UIColor orangeColor];
    self.num_commission.font = [UIFont systemFontOfSize:13];
    [view_white1 addSubview:self.num_commission];
    
    
}



@end

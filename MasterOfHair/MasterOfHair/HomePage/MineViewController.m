//
//  MineViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/19.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "MineViewController.h"

#import "JCMineTableViewCell.h"
#import "SettingViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
@interface MineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

//头视图
@property (nonatomic, strong) UIView * head_view;
@property (nonatomic, strong) UIImageView * head_image;
@property (nonatomic, strong) UILabel * head_name;

@property (nonatomic, strong) UIImageView * head_diamond;
@property (nonatomic, strong) UIImageView * head_delegate;

@property (nonatomic, strong) UIButton * head_vip;
@property (nonatomic, strong) UIButton * head_edit;
@property (nonatomic, strong) UIButton * head_cancel;

//登陆
@property (nonatomic, strong) UIButton * head_login;

//3个btn
@property (nonatomic, strong) UIButton * mid_btn1;
@property (nonatomic, strong) UIButton * mid_btn2;
@property (nonatomic, strong) UIButton * mid_btn3;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
    _lblTitle.text = @"个人中心";
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addRightbuttontitle:@"设置"];
}
//点击设置按钮
- (void)clickRightButton:(UIButton *)sender
{
    SettingViewController * settingViewController = [[SettingViewController alloc] init];
    
    [self showViewController:settingViewController sender:nil];
}

//显示tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showTabBar];
}

#pragma mark - 总布局
- (void)p_setupView
{
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.tableView];
    
    //注册
    [self.tableView registerClass:[JCMineTableViewCell class] forCellReuseIdentifier:@"cell_mine"];
    
    //头视图
//    [self p_headView];
    
    [self p_headView1];
    
    self.tableView.tableHeaderView = self.head_view;
}

#pragma mark - 布局头视图
//这个为登陆状态的头布局
- (void)p_headView
{
    self.head_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    self.head_view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView * view_white = [[UIView alloc] initWithFrame:CGRectMake(0, 7, SCREEN_WIDTH, 120)];
    view_white.backgroundColor = [UIColor whiteColor];
    [self.head_view addSubview:view_white];
    
    self.head_image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 90, 90)];
    self.head_image.layer.cornerRadius = 45;
    self.head_image.layer.masksToBounds = YES;
    self.head_image.backgroundColor = [UIColor orangeColor];
    [view_white addSubview:self.head_image];
    
    UILabel * label_1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.head_image.frame) + 10, CGRectGetMinY(self.head_image.frame) + 3, 40, 20)];
    label_1.text = @"昵称:";
    label_1.font = [UIFont systemFontOfSize:15];
    [view_white addSubview:label_1];
    
    self.head_name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_1.frame) + 5, CGRectGetMinY(label_1.frame), SCREEN_WIDTH - CGRectGetMaxX(label_1.frame) - 15, 20)];
    self.head_name.font = [UIFont systemFontOfSize:15];
    self.head_name.text = @"18888888888888";
    //    self.head_name.backgroundColor = [UIColor orangeColor];
    [view_white addSubview:self.head_name];
    
    self.head_diamond = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(label_1.frame), CGRectGetMaxY(label_1.frame) + 8, 28, 28)];
    self.head_diamond.backgroundColor = [UIColor orangeColor];
    [view_white addSubview:self.head_diamond];
    
    self.head_vip = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.head_vip.frame = CGRectMake(CGRectGetMaxX(self.head_diamond.frame) + 10, CGRectGetMaxY(label_1.frame) + 8, 70, 28);
    self.head_vip.backgroundColor = [UIColor orangeColor];
    [view_white addSubview:self.head_vip];
    
    self.head_delegate = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.head_vip.frame) + 5, CGRectGetMaxY(label_1.frame) + 8, 60, 28)];
    self.head_delegate.backgroundColor = [UIColor orangeColor];
    [view_white addSubview:self.head_delegate];
    
    
    CGFloat length_x = (SCREEN_WIDTH - CGRectGetMinX(label_1.frame) - 45) / 2;
    
    self.head_edit = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.head_edit.frame = CGRectMake(CGRectGetMinX(label_1.frame), CGRectGetMaxY(self.head_vip.frame) + 8, length_x, 25 * (SCREEN_WIDTH / 320));
    self.head_edit.backgroundColor = [UIColor orangeColor];
    [view_white addSubview:self.head_edit];
    
    self.head_cancel = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.head_cancel.frame = CGRectMake(CGRectGetMaxX(self.head_edit.frame) + 20, CGRectGetMinY(self.head_edit.frame), length_x, 25 * (SCREEN_WIDTH / 320));
    self.head_cancel.backgroundColor = [UIColor orangeColor];
    [view_white addSubview:self.head_cancel];
    
    
    UIView * view_mid = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_white.frame) + 5, SCREEN_WIDTH, 60)];
    view_mid.backgroundColor = [UIColor whiteColor];
    [self.head_view addSubview:view_mid];
    
    int length_x1 = (SCREEN_WIDTH - 2) / 15;
    
    self.mid_btn1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.mid_btn1.frame = CGRectMake(1, 0, length_x1 * 4, 60);
    self.mid_btn1.backgroundColor = [UIColor redColor];
    [view_mid addSubview:self.mid_btn1];
    
    self.mid_btn2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.mid_btn2.frame = CGRectMake(CGRectGetMaxX(self.mid_btn1.frame) + 1, 0, length_x1 * 6, 60);
    self.mid_btn2.backgroundColor = [UIColor cyanColor];
    [view_mid addSubview:self.mid_btn2];
    
    self.mid_btn3 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.mid_btn3.frame = CGRectMake(CGRectGetMaxX(self.mid_btn2.frame) + 1, 0, SCREEN_WIDTH - CGRectGetMaxX(self.mid_btn2.frame) - 2, 60);
    self.mid_btn3.backgroundColor = [UIColor orangeColor];
    [view_mid addSubview:self.mid_btn3];
}

//这个为非登陆状态的头布局
- (void)p_headView1
{
    self.head_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    self.head_view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView * view_white = [[UIView alloc] initWithFrame:CGRectMake(0, 7, SCREEN_WIDTH, 120)];
    view_white.backgroundColor = [UIColor whiteColor];
    [self.head_view addSubview:view_white];
    
    self.head_image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 90, 90)];
    self.head_image.layer.cornerRadius = 45;
    self.head_image.layer.masksToBounds = YES;
    self.head_image.backgroundColor = [UIColor orangeColor];
    [view_white addSubview:self.head_image];
    
    UILabel * label_title = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.head_image.frame) + 15, CGRectGetMinY(self.head_image.frame) + 15, SCREEN_WIDTH - CGRectGetMaxX(self.head_image.frame) - 25, 20)];
    label_title.text = @"欢迎进入个人中心页面!";
    //    label_title.backgroundColor = [UIColor orangeColor];
    label_title.font = [UIFont systemFontOfSize:17];
    [view_white addSubview:label_title];
    
    self.head_login = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.head_login.frame = CGRectMake(CGRectGetMinX(label_title.frame), CGRectGetMaxY(label_title.frame) + 15, SCREEN_WIDTH / 3.5, 30 * SCREEN_WIDTH /375);
    self.head_login.backgroundColor = [UIColor orangeColor];
    [view_white addSubview:self.head_login];
    [self.head_login addTarget:self action:@selector(head_loginAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIView * view_mid = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_white.frame) + 5, SCREEN_WIDTH, 60)];
    view_mid.backgroundColor = [UIColor whiteColor];
    [self.head_view addSubview:view_mid];
    
    int length_x1 = (SCREEN_WIDTH - 2) / 15;
    
    self.mid_btn1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.mid_btn1.frame = CGRectMake(1, 0, length_x1 * 4, 60);
    self.mid_btn1.backgroundColor = [UIColor redColor];
    [view_mid addSubview:self.mid_btn1];
    
    self.mid_btn2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.mid_btn2.frame = CGRectMake(CGRectGetMaxX(self.mid_btn1.frame) + 1, 0, length_x1 * 6, 60);
    self.mid_btn2.backgroundColor = [UIColor cyanColor];
    [view_mid addSubview:self.mid_btn2];
    
    self.mid_btn3 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.mid_btn3.frame = CGRectMake(CGRectGetMaxX(self.mid_btn2.frame) + 1, 0, SCREEN_WIDTH - CGRectGetMaxX(self.mid_btn2.frame) - 2, 60);
    self.mid_btn3.backgroundColor = [UIColor orangeColor];
    [view_mid addSubview:self.mid_btn3];
}

#pragma mark - login
- (void)head_loginAction:(UIButton *)sender
{
    LoginViewController * loginViewController = [[LoginViewController alloc] init];
    
    [self showViewController:loginViewController sender:nil];
}

#pragma mark - tableView的代理
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JCMineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_mine" forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
        {
            if(indexPath.row == 0)
            {
                cell.name.text = @"纹绣联盟订单";
                //                cell.image.image = [UIImage imageNamed:@""];
                cell.arrows_switch.hidden = YES;
            }
            else
            {
                cell.name.text = @"商城订单";
                //                cell.image.image = [UIImage imageNamed:@""];
                cell.arrows_switch.hidden = YES;
            }
        }
            break;
        case 1:
        {
            if(indexPath.row == 0)
            {
                cell.name.text = @"收藏的产品";
                //                cell.image.image = [UIImage imageNamed:@""];
                cell.arrows_switch.hidden = YES;
            }
            else if(indexPath.row == 1)
            {
                cell.name.text = @"收藏的视频";
                //                cell.image.image = [UIImage imageNamed:@""];
                cell.arrows_switch.hidden = YES;
            }
            else
            {
                cell.name.text = @"收藏的图文";
                //                cell.image.image = [UIImage imageNamed:@""];
                cell.arrows_switch.hidden = YES;
            }
        }
            break;
        case 2:
        {
            cell.name.text = @"申请成为代理商";
            //                cell.image.image = [UIImage imageNamed:@""];
            cell.arrows_switch.hidden = YES;
        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//设置头标题文字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"我的订单";
            break;
        case 1:
            return @"我的收藏";
            break;
        case 2:
            return @"申请加盟";
            break;
        default:
            return nil;
            break;
    }
}
//设置头标题高度
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 35;
    }
    else
    {
        return 13;
    }
}


@end

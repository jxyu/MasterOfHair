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

#import "cishanjijinhuiViewController.h"
#import "FenxiaozhongxinViewController.h"
#import "QianbaoViewController.h"
#import "ShenqingdailishangViewController.h"
#import "JinkahuiyuanViewController.h"

#import "ChanpinshoucangViewController.h"
#import "ShipinshoucangViewController.h"
#import "TuwenshoucangViewController.h"

@interface MineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

//头视图
@property (nonatomic, strong) UIView * head_view;
@property (nonatomic, strong) UIImageView * head_image;
@property (nonatomic, strong) UILabel * head_name;

@property (nonatomic, strong) UIImageView * head_diamond;
@property (nonatomic, strong) UILabel * head_delegate;

@property (nonatomic, strong) UIButton * head_vip;
@property (nonatomic, strong) UIButton * head_edit;
@property (nonatomic, strong) UIButton * head_cancel;

@property (nonatomic, strong) UIView * head_view_white;
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
    
//    [self p_setupView];
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
    
    [self p_setupView];
    
    [self.tableView reloadData];
    
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
    
    //判断是否处于登陆状态
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    if([[userdefault objectForKey:@"Login_Success"] isEqualToString:@"1"])
    {//头视图
        [self p_headView];
    }
    else
    {
        [self p_headView1];

    }
    self.tableView.tableHeaderView = self.head_view;
}

#pragma mark - 布局头视图
//这个为登陆状态的头布局
- (void)p_headView
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    self.head_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    self.head_view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView * view_white = [[UIView alloc] initWithFrame:CGRectMake(0, 7, SCREEN_WIDTH, 120)];
    view_white.backgroundColor = [UIColor whiteColor];
    [self.head_view addSubview:view_white];
    
    self.head_image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 90, 90)];
    self.head_image.layer.cornerRadius = 45;
    self.head_image.layer.masksToBounds = YES;
//    self.head_image.backgroundColor = [UIColor orangeColor];
    [view_white addSubview:self.head_image];
    
//    NSLog(@"%@",[userdefault objectForKey:@"member_headpic"]);
    if([[userdefault objectForKey:@"member_headpic"] length] == 0)
    {
        self.head_image.image = [UIImage imageNamed:@"placeholder_short.jpg"];
    }
    else
    {
        [self.head_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@appbackend/uploads/member/%@",Url,[userdefault objectForKey:@"member_headpic"]]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
    }
    
    
    UILabel * label_1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.head_image.frame) + 10, CGRectGetMinY(self.head_image.frame) + 3, 40, 20)];
    label_1.text = @"昵称:";
    label_1.font = [UIFont systemFontOfSize:15];
    [view_white addSubview:label_1];
    
    self.head_name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_1.frame) + 5, CGRectGetMinY(label_1.frame), SCREEN_WIDTH - CGRectGetMaxX(label_1.frame) - 15, 20)];
    self.head_name.font = [UIFont systemFontOfSize:15];
    self.head_name.text = @"18888888888888";
    //    self.head_name.backgroundColor = [UIColor orangeColor];
    [view_white addSubview:self.head_name];
    
//    NSLog(@"%@",[userdefault objectForKey:@"member_nickname"]);
    if([[userdefault objectForKey:@"member_nickname"] length] == 0 || [[userdefault objectForKey:@"member_nickname"] isEqualToString:@"<null>"])
    {
        self.head_name.text = [userdefault objectForKey:@"account"];
    }
    else
    {
        self.head_name.text = [userdefault objectForKey:@"member_nickname"];
    }
    
    
    self.head_diamond = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(label_1.frame), CGRectGetMaxY(label_1.frame) + 8, 28, 28)];
    self.head_diamond.image = [UIImage imageNamed:@"05zuanshi03"];
    [view_white addSubview:self.head_diamond];
    
    self.head_vip = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.head_vip.frame = CGRectMake(CGRectGetMaxX(self.head_diamond.frame) + 3, CGRectGetMaxY(label_1.frame) + 8, 100, 28);
    self.head_vip.backgroundColor = [UIColor whiteColor];
    self.head_vip.layer.cornerRadius = 5;
    self.head_vip.layer.borderWidth = 1;
    self.head_vip.layer.borderColor = [UIColor orangeColor].CGColor;
    [self.head_vip setTitle:@"开通金卡会员" forState:(UIControlStateNormal)];
    [self.head_vip setTintColor:[UIColor orangeColor]];
    [view_white addSubview:self.head_vip];
    [self.head_vip addTarget:self action:@selector(head_vipAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.head_delegate = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.head_vip.frame) + 5, CGRectGetMaxY(label_1.frame) + 8, 60, 28)];
//    self.head_delegate.backgroundColor = [UIColor orangeColor];
    self.head_delegate.layer.borderColor = [UIColor redColor].CGColor;
    self.head_delegate.layer.borderWidth = 1;
    self.head_delegate.layer.cornerRadius = 5;
    self.head_delegate.text = @"代理商";
    self.head_delegate.textAlignment = NSTextAlignmentCenter;
    self.head_delegate.textColor = [UIColor redColor];
    [view_white addSubview:self.head_delegate];
    
    
    CGFloat length_x = (SCREEN_WIDTH - CGRectGetMinX(label_1.frame) - 45) / 2;
    
    self.head_edit = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.head_edit.frame = CGRectMake(CGRectGetMinX(label_1.frame), CGRectGetMaxY(self.head_vip.frame) + 8, length_x, 27 * (SCREEN_WIDTH / 320));
    self.head_edit.backgroundColor = [UIColor whiteColor];
    self.head_edit.layer.cornerRadius = 5;
    self.head_edit.layer.borderWidth = 1;
    self.head_edit.layer.borderColor = navi_bar_bg_color.CGColor;
    [self.head_edit setTitle:@"编辑资料" forState:(UIControlStateNormal)];
    [self.head_edit setTintColor:navi_bar_bg_color];
    [view_white addSubview:self.head_edit];
    
    self.head_cancel = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.head_cancel.frame = CGRectMake(CGRectGetMaxX(self.head_edit.frame) + 20, CGRectGetMinY(self.head_edit.frame), length_x, 27 * (SCREEN_WIDTH / 320));
    self.head_cancel.backgroundColor = [UIColor whiteColor];
    self.head_cancel.layer.cornerRadius = 5;
    self.head_cancel.layer.borderWidth = 1;
    self.head_cancel.layer.borderColor = navi_bar_bg_color.CGColor;
    [self.head_cancel setTitle:@"退出登录" forState:(UIControlStateNormal)];
    [self.head_cancel setTintColor:navi_bar_bg_color];
    [view_white addSubview:self.head_cancel];
    [self.head_cancel addTarget:self action:@selector(head_cancelAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.head_view_white = view_white;
    
    [self p_fenlei];
    
    [self.mid_btn1 addTarget:self action:@selector(mid_btn1Action:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.mid_btn2 addTarget:self action:@selector(mid_btn2Action:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.mid_btn3 addTarget:self action:@selector(mid_btn3Action:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //判断是否是会员
    switch ([[userdefault objectForKey:@"member_type"] integerValue]) {
        case 1:
        {
            self.head_diamond.image = [UIImage imageNamed:@"05zuanshi03"];
            [self.head_vip setTitle:@"开通金卡会员" forState:(UIControlStateNormal)];
            
            self.head_delegate.hidden = YES;
        }
            break;
        case 2:
        {
            self.head_diamond.image = [UIImage imageNamed:@"05zuanshi1_03"];
            [self.head_vip setTitle:@"金卡会员" forState:(UIControlStateNormal)];
            self.head_vip.userInteractionEnabled = NO;
            
            self.head_delegate.hidden = YES;
        }
            break;
        case 3:
        {
            self.head_diamond.image = [UIImage imageNamed:@"05zuanshi1_03"];
            [self.head_vip setTitle:@"金卡会员" forState:(UIControlStateNormal)];
            self.head_vip.userInteractionEnabled = NO;
        }
            break;
        default:
            break;
    }
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
//    self.head_image.backgroundColor = [UIColor orangeColor];
    self.head_image.image = [UIImage imageNamed:@"sudisudiusidusidu"];
    [view_white addSubview:self.head_image];
    
    UILabel * label_title = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.head_image.frame) + 15, CGRectGetMinY(self.head_image.frame) + 15, SCREEN_WIDTH - CGRectGetMaxX(self.head_image.frame) - 25, 20)];
    label_title.text = @"欢迎进入个人中心页面!";
    //    label_title.backgroundColor = [UIColor orangeColor];
    label_title.font = [UIFont systemFontOfSize:17];
    [view_white addSubview:label_title];
    
    self.head_login = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.head_login.frame = CGRectMake(CGRectGetMinX(label_title.frame), CGRectGetMaxY(label_title.frame) + 15, SCREEN_WIDTH / 3.5, 30 * SCREEN_WIDTH /375);
    self.head_login.backgroundColor = [UIColor whiteColor];
    self.head_login.layer.cornerRadius = 5;
    self.head_login.layer.borderColor = navi_bar_bg_color.CGColor;
    self.head_login.layer.borderWidth = 1;
    [self.head_login setTitle:@"请登录" forState:(UIControlStateNormal)];
    [self.head_login setTintColor:navi_bar_bg_color];
    [view_white addSubview:self.head_login];
    [self.head_login addTarget:self action:@selector(head_loginAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.head_view_white = view_white;
    
    [self p_fenlei];
    
    [self.mid_btn1 addTarget:self action:@selector(mid_LoginAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.mid_btn2 addTarget:self action:@selector(mid_LoginAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.mid_btn3 addTarget:self action:@selector(mid_LoginAction:) forControlEvents:(UIControlEventTouchUpInside)];

}

#pragma mark - login
- (void)head_loginAction:(UIButton *)sender
{
    LoginViewController * loginViewController = [[LoginViewController alloc] init];
    
    [self showViewController:loginViewController sender:nil];
}

#pragma mark - 头视图
//开通会员
- (void)head_vipAction:(UIButton *)sender
{
    JinkahuiyuanViewController * jinkahuiyuanViewController = [[JinkahuiyuanViewController alloc] init];
    
    [self showViewController:jinkahuiyuanViewController sender:nil];
}

//未登录时点分类
- (void)mid_LoginAction:(UIButton *)sender
{
    LoginViewController * loginViewController = [[LoginViewController alloc] init];
    [self showViewController:loginViewController sender:nil];
}

//钱包
- (void)mid_btn1Action:(UIButton *)sender
{
//    NSLog(@"钱包");
    QianbaoViewController * qianbaoViewController = [[QianbaoViewController alloc] init];
    [self showViewController:qianbaoViewController sender:nil];
}
//慈善基金会
- (void)mid_btn2Action:(UIButton *)sender
{
//    NSLog(@"慈善基金会");
    cishanjijinhuiViewController * cishanjijinhui = [[cishanjijinhuiViewController alloc] init];
    [self showViewController:cishanjijinhui sender:nil];
}
//分销中心
- (void)mid_btn3Action:(UIButton *)sender
{
    NSLog(@"分销中心");
    if(0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您暂无此权限" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else
    {
        FenxiaozhongxinViewController * fenxiaozhongxinViewController = [[FenxiaozhongxinViewController alloc] init];
        
        [self showViewController:fenxiaozhongxinViewController sender:nil];
    }
}

#pragma mark - 退出登录
- (void)head_cancelAction:(UIButton *)sender
{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出该账号" preferredStyle:(UIAlertControllerStyleAlert)];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [SVProgressHUD showSuccessWithStatus:@"退出登录成功"];
        
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        
        [userdefault setObject:@"0" forKey:@"Login_Success"];
        
        [userdefault setObject:@"" forKey:@"account"];
        [userdefault setObject:@"" forKey:@"password"];
        
        [self p_headView1];
        
        self.tableView.tableHeaderView = self.head_view;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新tableView(记住,要更新放在主线程中)
            
            [self.tableView reloadData];
        });
        
    }];
    
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action1];
    [alert addAction:action];
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
                cell.image.image = [UIImage imageNamed:@"00004"];
                cell.arrows_switch.hidden = YES;
            }
            else
            {
                cell.name.text = @"商城订单";
                                cell.image.image = [UIImage imageNamed:@"00002"];
                cell.arrows_switch.hidden = YES;
            }
        }
            break;
        case 1:
        {
            if(indexPath.row == 0)
            {
                cell.name.text = @"收藏的产品";
                                cell.image.image = [UIImage imageNamed:@"00005"];
                cell.arrows_switch.hidden = YES;
            }
            else if(indexPath.row == 1)
            {
                cell.name.text = @"收藏的视频";
                                cell.image.image = [UIImage imageNamed:@"000006"];
                cell.arrows_switch.hidden = YES;
            }
            else
            {
                cell.name.text = @"收藏的图文";
                                cell.image.image = [UIImage imageNamed:@"00003"];
                cell.arrows_switch.hidden = YES;
            }
        }
            break;
        case 2:
        {
            cell.name.text = @"申请成为代理商";
                            cell.image.image = [UIImage imageNamed:@"00001"];
            cell.arrows_switch.hidden = YES;
            cell.arrows.hidden = YES;
            cell.type.hidden = NO;
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
    
    switch (indexPath.section) {
        case 0:
        {
            if(indexPath.row == 0)
            {
                
            }
            else
            {
                
            }
        }
            break;
        case 1:
        {
            if(indexPath.row == 0)
            {
                //收藏的产品
                ChanpinshoucangViewController * chanpinshoucangViewController = [[ChanpinshoucangViewController alloc] init];
                
                [self showViewController:chanpinshoucangViewController sender:nil];
            }
            else if(indexPath.row == 1)
            {
                ShipinshoucangViewController * shipinshoucangViewController = [[ShipinshoucangViewController alloc] init];
                
                [self showViewController:shipinshoucangViewController sender:nil];
            }
            else
            {
                TuwenshoucangViewController * tuwenshoucangViewController = [[TuwenshoucangViewController alloc] init];
                
                [self showViewController:tuwenshoucangViewController sender:nil];
            }
        }
            break;
        case 2:
        {
            if(0)
            {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您暂无此权限" preferredStyle:(UIAlertControllerStyleAlert)];
                
                [self presentViewController:alert animated:YES completion:^{
                    
                }];
                
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alert addAction:action];
            }
            else
            {
                ShenqingdailishangViewController * shenqingdailishangViewController = [[ShenqingdailishangViewController alloc] init];
                
                [self showViewController:shenqingdailishangViewController sender:nil];
            }
        }
            break;
        default:
            break;
    }
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

#pragma mark - 3个分类
- (void)p_fenlei
{
    UIView * view_mid = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.head_view_white.frame) + 5, SCREEN_WIDTH, 60)];
    view_mid.backgroundColor = [UIColor whiteColor];
    [self.head_view addSubview:view_mid];
    
    int length_x1 = (SCREEN_WIDTH - 2) / 15;
    
    UIView * view_white1 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, length_x1 * 4.6, 60)];
    view_white1.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:244 / 255.0 blue:230 / 255.0 alpha:1];
    [view_mid addSubview:view_white1];
    
    UIImageView * image_1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 17.5, 25, 25)];
    image_1.image = [UIImage imageNamed:@"000000005"];
    [view_white1 addSubview:image_1];
    
    UILabel * lbl_1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image_1.frame) + 5, 17.5, length_x1 * 4.6 - CGRectGetMaxX(image_1.frame) - 5 , 25)];
    //    lbl_1.backgroundColor = [UIColor orangeColor];
    lbl_1.text = @"我的钱包";
    lbl_1.textAlignment = NSTextAlignmentCenter;
    lbl_1.font = [UIFont systemFontOfSize:14];
    [view_white1 addSubview:lbl_1];
    
    self.mid_btn1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.mid_btn1.frame = CGRectMake(1, 0, length_x1 * 4.6, 60);
    [view_mid addSubview:self.mid_btn1];
    
    
    UIView * view_white2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.mid_btn1.frame) + 1, 0, length_x1 * 5.6, 60)];
    view_white2.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:230 / 255.0 blue:241 / 255.0 alpha:1];
    [view_mid addSubview:view_white2];
    
    UIImageView * image_2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 17.5, 25, 25)];
    image_2.image = [UIImage imageNamed:@"000000000007"];
    [view_white2 addSubview:image_2];
    
    UILabel * lbl_2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image_2.frame) + 5, 17.5, length_x1 * 5.6 - CGRectGetMaxX(image_2.frame) - 5, 25)];
    //        lbl_2.backgroundColor = [UIColor orangeColor];
    lbl_2.text = @"慈善基金会";
    lbl_2.textAlignment = NSTextAlignmentCenter;
    lbl_2.font = [UIFont systemFontOfSize:14];
    [view_white2 addSubview:lbl_2];
    
    self.mid_btn2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.mid_btn2.frame = CGRectMake(CGRectGetMaxX(self.mid_btn1.frame) + 1, 0, length_x1 * 5.6, 60);
    //    self.mid_btn2.backgroundColor = [UIColor cyanColor];
    [view_mid addSubview:self.mid_btn2];
    
    
    UIView * view_white3 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.mid_btn2.frame) + 1, 0, SCREEN_WIDTH - CGRectGetMaxX(self.mid_btn2.frame) - 2, 60)];
    view_white3.backgroundColor = [UIColor colorWithRed:234 / 255.0 green:254 / 255.0 blue:231 / 255.0 alpha:1];
    [view_mid addSubview:view_white3];
    
    UIImageView * image_3 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 17.5, 25, 25)];
    image_3.image = [UIImage imageNamed:@"00000000000004"];
    [view_white3 addSubview:image_3];
    
    UILabel * lbl_3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image_3.frame) + 5, 17.5, SCREEN_WIDTH - CGRectGetMaxX(self.mid_btn2.frame) - 2 - CGRectGetMaxX(image_3.frame) - 5, 25)];
    //        lbl_2.backgroundColor = [UIColor orangeColor];
    lbl_3.text = @"分销中心";
    lbl_3.textAlignment = NSTextAlignmentCenter;
    lbl_3.font = [UIFont systemFontOfSize:14];
    [view_white3 addSubview:lbl_3];
    
    self.mid_btn3 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.mid_btn3.frame = CGRectMake(CGRectGetMaxX(self.mid_btn2.frame) + 1, 0, SCREEN_WIDTH - CGRectGetMaxX(self.mid_btn2.frame) - 2, 60);
    //    self.mid_btn3.backgroundColor = [UIColor orangeColor];
    [view_mid addSubview:self.mid_btn3];

}


@end

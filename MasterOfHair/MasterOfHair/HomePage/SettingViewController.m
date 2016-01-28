//
//  SettingViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/20.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "SettingViewController.h"

#import "AppDelegate.h"
#import "JCMineTableViewCell.h"

#import "shouhuodizhiViewController.h"

@interface SettingViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation SettingViewController

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
    _lblTitle.text = @"设置";
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
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStyleGrouped)];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    //注册
    [self.tableView registerClass:[JCMineTableViewCell class] forCellReuseIdentifier:@"cell_setting"];
}

//代理方法
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2)
    {
        return 5;
    }
    else
    {
        return 1;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JCMineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_setting" forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
        {
            cell.name.text = @"我的收货地址";
            cell.image.image = [UIImage imageNamed:@"0000000000001"];
        }
            break;
        case 1:
        {
            cell.name.text = @"修改密码";
            cell.image.image = [UIImage imageNamed:@"0000000000002"];
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.name.text = @"会员说明";
                    cell.image.image = [UIImage imageNamed:@"0000000000003"];
                }
                    break;
                case 1:
                {
                    cell.name.text = @"分销说明";
                    cell.image.image = [UIImage imageNamed:@"00000000000004"];
                }
                    break;
                case 2:
                {
                    cell.name.text = @"合作开店";
                    cell.image.image = [UIImage imageNamed:@"03-hezuodian"];
                }
                    break;
                case 3:
                {
                    cell.name.text = @"支付帮助";
                    cell.image.image = [UIImage imageNamed:@"000000005"];
                }
                    break;
                case 4:
                {
                    cell.name.text = @"慈善基金会说明";
                    cell.image.image = [UIImage imageNamed:@"000000000007"];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            cell.name.text = @"联系我们";
            cell.image.image = [UIImage imageNamed:@"000000000006"];
        }
            break;
        case 4:
        {
            cell.name.text = @"发表意见";
            cell.image.image = [UIImage imageNamed:@"0000000008"];
        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    if(indexPath.section == 0)
    {
        shouhuodizhiViewController * shouhuodizhi = [[shouhuodizhiViewController alloc] init];
        [self showViewController:shouhuodizhi sender:nil];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"收货地址";
            break;
        case 1:
            return @"修改密码";
            break;
        case 2:
            return @"说明书";
            break;
        case 3:
            return @"联系我们";
            break;
        case 4:
            return @"意见反馈";
            break;
        default:
            return @"";
            break;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 33;
    }
    else
    {
        return 15;
    }
}






@end

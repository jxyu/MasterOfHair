//
//  ShuoshuoViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/15.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "ShuoshuoViewController.h"

#import "ChunwenziViewController.h"
#import "ZhaopiankuViewController.h"
#import "ZhaoxiangViewController.h"
#import "LuxiangViewController.h"
#import <ALBBQuPaiPlugin/ALBBQuPaiPlugin.h>
#import "UploadVideoViewController.h"

@interface ShuoshuoViewController () <UITableViewDataSource, UITableViewDelegate,QupaiSDKDelegate>
{
    UIViewController *recordController;
}

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation ShuoshuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self p_navi];
    
    [self p_setupView];
    
    [self p_setupBottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navi
- (void)p_navi
{
    _lblTitle.text = [NSString stringWithFormat:@"说说"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    
    //右边为定位
    [self addRightbuttontitle:@"我的"];
    _lblRight.font = [UIFont systemFontOfSize:18];
    //    _lblRight.backgroundColor = [UIColor orangeColor];
    _lblRight.frame = CGRectMake(SCREEN_WIDTH - 65, 19, 50, 44);
    _btnRight.frame = _lblRight.frame;
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    //
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_"];
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - 底部栏
- (void)p_setupBottomView
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIView * line = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:line];
    
    CGFloat length_x = SCREEN_WIDTH / 4;
    //4个功能
    UIButton * btn_1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn_1.frame = CGRectMake(0, SCREEN_HEIGHT - 50, length_x, 50);
    [btn_1 setImage:[UIImage imageNamed:@"0shuoshuo_03"] forState:(UIControlStateNormal)];
    [btn_1 setImageEdgeInsets:UIEdgeInsetsMake(7.5, (length_x - 35) / 2, 7.5, (length_x - 35) / 2)];
    [btn_1 setTintColor:[UIColor grayColor]];
    [self.view addSubview:btn_1];
    
    [btn_1 addTarget:self action:@selector(btn_1Action:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIView * line_1 = [[UILabel alloc] initWithFrame:CGRectMake(length_x, SCREEN_HEIGHT - 45, 1, 40)];
    line_1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:line_1];

    
    UIButton * btn_2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn_2.frame = CGRectMake(length_x, SCREEN_HEIGHT - 50, length_x, 50);
    [btn_2 setImage:[UIImage imageNamed:@"shuoshuo1212"] forState:(UIControlStateNormal)];
    [btn_2 setImageEdgeInsets:UIEdgeInsetsMake(7.5, (length_x - 35) / 2, 7.5, (length_x - 35) / 2)];
    [btn_2 setTintColor:[UIColor grayColor]];
    [self.view addSubview:btn_2];
    
    [btn_2 addTarget:self action:@selector(btn_2Action:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIView * line_2 = [[UILabel alloc] initWithFrame:CGRectMake(length_x * 2, SCREEN_HEIGHT - 45, 1, 40)];
    line_2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:line_2];
    
    
    UIButton * btn_3 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn_3.frame = CGRectMake(length_x * 2, SCREEN_HEIGHT - 50, length_x, 50);
    [btn_3 setImage:[UIImage imageNamed:@"shuoshuo1111"] forState:(UIControlStateNormal)];
    [btn_3 setImageEdgeInsets:UIEdgeInsetsMake(7.5, (length_x - 35) / 2, 7.5, (length_x - 35) / 2)];
    [btn_3 setTintColor:[UIColor grayColor]];
    [self.view addSubview:btn_3];
    
    [btn_3 addTarget:self action:@selector(btn_3Action:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIView * line_3 = [[UILabel alloc] initWithFrame:CGRectMake(length_x * 3, SCREEN_HEIGHT - 45, 1, 40)];
    line_3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:line_3];
    
    
    UIButton * btn_4 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn_4.frame = CGRectMake(length_x * 3, SCREEN_HEIGHT - 50, length_x, 50);
    [btn_4 setImage:[UIImage imageNamed:@"shuoshuo191919"] forState:(UIControlStateNormal)];
    [btn_4 setImageEdgeInsets:UIEdgeInsetsMake(7.5, (length_x - 35) / 2, 7.5, (length_x - 35) / 2)];
    [btn_4 setTintColor:[UIColor grayColor]];
    [self.view addSubview:btn_4];
    
    [btn_4 addTarget:self action:@selector(btn_4Action:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
}

#pragma mark - 4个单击事件
- (void)btn_1Action:(UIButton *)sender
{//纯文字
    ChunwenziViewController * chunwenziViewController = [[ChunwenziViewController alloc] init];
    [self showViewController:chunwenziViewController sender:nil];
}

- (void)btn_2Action:(UIButton *)sender
{
    ZhaopiankuViewController * zhaopiankuViewController = [[ZhaopiankuViewController alloc] init];
    [self showViewController:zhaopiankuViewController sender:nil];
}

- (void)btn_3Action:(UIButton *)sender
{//只拍照
//    ZhaoxiangViewController * zhaoxiangViewController = [[ZhaoxiangViewController alloc] init];
//    [self showViewController:zhaoxiangViewController sender:nil];
    
    //都有
    ZhaopiankuViewController * zhaopiankuViewController = [[ZhaopiankuViewController alloc] init];
    [self showViewController:zhaopiankuViewController sender:nil];
}

- (void)btn_4Action:(UIButton *)sender
{
//    LuxiangViewController * luxiangViewController = [[LuxiangViewController alloc] init];
//    
//    [self showViewController:luxiangViewController sender:nil];
    
    QupaiSDK *sdkqupai = [QupaiSDK shared];
    [sdkqupai setDelegte:(id<QupaiSDKDelegate>)self];
    
    /*可选设置*/
    sdkqupai.thumbnailCompressionQuality =0.3;
    sdkqupai.combine = YES;
    sdkqupai.progressIndicatorEnabled = YES;
    sdkqupai.beautySwitchEnabled = NO;
    sdkqupai.flashSwitchEnabled = NO;
    sdkqupai.tintColor = [UIColor orangeColor];
    sdkqupai.localizableFileUrl = [[NSBundle mainBundle] URLForResource:@"QPLocalizable_en" withExtension:@"plist"];
    sdkqupai.bottomPanelHeight = 120;
    sdkqupai.recordGuideEnabled = YES;
    
    /*基本设置*/
    CGSize videoSize = CGSizeMake(320, 240);
    recordController = [sdkqupai createRecordViewControllerWithMinDuration:2
                                                               maxDuration:20
                                                                   bitRate:500000
                                                                 videoSize:videoSize];
    [self presentViewController:recordController animated:YES completion:nil];
    
}

//趣拍取消
-(void)qupaiSDKCancel:(QupaiSDK *)sdk
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
    [recordController dismissViewControllerAnimated:YES completion:nil];
}
//
-(void)qupaiSDK:(QupaiSDK *)sdk compeleteVideoPath:(NSString *)videoPath thumbnailPath:(NSString *)thumbnailPath
{
    NSLog(@"%@",videoPath);
    
    [recordController dismissViewControllerAnimated:YES completion:nil];
    
    UploadVideoViewController * uploadVideoVC=[[UploadVideoViewController alloc] initWithNibName:@"UploadVideoViewController" bundle:[NSBundle mainBundle]];
    
    uploadVideoVC.VideoFilePath=[NSURL fileURLWithPath:videoPath];
    
    uploadVideoVC.uploadType=@"1";
    
    [self.navigationController pushViewController:uploadVideoVC animated:YES];
}



@end

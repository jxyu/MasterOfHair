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
#import "Shuoshuo_Model.h"
@interface ShuoshuoViewController () <UITableViewDataSource, UITableViewDelegate,QupaiSDKDelegate>
{
    UIViewController *recordController;
}

@property (nonatomic, strong) UITableView * tableView;

//1
@property (nonatomic, strong) UIImageView * image_iocn;
@property (nonatomic, strong) UILabel * name;
@property (nonatomic, strong) UILabel * time;

//3
@property (nonatomic, strong) UIImageView * image_zan;
@property (nonatomic, strong) UIImageView * image_pingjia;

@property (nonatomic, strong) UILabel * zannum;
@property (nonatomic, strong) UILabel * pingjianum;

//2
@property (nonatomic, strong) UILabel * talk_content;




@property (nonatomic, strong) NSMutableArray * arr_all;

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
    [self p_data];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    //
    self.tableView.tableFooterView = [[UIView alloc] init];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_"];
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arr_all.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 60;
    }
    else if(indexPath.row == 2)
    {
        return 40;
    }
    else
    {
        if(self.arr_all.count != 0)
        {
            Shuoshuo_Model * model = self.arr_all[indexPath.section];
            
            CGFloat x_length = [model.talk_content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 90, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
            
            
            return x_length + 10;
        }
        else
        {
            return 200;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_" forIndexPath:indexPath];
    
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.row == 0)
    {
        self.image_iocn = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        self.image_iocn.backgroundColor = [UIColor orangeColor];
        self.image_iocn.layer.cornerRadius = 25;
        self.image_iocn.layer.masksToBounds = YES;
        
        [cell addSubview:self.image_iocn];
        
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.image_iocn.frame) + 10, 15, SCREEN_WIDTH - CGRectGetMaxX(self.image_iocn.frame) - 30 - 100, 25)];
        self.name.text = @"wolajiwolaji";
//        self.name.backgroundColor = [UIColor orangeColor];
        self.name.textColor = [UIColor grayColor];
        
        [cell addSubview:self.name];
        
        
        self.time = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.name.frame) + 10, 15, 100, 25)];
        self.time.text = @"wolajiwolaji";
        self.time.textColor = [UIColor grayColor];
        self.time.textAlignment = NSTextAlignmentRight;
        
        [cell addSubview:self.time];
        
        if(self.arr_all.count != 0)
        {
            Shuoshuo_Model * model = self.arr_all[indexPath.section];
            
            [self.image_iocn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/member/%@",Url,model.member_headpic]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];

            self.name.text = model.member_username;
            
            self.time.text = model.talk_time;
        }
        
    }
    else if(indexPath.row == 2)
    {
        self.pingjianum = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 45, 7.5, 35, 25)];
//        self.pingjianum.backgroundColor = [UIColor orangeColor];
        self.pingjianum.text = @"11111";
        self.pingjianum.font = [UIFont systemFontOfSize:15];
        self.pingjianum.textColor = [UIColor grayColor];
        
        [cell addSubview:self.pingjianum];
        
        self.image_pingjia = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 72, 7.5, 25, 25)];
        self.image_pingjia.image = [UIImage imageNamed:@"qwertyuiop"];
        
        [cell addSubview:self.image_pingjia];
        
        
        self.zannum = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 117, 7.5, 35, 25)];
//        self.zannum.backgroundColor = [UIColor orangeColor];
        self.zannum.text = @"11111";
        self.zannum.font = [UIFont systemFontOfSize:15];
        self.zannum.textColor = [UIColor grayColor];
        
        [cell addSubview:self.zannum];
        
        self.image_zan = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 145, 7.5, 25, 25)];
        self.image_zan.image = [UIImage imageNamed:@"qazwsxedcrfvt"];
        
        [cell addSubview:self.image_zan];
        
        
        if(self.arr_all.count != 0)
        {
            Shuoshuo_Model * model = self.arr_all[indexPath.section];
            
            self.zannum.text = model.talk_good;
            
            self.pingjianum.text = model.talk_reply;
        }
    }
    else
    {
        if(self.arr_all != 0)
        {
            Shuoshuo_Model * model = self.arr_all[indexPath.section];
            
            CGFloat x_length = [model.talk_content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 90, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
//            NSLog(@"%f",x_length);
            
            self.talk_content = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, SCREEN_WIDTH - 80, x_length)];
            self.talk_content.text = @"剃头匠";
            self.talk_content.numberOfLines = 0;
            self.talk_content.font = [UIFont systemFontOfSize:15];
            self.talk_content.backgroundColor = [UIColor orangeColor];
            
            [cell addSubview:self.talk_content];
            
            self.talk_content.text = model.talk_content;
            
            
            
        }
    }
    
    
    
    
    
    
    return cell;
}

#pragma mark - 数据列表

- (void)p_data
{
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"create:"];
    
    [dataprovider talkAllWithpagenumber:@"1" pagesize:@"15"];
}


#pragma mark - 接口
- (void)create:(id )dict
{
    NSLog(@"%@",dict);
    
    self.arr_all = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"talklist"])
            {
                Shuoshuo_Model * model = [[Shuoshuo_Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
//                NSLog(@"%@",model.member_username);
                
                [self.arr_all addObject:model];
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
//        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] maskType:SVProgressHUDMaskTypeBlack];
    }
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
    
    [self showViewController:uploadVideoVC sender:nil];
    
}


#pragma mark - 懒加载
- (NSMutableArray *)arr_all
{
    if(_arr_all == nil)
    {
        self.arr_all = [NSMutableArray array];
    }
    
    return _arr_all;
}


@end

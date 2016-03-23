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
#import "PinglunViewController.h"
#import "WodeshuoshuoViewController.h"

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
@property (nonatomic, strong) UIButton * image_zan;
@property (nonatomic, strong) UIButton * image_pingjia;

@property (nonatomic, strong) UILabel * zannum;
@property (nonatomic, strong) UILabel * pingjianum;

//2
@property (nonatomic, strong) UILabel * talk_content;

@property (nonatomic,assign) NSInteger page;


@property (nonatomic, strong) NSMutableArray * arr_all;
@property (nonatomic, strong) NSMutableArray * arr_filelist;

//第几个
@property (nonatomic, assign) NSInteger zan_index;

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

- (void)clickRightButton:(UIButton *)sender
{
    WodeshuoshuoViewController * wodeshuoshuoViewController = [[WodeshuoshuoViewController alloc] init];
    
    [self showViewController:wodeshuoshuoViewController sender:nil];
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [self example01];
    
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
    
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self p_data];
        
        [weakSelf.tableView reloadData];
        [weakSelf loadNewData];
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self p_data1];
        
        [weakSelf.tableView reloadData];
        [weakSelf loadNewData];
    }];
    
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
            CGFloat sum = 0;
            
            Shuoshuo_Model * model = self.arr_all[indexPath.section];
            
            CGFloat x_length = [model.talk_content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 90, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
            
            //图片
            CGFloat length_x = (SCREEN_WIDTH - 80 - 10) / 3;
            
            
            
            if([self.arr_filelist[indexPath.section] count] <= 3)
            {
                NSArray * arr = self.arr_filelist[indexPath.section];
                
                Shuoshuo_Model * model = arr.firstObject;
                
                if([model.file_id length] == 0)
                {
                    sum = x_length + 10;
                }
                else
                {
                    sum = x_length + 10 + (length_x + 20);
                }
            }
            else if([self.arr_filelist[indexPath.section] count] > 3)
            {
                sum = x_length + 10 + (length_x + 20) * 2 + 5;
            }

            if([model.talk_content length] == 0)
            {
                sum = sum - x_length;
            }
            
            return sum;
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
            
            [self.image_iocn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/member/%@",Url_pic,model.member_headpic]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];

            self.name.text = model.member_username;
            
            NSString * str = [model.talk_time substringFromIndex:10];
            
            self.time.text = str;
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
        
        self.image_pingjia = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.image_pingjia.frame = CGRectMake(SCREEN_WIDTH - 72, 7.5, 25, 25);
        [self.image_pingjia setBackgroundImage:[UIImage imageNamed:@"qwertyuiop"] forState:(UIControlStateNormal)];
        self.image_pingjia.tag = 700 + indexPath.section;
        
        [self.image_pingjia addTarget:self action:@selector(image_pingjiaAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell addSubview:self.image_pingjia];
        
        
        self.zannum = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 117, 7.5, 35, 25)];
//        self.zannum.backgroundColor = [UIColor orangeColor];
        self.zannum.text = @"11111";
        self.zannum.font = [UIFont systemFontOfSize:15];
        self.zannum.textColor = [UIColor grayColor];
        
        [cell addSubview:self.zannum];
        
        self.image_zan = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.image_zan.frame = CGRectMake(SCREEN_WIDTH - 145, 7.5, 25, 25);
        [self.image_zan setBackgroundImage:[UIImage imageNamed:@"qazwsxedcrfvt"] forState:(UIControlStateNormal)];
        
        [self.image_zan addTarget:self action:@selector(image_zanAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [cell addSubview:self.image_zan];
        
        
        self.zannum.tag = 100 + indexPath.section;
        self.image_zan.tag = 400 + indexPath.section;
        
        
        if(self.arr_all.count != 0)
        {
            Shuoshuo_Model * model = self.arr_all[indexPath.section];
            
            self.zannum.text = model.talk_good;
            
            self.pingjianum.text = model.talk_reply;
            
            if([model.reply_good isEqualToString:@"1"])
            {
                self.zannum.textColor = navi_bar_bg_color;
                
                [self.image_zan setBackgroundImage:[UIImage imageNamed:@"qwasderf"] forState:(UIControlStateNormal)];
            }
            else
            {
                self.zannum.textColor = [UIColor grayColor];
                
                [self.image_zan setBackgroundImage:[UIImage imageNamed:@"qazwsxedcrfvt"] forState:(UIControlStateNormal)];
            }
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
//            self.talk_content.backgroundColor = [UIColor orangeColor];
            
            [cell addSubview:self.talk_content];
            
            self.talk_content.text = model.talk_content;
            
                
            if([model.talk_content length] == 0)
            {
                self.talk_content.hidden = YES;
                
                for (int i = 0; i < [self.arr_filelist[indexPath.section] count]; i ++)
                {
                    int x = (int )i / 3;
                    int y = i % 3;
//                        NSLog(@"%d  %d",x,y);
                    
                    CGFloat length = (SCREEN_WIDTH - 90) / 3;
                
                    Shuoshuo_Model * modle_list = self.arr_filelist[indexPath.section][i];
                    
                    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(70 + (length + 5) * y, 5 + (length + 20 + 5) * x, length, length + 20)];
                    //tag
                    image.tag = indexPath.section * 1000 + indexPath.row;
                    
//                    image.backgroundColor = [UIColor orangeColor];
                    
                    if([modle_list.file_type isEqualToString:@"1"])
                    {
                        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/talk/%@",Url_pic,modle_list.file_path]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
                    }
                    else
                    {
                        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/talk/%@",Url_pic,modle_list.file_name]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];

                    }
                    [cell addSubview:image];
                }

            }
            else
            {
                for (int i = 0; i < [self.arr_filelist[indexPath.section] count]; i ++)
                {
                    int x = (int )i / 3;
                    int y = i % 3;
//                        NSLog(@"%d  %d",x,y);
                    
                    CGFloat length = (SCREEN_WIDTH - 90) / 3;
                
                    Shuoshuo_Model * modle_list = self.arr_filelist[indexPath.section][i];
                    
                    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(70 + (length + 5) * y, CGRectGetMaxY(self.talk_content.frame) + 10 + (length + 20 + 5) * x, length, length + 20)];
                    //tag
                    image.tag = indexPath.section * 1000 + indexPath.row;
                    
//                    image.backgroundColor = [UIColor orangeColor];

                    if([modle_list.file_type isEqualToString:@"1"])
                    {
                        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/talk/%@",Url_pic,modle_list.file_path]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
                        
//                        image.image = [UIImage imageNamed:@"sudisudiusidusidu"];
                    }
                    else
                    {
                        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/talk/%@",Url_pic,modle_list.file_name]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
                    }
                    
                    [cell addSubview:image];
                }
            }
        }
        
    }
    
    return cell;
}

#pragma mark - 评论
- (void)image_pingjiaAction:(UIButton *)sender
{
    
    NSInteger count = sender.tag - 700;
    Shuoshuo_Model * model1 = self.arr_all[count];
    
    
    CGFloat sum = 0;
    
    Shuoshuo_Model * model = self.arr_all[count];
    
    CGFloat x_length = [model.talk_content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 90, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    
    //图片
    CGFloat length_x = (SCREEN_WIDTH - 80 - 10) / 3;
    
    
    
    if([self.arr_filelist[count] count] <= 3)
    {
        NSArray * arr = self.arr_filelist[count];
        
        Shuoshuo_Model * model = arr.firstObject;
        
        if([model.file_id length] == 0)
        {
            sum = x_length + 10;
        }
        else
        {
            sum = x_length + 10 + (length_x + 20);
        }
    }
    else if([self.arr_filelist[count] count] > 3)
    {
        sum = x_length + 10 + (length_x + 20) * 2 + 5;
    }
    
    if([model.talk_content length] == 0)
    {
        sum = sum - x_length;
    }
    
    PinglunViewController * pinglunViewController = [[PinglunViewController alloc] init];
    pinglunViewController.talk_id = model1.talk_id;
    
    pinglunViewController.height = sum + 70;
    
    [self showViewController:pinglunViewController sender:nil];
}

#pragma mark - 点赞
- (void)image_zanAction:(UIButton *)sender
{
    
    NSInteger index = sender.tag - 400;
    self.zan_index = index;
    
    Shuoshuo_Model * model = self.arr_all[index];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"TakeGood:"];
    
    [dataprovider TakeGoodWithMember_id:@"1" talk_id:model.talk_id];
}

// 接口
- (void)TakeGood:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
//            [SVProgressHUD showSuccessWithStatus:@"操作成功" maskType:(SVProgressHUDMaskTypeBlack)];
            
            UIButton * btn = [self.view viewWithTag:self.zan_index + 400];
            UILabel * label = [self.view viewWithTag:self.zan_index + 100];
            
            NSString * str = label.text;
            
            if([label.textColor isEqual:navi_bar_bg_color])
            {
                label.textColor = [UIColor grayColor];
                label.text = [NSString stringWithFormat:@"%ld",[str integerValue] - 1];
                
                [btn setBackgroundImage:[UIImage imageNamed:@"qazwsxedcrfvt"] forState:(UIControlStateNormal)];
                
                Shuoshuo_Model * model = self.arr_all[self.zan_index];
                
                model.reply_good = @"0";
                model.talk_good = label.text;
                
                
                [self.arr_all replaceObjectAtIndex:self.zan_index withObject:model];
                
            }
            else
            {
                label.textColor = navi_bar_bg_color;
                label.text = [NSString stringWithFormat:@"%ld",[str integerValue] + 1];
                
                [btn setBackgroundImage:[UIImage imageNamed:@"qwasderf"] forState:(UIControlStateNormal)];
                
                
                Shuoshuo_Model * model = self.arr_all[self.zan_index];
                
                model.reply_good = @"1";
                model.talk_good = label.text;
                
                
                [self.arr_all replaceObjectAtIndex:self.zan_index withObject:model];
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







#pragma mark - 数据列表

- (void)p_data
{
    self.page = 1;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"create:"];
    
    [dataprovider talkAllWithmember_id:@"1" pagenumber:@"1" pagesize:@"15"];
}

- (void)p_data1
{
    self.page ++ ;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"create:"];
    
    [dataprovider talkAllWithmember_id:@"1" pagenumber:[NSString stringWithFormat:@"%ld",self.page] pagesize:@"15"];
}

//接口
- (void)create:(id )dict
{
//    NSLog(@"%@",dict);
    
    if(self.page == 1)
    {
        self.arr_all = nil;
        self.arr_filelist = nil;
    }
    
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"talklist"])
            {
                Shuoshuo_Model * model = [[Shuoshuo_Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
//                NSLog(@"%@",model.member_username);
                
                [self.arr_all addObject:model];
                
                NSMutableArray * arr_list = [NSMutableArray array];
                
                for (NSDictionary * dic_list in dic[@"filelist"])
                {
                    Shuoshuo_Model * model_list = [[Shuoshuo_Model alloc] init];
                    
                    [model_list setValuesForKeysWithDictionary:dic_list];
                    
                    [arr_list addObject:model_list];
                    
//                    NSLog(@"%@",model_list.file_path);
                }
                
                [self.arr_filelist addObject:arr_list];
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

- (NSMutableArray *)arr_filelist
{
    if(_arr_filelist == nil)
    {
        self.arr_filelist = [NSMutableArray array];
    }
    
    return _arr_filelist;
}

#pragma mark - 下拉刷新
- (void)example01
{
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
}

-(void)example02
{
    [self.tableView.footer beginRefreshing];
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    });
    
}



@end

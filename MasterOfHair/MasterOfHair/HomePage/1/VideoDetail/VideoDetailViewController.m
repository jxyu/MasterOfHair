//
//  VideoDetailViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/3.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "MoviePlayer.h"
#import "TextTableViewCell.h"
#import "TuWen_Models.h"
#import "Pinglun_Models.h"
#import "NextVideoViewController.h"


@interface VideoDetailViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    MoviePlayer *moviePlayerview;
}

@property (nonatomic, strong) UITableView * tableView;

//头视图
@property (nonatomic, strong) UIView * head_View;

@property (nonatomic, strong) NSString * pinglunshu;

//1
@property (nonatomic, strong) UILabel * text_title;
@property (nonatomic, strong) UIView * view_video;

//2
@property (nonatomic, strong) UILabel * text_detail;
@property (nonatomic, strong) UILabel * number;
@property (nonatomic, strong) UILabel * isfree;


@property (nonatomic, strong) UIButton * btn_collect;
@property (nonatomic, strong) UILabel * label_collect;
@property (nonatomic, strong) UIButton * btn_share;
@property (nonatomic, strong) UILabel * label_share;

//3
@property (nonatomic, strong) UILabel * pinglun_number;
@property (nonatomic, strong) UIImageView * pinglun_image;
@property (nonatomic, strong) UITextField * bottom_text;
@property (nonatomic, strong) UIButton * btn_fabiao;

//
@property (nonatomic, strong) NSMutableArray * arr_data;

@property (nonatomic, strong) NSMutableArray * arr_data1;
//翻页
@property (nonatomic, assign) NSInteger page;


@end

@implementation VideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];

    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

    [self p_data];
    
    [self p_data1];
    
    [self p_setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navi

//- (void)p_navi
//{
//    _topView.hidden = YES;
//    
//    //上面的黑边
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//    
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
//    view.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:view];
//}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

//返回
- (void)btn_returnAction:(UIButton *)sender
{
    [moviePlayerview stopPlayer];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 20) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    __weak __typeof(self) weakSelf = self;
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self p_data2];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf loadNewData];
    }];
    
    
    [self p_headView];
    self.tableView.tableHeaderView = self.head_View;
    //去除尾视图
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //注册
    [self.tableView registerClass:[TextTableViewCell class] forCellReuseIdentifier:@"cell_textDetail"];
}

#pragma mark - tableView代理
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr_data1.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = @"";
    
    if(self.arr_data1.count == 0)
    {
        str = @"手机打开手机的空间设计的款式简单款式简单款就是看的就是空间打开手机看的就是宽带接口设计的技术肯定就是空间打开数据库的技术可简单接口技术的间设计的款式简单款式简单款就是看的就是空间";
    }
    else
    {
        Pinglun_Models * model = self.arr_data1[indexPath.row];
        
        str = [NSString stringWithFormat:@"%@",model.discuss_content];
    }
    return 95 + [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 100, 10000)    options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_textDetail" forIndexPath:indexPath];
    
    if(self.arr_data1.count != 0)
    {
        Pinglun_Models * model = self.arr_data1[indexPath.row];
        
        [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/member/%@",Url,model.member_headpic]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
        //
        if([model.member_nickname length] == 0 || [model.member_nickname isEqualToString:@"<null>"])
        {
            cell.name.text = [NSString stringWithFormat:@"%@",model.member_username];
        }
        else
        {
            cell.name.text = [NSString stringWithFormat:@"%@",model.member_nickname];
        }
        
        cell.time.text = [NSString stringWithFormat:@"%@",model.discuss_time];
        
        cell.detail.text = [NSString stringWithFormat:@"%@",model.discuss_content];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.bottom_text resignFirstResponder];
    
    if(self.arr_data1.count != 0)
    {
        Pinglun_Models * model = self.arr_data1[indexPath.row];
        
        CGFloat x = [model.discuss_content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 100, 10000)    options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        NextVideoViewController * nextTextViewController = [[NextVideoViewController alloc] init];
        nextTextViewController.discuss_id = [NSString stringWithFormat:@"%@",model.discuss_id];
        nextTextViewController.length = x;
        
        nextTextViewController.model_pinglu = model;
        
        [self showViewController:nextTextViewController sender:nil];
    }
}

#pragma mark - headView
- (void)p_headView
{
    
    TuWen_Models * model = self.arr_data.firstObject;
    
    self.head_View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 380)];
    self.head_View.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    //1
    if([model.video_url length] != 0)
    {
        NSString * str = [NSString stringWithFormat:@"%@uploads/video/%@",Url,model.video_url];
        moviePlayerview = [[MoviePlayer alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) URL:[NSURL URLWithString:str]];
        [self.view addSubview:moviePlayerview];
        
        UIButton * btn_return = [UIButton buttonWithType:(UIButtonTypeSystem)];
        btn_return.frame = CGRectMake(5, 10, 30, 30);
        [btn_return setBackgroundImage:[UIImage imageNamed:@"01return_03"] forState:(UIControlStateNormal)];
        [btn_return addTarget:self action:@selector(btn_returnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [moviePlayerview addSubview:btn_return];
        
        
        self.text_title = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn_return.frame) , 15, SCREEN_WIDTH - 10 - CGRectGetMaxX(btn_return.frame), 20)];
        self.text_title.font = [UIFont systemFontOfSize:15];
        self.text_title.textColor = [UIColor whiteColor];
        self.text_title.text = @"2016年度发型设计最新课程";
        [moviePlayerview addSubview:self.text_title];
    }
    else
    {
        self.view_video =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        self.view_video.backgroundColor = [UIColor blackColor];
        [self.view addSubview:self.view_video];
        
        UIButton * btn_return = [UIButton buttonWithType:(UIButtonTypeSystem)];
        btn_return.frame = CGRectMake(5, 10, 30, 30);
        [btn_return setBackgroundImage:[UIImage imageNamed:@"01return_03"] forState:(UIControlStateNormal)];
        [btn_return addTarget:self action:@selector(btn_returnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:btn_return];
        
        
        self.text_title = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn_return.frame) , 15, SCREEN_WIDTH - 10 - CGRectGetMaxX(btn_return.frame), 20)];
        self.text_title.font = [UIFont systemFontOfSize:15];
        self.text_title.textColor = [UIColor whiteColor];
        self.text_title.text = @"2016年度发型设计最新课程";
        [self.view addSubview:self.text_title];
    }
//2
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 180 + 10, SCREEN_WIDTH, 80)];
    view.backgroundColor = [UIColor whiteColor];
    [self.head_View addSubview:view];
    
    self.text_detail = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH / 3 * 2 - 10, 20)];
    self.text_detail.textColor = [UIColor blackColor];
    self.text_detail.font = [UIFont systemFontOfSize:15];
    self.text_detail.text = @"2016年度发型设计最新课程";
    //        self.text_detail.backgroundColor = [UIColor orangeColor];
    [view addSubview:self.text_detail];
    
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.text_detail.frame) + 5, 20, 20)];
    image.image = [UIImage imageNamed:@"00000play"];
    [view addSubview:image];
    
    self.number = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame) + 3, CGRectGetMaxY(self.text_detail.frame) + 5, 70, 20)];
    self.number.textColor = [UIColor grayColor];
    self.number.text = @"1.2万";
    //        self.number.backgroundColor = [UIColor orangeColor];
    self.number.font = [UIFont systemFontOfSize:15];
    [view addSubview:self.number];
    
    //判断一下
    self.isfree = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.number.frame), CGRectGetMaxY(self.text_detail.frame) + 5, 60, 20)];
    self.isfree.font = [UIFont systemFontOfSize:15];
    self.isfree.textColor = navi_bar_bg_color;
    self.isfree.text = @"免费";
    [view addSubview:self.isfree];
    
    //        CGFloat length_x = (SCREEN_WIDTH / 3 - 30) / 2 - 5;
    self.btn_collect = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_collect.frame = CGRectMake(CGRectGetMaxX(self.text_detail.frame) + 10, CGRectGetMinY(self.text_detail.frame) - 0, 30, 30);
    //        self.btn_collect.backgroundColor = [UIColor orangeColor];
    [self.btn_collect setBackgroundImage:[UIImage imageNamed:@"01collect_16"] forState:(UIControlStateNormal)];
    [self.btn_collect setTintColor:[UIColor grayColor]];
    [view addSubview:self.btn_collect];
    
    [self.btn_collect addTarget:self action:@selector(btn_collectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.label_collect = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.btn_collect.frame), CGRectGetMaxY(self.btn_collect.frame) + 5, 30, 17)];
    self.label_collect.font = [UIFont systemFontOfSize:13];
    self.label_collect.textAlignment = NSTextAlignmentCenter;
    self.label_collect.textColor = [UIColor grayColor];
    self.label_collect.text = @"收藏";
    [view addSubview:self.label_collect];
    
    
    self.btn_share = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_share.frame = CGRectMake(SCREEN_WIDTH - 20 - 30, CGRectGetMinY(self.text_detail.frame) - 0, 30, 30);
    //        self.btn_share.backgroundColor = [UIColor orangeColor];
    [self.btn_share setImage:[UIImage imageNamed:@"01share_21"] forState:(UIControlStateNormal)];
    [self.btn_share setTintColor:[UIColor grayColor]];
    [view addSubview:self.btn_share];
    
    [self.btn_share addTarget:self action:@selector(btn_shareAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.label_share = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.btn_share.frame), CGRectGetMaxY(self.btn_share.frame) + 5, 30, 17)];
    self.label_share.font = [UIFont systemFontOfSize:13];
    self.label_share.textAlignment = NSTextAlignmentCenter;
    self.label_share.textColor = [UIColor grayColor];
    self.label_share.text = @"分享";
    [view addSubview:self.label_share];

    
    //3
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 280, SCREEN_WIDTH, 100)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.head_View addSubview:view1];
    
    
    UILabel * pinglun = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(view.frame) + 20, 50, 20)];
    pinglun.text = @"评论";
    pinglun.font = [UIFont systemFontOfSize:17];
    [self.head_View addSubview:pinglun];
    
    self.pinglun_number = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 100, CGRectGetMaxY(view.frame) + 20, 100, 20)];
    self.pinglun_number.font = [UIFont systemFontOfSize:15];
    self.pinglun_number.textColor = [UIColor grayColor];
    self.pinglun_number.textAlignment = NSTextAlignmentRight;
    self.pinglun_number.text = @"共600条评论";
    [self.head_View addSubview:self.pinglun_number];
    
    
    self.pinglun_image = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(pinglun.frame) + 15, 50, 50)];
    self.pinglun_image.layer.cornerRadius = 25;
    self.pinglun_image.layer.masksToBounds = YES;
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    if([[userdefault objectForKey:@"member_headpic"] length] == 0)
    {
        self.pinglun_image.image = [UIImage imageNamed:@"touxiang"];
    }
    else
    {
        [self.pinglun_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/member/%@",Url,[userdefault objectForKey:@"member_headpic"]]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    }
//    [self.pinglun_image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    [self.head_View addSubview:self.pinglun_image];
    
    
    UIView * view_1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.pinglun_image.frame) + 5, CGRectGetMidY(self.pinglun_image.frame) - 18, SCREEN_WIDTH - 80 - 5 - CGRectGetMaxX(self.pinglun_image.frame), 36)];
    view_1.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    view_1.layer.borderWidth = 1;
    [self.head_View addSubview:view_1];
    
    UIImageView * image_1 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.pinglun_image.frame) + 10, CGRectGetMidY(self.pinglun_image.frame) - 10, 20, 20)];
    image_1.image = [UIImage imageNamed:@"01_3323232323"];
    [self.head_View addSubview:image_1];
    
    
    self.bottom_text = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image_1.frame) + 10, CGRectGetMidY(self.pinglun_image.frame) - 15, SCREEN_WIDTH - 10 - 70 - CGRectGetMaxX(image_1.frame) - 10, 30)];
    //    self.bottom_text.backgroundColor = [UIColor orangeColor];
    self.bottom_text.placeholder = @"我来说几句";
    self.bottom_text.delegate = self;
    [self.head_View addSubview:self.bottom_text];
    
    self.btn_fabiao = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_fabiao.frame = CGRectMake(SCREEN_WIDTH - 10 - 60, CGRectGetMidY(self.pinglun_image.frame) - 18, 60, 36);
    [self.btn_fabiao setTitle:@"发布" forState:(UIControlStateNormal)];
    self.btn_fabiao.titleLabel.font = [UIFont systemFontOfSize:16];
    self.btn_fabiao.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.btn_fabiao setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [self.btn_fabiao addTarget:self action:@selector(btn_fabiaoAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.head_View addSubview:self.btn_fabiao];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.head_View addGestureRecognizer:tapGesture];

}

#pragma mark - 分享和收藏 and 发布
//收藏
- (void)btn_collectAction:(UIButton *)sender
{
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    TuWen_Models * model = self.arr_data.firstObject;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"createVideo:"];
    
    [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] video_id:model.video_id];
}
//分享
- (void)btn_shareAction:(UIButton *)sender
{
    //分享
}

//发布
- (void)btn_fabiaoAction:(UIButton *)sender
{
    if([self.bottom_text.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入文字后再发布评论" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        [self.bottom_text resignFirstResponder];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
//            [self.bottom_text resignFirstResponder];
            
        }];
        
        [alert addAction:action];
    }
    else
    {
//        NSLog(@"发布");
        
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        
        DataProvider * dataprovider=[[DataProvider alloc] init];
        [dataprovider setDelegateObject:self setBackFunctionName:@"createLiuyan:"];
        
        [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] discuss_content:self.bottom_text.text video_id:self.video_id reply_id:@"0"];
        
        [self.bottom_text resignFirstResponder];
    }

}

-(void)tapGesture:(id)sender
{
    [self.bottom_text resignFirstResponder];
}

#pragma mark - textField代理 和通知收回键盘
- (BOOL )textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL )textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.tableView.contentOffset = CGPointMake(0, 100);
        
    }];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.bottom_text resignFirstResponder];
}

#pragma mark - 发布评论接口
- (void)createLiuyan:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"评论成功" maskType:(SVProgressHUDMaskTypeBlack)];
            
            self.bottom_text.text = nil;
            
            [self p_data1];
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
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] maskType:SVProgressHUDMaskTypeBlack];
    }
}

#pragma mark - 视频解析数据
- (void)p_data
{
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getVideos:"];
    
    [dataprovider getVideosWithVideo_id:self.video_id];
}

//
- (void)getVideos:(id )dict
{
//    NSLog(@"%@",dict);
    
    self.arr_data = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"videolist"])
            {
                TuWen_Models * model = [[TuWen_Models alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_data addObject:model];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            TuWen_Models * model = self.arr_data.firstObject;
            
            if([model.video_url length] != 0)
            {
                NSString * str = [NSString stringWithFormat:@"%@uploads/video/%@",Url,model.video_url];
                moviePlayerview = [[MoviePlayer alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) URL:[NSURL URLWithString:str]];
                [self.view addSubview:moviePlayerview];
            }
            else
            {
                self.view_video =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
                self.view_video.backgroundColor = [UIColor blackColor];
                [self.view addSubview:self.view_video];
            }
            
            UIButton * btn_return = [UIButton buttonWithType:(UIButtonTypeSystem)];
            btn_return.frame = CGRectMake(5, 10, 30, 30);
            [btn_return setBackgroundImage:[UIImage imageNamed:@"01return_03"] forState:(UIControlStateNormal)];
            [btn_return addTarget:self action:@selector(btn_returnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [moviePlayerview addSubview:btn_return];
            
            
            self.text_title = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn_return.frame) , 15, SCREEN_WIDTH - 10 - CGRectGetMaxX(btn_return.frame), 20)];
            self.text_title.font = [UIFont systemFontOfSize:15];
            self.text_title.textColor = [UIColor whiteColor];
//            self.text_title.text = @"2016年度发型设计最新课程";
            [moviePlayerview addSubview:self.text_title];
            
            
            self.text_title.text = model.video_title;
            self.number.text = [NSString stringWithFormat:@"%@次",model.video_click];
            self.text_detail.text = model.video_title;
            if([model.is_free isEqualToString:@"0"])
            {
                self.isfree.textColor = navi_bar_bg_color;
                self.isfree.text = @"免费";
            }
            else
            {
                self.isfree.textColor = [UIColor orangeColor];
                self.isfree.text = @"付费";
            }
            
            [self p_collectData];
            
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

#pragma mark - 评论解析
- (void)p_data1
{
    self.page = 1;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getDiscussList:"];
    
    [dataprovider getDiscussListWithVideo_id:self.video_id reply_id:@"0" pagenumber:@"1" pagesize:@"10"];
}

- (void)p_data2
{
    self.page ++;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getDiscussList1:"];
    
    [dataprovider getDiscussListWithVideo_id:self.video_id reply_id:@"0" pagenumber:[NSString stringWithFormat:@"%ld",self.page] pagesize:@"10"];
}


- (void)getDiscussList:(id )dict
{
//    NSLog(@"%@",dict);
    
    self.arr_data1 = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSDictionary * dict1 = dict[@"data"][@"page"];
            self.pinglunshu = dict1[@"total"];
            
            for (NSDictionary * dic in dict[@"data"][@"discusslist"])
            {
                Pinglun_Models * model = [[Pinglun_Models alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_data1 addObject:model];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            self.pinglun_number.text = [NSString stringWithFormat:@"共%@条评论",self.pinglunshu];

            
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

- (void)getDiscussList1:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSDictionary * dict1 = dict[@"data"][@"page"];
            self.pinglunshu = dict1[@"total"];
            
            for (NSDictionary * dic in dict[@"data"][@"discusslist"])
            {
                Pinglun_Models * model = [[Pinglun_Models alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_data1 addObject:model];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            self.pinglun_number.text = [NSString stringWithFormat:@"共%@条评论",self.pinglunshu];
            
            
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



#pragma mark - 加入收藏
- (void)createVideo:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            if(self.btn_collect.selected == 0)
            {
                self.label_collect.textColor = navi_bar_bg_color;
                
                [self.btn_collect setBackgroundImage:[UIImage imageNamed:@"shoucangH"] forState:(UIControlStateNormal)];
                [self.btn_collect setTintColor:[UIColor whiteColor]];
                self.btn_collect.selected = YES;
            }
            else
            {
                self.label_collect.textColor = [UIColor grayColor];
                
                [self.btn_collect setBackgroundImage:[UIImage imageNamed:@"01collect_16"] forState:(UIControlStateNormal)];
                self.btn_collect.selected = NO;
                
            }
            
            [SVProgressHUD showSuccessWithStatus:dict[@"status"][@"message"] maskType:SVProgressHUDMaskTypeBlack];
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

#pragma mark - 是否被收藏
- (void)p_collectData
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    TuWen_Models * model = self.arr_data.firstObject;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"isFavorite:"];
    
    [dataprovider isFavoriteWithMember_id:[userdefault objectForKey:@"member_id"] video_id:model.video_id];
}

- (void)isFavorite:(id )dict
{
    //    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSString * str = [NSString stringWithFormat:@"%@",dict[@"data"][@"is_favorite"]];
            
            if([str isEqualToString:@"1"])
            {
                [self.btn_collect setBackgroundImage:[UIImage imageNamed:@"shoucangH"] forState:(UIControlStateNormal)];
                [self.btn_collect setTintColor:[UIColor whiteColor]];
                
                self.label_collect.textColor = navi_bar_bg_color;

                self.btn_collect.selected = YES;
            }
            else
            {
                [self.btn_collect setBackgroundImage:[UIImage imageNamed:@"01collect_16"] forState:(UIControlStateNormal)];
                
                self.label_collect.textColor = [UIColor grayColor];

                self.btn_collect.selected = NO;
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
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] maskType:SVProgressHUDMaskTypeBlack];
    }
}



#pragma mark - 懒加载
- (NSMutableArray *)arr_data
{
    if(_arr_data == nil)
    {
        self.arr_data = [NSMutableArray array];
    }
    return _arr_data;
}

- (NSMutableArray *)arr_data1
{
    if(_arr_data1 == nil)
    {
        self.arr_data1 = [NSMutableArray array];
    }
    
    return _arr_data1;
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

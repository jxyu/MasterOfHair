//
//  PinglunViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/3/19.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "PinglunViewController.h"
#import "Shuoshuo_Model.h"
#import "MoviePlayer.h"

@interface PinglunViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    UIViewController *recordController;
    MoviePlayer *moviePlayerview;
}

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * arr_replylist;

@property (nonatomic, strong) NSMutableArray * arr_filelist;

//头部栏
@property (nonatomic, strong) UIView * view_bg;

@property (nonatomic, strong) UILabel * name;
@property (nonatomic, strong) UIImageView * image_touxiang;
@property (nonatomic, strong) UILabel * time;
@property (nonatomic, strong) UILabel * talk_content;
//数据
@property (nonatomic, strong) Shuoshuo_Model * model_all;


//底部栏
@property (nonatomic, strong) UIView * bottom_View;
@property (nonatomic, strong) UITextField * bottom_text;
@property (nonatomic, strong) UIButton * bottom_btn;


@property (nonatomic, strong) NSString * index;
@property (nonatomic, strong) UIView * view_viewbg;

@property (nonatomic, strong) UIScrollView * scrollView;

@end

@implementation PinglunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self p_navi];
    
    [self p_setupView];
    
    [self p_bottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navi
- (void)p_navi
{
    _lblTitle.text = [NSString stringWithFormat:@"评论"];
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
    [self p_data];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.view_bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height)];
    self.tableView.tableHeaderView = self.view_bg;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - 代理
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr_replylist.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.arr_replylist.count != 0)
    {
        Shuoshuo_Model * model = self.arr_replylist[indexPath.row];

        CGFloat x_length = [model.reply_content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 120 - 10, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;

        return 60 + x_length + 10;
    }
    else
    {
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView * image1 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 5, 50, 50)];
    image1.layer.cornerRadius = 25;
    image1.layer.masksToBounds = YES;
//    image1.backgroundColor = [UIColor orangeColor];
    [cell addSubview:image1];
    
    
    UILabel * label_name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image1.frame) + 5, 15, (SCREEN_WIDTH - CGRectGetMaxX(image1.frame)) / 2, 25)];
    label_name.text = @"剃头匠";
//    label_name.backgroundColor = [UIColor orangeColor];
    label_name.textColor = [UIColor grayColor];
    
    [cell addSubview:label_name];
    
    
    UILabel * date = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_name.frame) , 15, (SCREEN_WIDTH - CGRectGetMaxX(image1.frame)) / 2 - 10, 25)];
    date.text = @"11:11";
    date.textColor = [UIColor grayColor];
    date.font = [UIFont systemFontOfSize:13];
    date.textAlignment = NSTextAlignmentRight;
    
    [cell addSubview:date];
    
    
    if(self.arr_replylist.count != 0)
    {
        Shuoshuo_Model * model = self.arr_replylist[indexPath.row];
        
        //赋值
        [image1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/member/%@",Url_pic,model.member_headpic]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
        label_name.text = model.member_username;
        
        
        //时间
        NSString * str = [model.reply_time substringFromIndex:10];
        NSString * str1 = [str substringToIndex:6];
        
        NSString* string = model.reply_time;
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate * tiem = [format dateFromString:string];
        NSDate * x = [tiem dateByAddingTimeInterval:8 * 60 * 60];
        
        
        NSString * str2 = [self compareDate:x];
        
        if([str2 isEqualToString:@"今天"] || [str2 isEqualToString:@"昨天"])
        {
            date.text = [NSString stringWithFormat:@"%@ %@",[self compareDate:x],str1];
            
        }
        else
        {
            NSString * str_yy = [str2 substringToIndex:10];
            
            NSString * str_mm_dd = [str_yy substringFromIndex:5];
            
            date.text = [NSString stringWithFormat:@"%@ %@",str_mm_dd,str1];
        }
        
        
        CGFloat x_length = [model.reply_content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - CGRectGetMaxX(image1.frame) - 10, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        //            NSLog(@"%f",x_length);
        
        UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image1.frame), CGRectGetMaxY(image1.frame) + 5, SCREEN_WIDTH - CGRectGetMaxX(image1.frame) - 10, x_length)];
        detail.text = @"剃头匠";
        detail.numberOfLines = 0;
        detail.font = [UIFont systemFontOfSize:15];
//        detail.backgroundColor = [UIColor orangeColor];
        
        [cell addSubview:detail];
        //赋值
        detail.text = model.reply_content;
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image1.frame), CGRectGetMaxY(detail.frame) + 10, SCREEN_WIDTH - CGRectGetMaxX(image1.frame), 1)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [cell addSubview:line];
        
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [self.bottom_text becomeFirstResponder];
    
    if(self.arr_replylist.count != 0)
    {
        Shuoshuo_Model * model = self.arr_replylist[indexPath.row];
    
        self.index = [NSString stringWithFormat:@"%ld",indexPath.row];
        //回复
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        
        if([[userdefault objectForKey:@"member_id"] isEqualToString:model.member_id])
        {
            
        }
        else
        {
            self.bottom_text.placeholder = [NSString stringWithFormat:@"对%@进行回复",model.member_username];

        }
    }
    
}

#pragma mark - 说说点击事件
- (void)btnshuoshuoAction:(UIButton *)sender
{
    self.bottom_View.hidden = YES;
    [self.bottom_text resignFirstResponder];
    
//    if(self.view_viewbg.hidden == 1)
//    {
//        Shuoshuo_Model * modle_list = self.arr_filelist[sender.tag];
//#warning 轮播效果
//        if([modle_list.file_type isEqualToString:@"1"])
//        {//图片
//            self.view_viewbg.hidden = NO;
//            
//            CGFloat length = (SCREEN_WIDTH - 90) / 3;
//            
//            UIImageView * image = [[UIImageView alloc] init];
//            image.frame = CGRectMake(SCREEN_WIDTH  / 2 - length / 2, SCREEN_HEIGHT  / 2 - (length + 0) / 2, length, length + 0);
//            image.tag = 1000000;
//            [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/talk/%@",Url_pic,modle_list.file_path]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
//            [UIView animateWithDuration:0.7 animations:^{
//                
//                image.frame = CGRectMake(0, SCREEN_HEIGHT / 5, SCREEN_WIDTH, SCREEN_HEIGHT / 5 * 3);
//                
//            } completion:^(BOOL finished) {
//                
//            }];
//            
//            [self.view_viewbg addSubview:image];
//        }
    if(self.view_viewbg.hidden == 1)
    {
        Shuoshuo_Model * modle_list = self.arr_filelist[sender.tag];
        
        if([modle_list.file_type isEqualToString:@"1"])
        {
            self.view_viewbg.hidden = NO;
            
            self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 5, SCREEN_WIDTH, SCREEN_HEIGHT / 5 * 3)];
            self.scrollView .backgroundColor = [UIColor blackColor];
            self.scrollView.showsHorizontalScrollIndicator = NO;
            
            self.scrollView .contentSize = CGSizeMake(SCREEN_WIDTH * [self.arr_filelist count], 0);
            self.scrollView .pagingEnabled = YES;
            self.scrollView.tag = 5000000;
            
            for (int i = 0 ; i < [self.arr_filelist count]; i ++)
            {
                Shuoshuo_Model * model_pic = self.arr_filelist[i];
                
                CGFloat length = (SCREEN_WIDTH - 90) / 3;
                UIImageView * image = [[UIImageView alloc] init];
                image.frame = CGRectMake(SCREEN_WIDTH  / 2 - length / 2 + SCREEN_WIDTH * i, SCREEN_HEIGHT / 5 + (length) / 2, length, length);
                
                [UIView animateWithDuration:0.7 animations:^{
                    
                    image.frame = CGRectMake(0 + SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 5 * 3);
                    
                } completion:^(BOOL finished) {
                    
                }];
                [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/talk/%@",Url_pic,model_pic.file_path]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
                
                [self.scrollView  addSubview:image];
            }
            
            self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * (sender.tag), 0);
            
            [self.view addSubview:self.scrollView];
            
        }
        else if([modle_list.file_type isEqualToString:@"2"])
        {//视频
            
            self.view_viewbg.hidden = NO;
            //视频URL
            NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/talk/%@",Url_pic,modle_list.file_path]];
            //            NSURL * url=[NSURL URLWithString:@"http://192.168.1.245/titoujiang/uploads/video/16-03-24/video_145880497031844.mp4"];
            
            moviePlayerview = [[MoviePlayer alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 5, SCREEN_WIDTH, SCREEN_HEIGHT / 5 * 3) URL:url];
            moviePlayerview.tag = 10000000001;
            [self.view_viewbg addSubview:moviePlayerview];
            
        }
    }
}

#pragma mark - 回到说说
- (void)tapGesture:(id)sender
{
    if(self.view_viewbg.hidden == 0)
    {
        self.view_viewbg.hidden = YES;
        
        UIImageView * image = [self.view viewWithTag:1000000];
        [image removeFromSuperview];
        
        [moviePlayerview stopPlayer];
        MoviePlayer * movie = [self.view viewWithTag:10000000001];
        [movie removeFromSuperview];
        
        UIScrollView * scrollView = [self.view viewWithTag:5000000];
        [scrollView removeFromSuperview];
    }
}




#pragma mark - 数据
- (void)p_data
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"create:"];
    
    [dataprovider TakeGoodWithTalk_id:self.talk_id member_id:[userdefault objectForKey:@"member_id"]];
}

//接口
- (void)create:(id )dict
{
//    NSLog(@"%@",dict);
    
    self.arr_replylist = nil;
    self.arr_filelist = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            self.model_all = [[Shuoshuo_Model alloc] init];
            
            NSArray * arr_all = dict[@"data"][@"talklist"];
            [self.model_all setValuesForKeysWithDictionary:arr_all.firstObject];
            
            NSDictionary * dic_fileList = arr_all.firstObject;
            
            for (NSDictionary * dict_list in dic_fileList[@"filelist"])
            {
                Shuoshuo_Model * model = [[Shuoshuo_Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dict_list];
                
                if([model.file_id length] != 0)
                {
                    [self.arr_filelist addObject:model];
                }
            }
            
            for (NSDictionary * dict_reply in dic_fileList[@"replylist"])
            {
                Shuoshuo_Model * model = [[Shuoshuo_Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dict_reply];
                
                if([model.member_id length] != 0)
                {
                    [self.arr_replylist addObject:model];
                }
            }
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            self.image_touxiang = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
//            self.image_touxiang.backgroundColor = [UIColor orangeColor];
            self.image_touxiang.layer.cornerRadius = 25;
            self.image_touxiang.layer.masksToBounds = YES;
            
            [self.view_bg addSubview:self.image_touxiang];
            
            
            self.name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.image_touxiang.frame) + 10, 15, SCREEN_WIDTH - CGRectGetMaxX(self.image_touxiang.frame) - 30 - 110, 25)];
            self.name.text = @"wolajiwolaji";
            //        self.name.backgroundColor = [UIColor orangeColor];
            self.name.textColor = [UIColor grayColor];
            
            [self.view_bg addSubview:self.name];
            
            
            self.time = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.name.frame) + 10, 15, 110, 25)];
            self.time.text = @"wolajiwolaji";
            self.time.font = [UIFont systemFontOfSize:15];
            self.time.textColor = [UIColor grayColor];
            self.time.textAlignment = NSTextAlignmentRight;
            
            [self.view_bg addSubview:self.time];
            
            //赋值
            [self.image_touxiang sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/member/%@",Url_pic,self.model_all.member_headpic]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
            self.name.text = self.model_all.member_username;
            
            //时间
            NSString * str = [self.model_all.talk_time substringFromIndex:10];
            NSString * str1 = [str substringToIndex:6];
            
            NSString* string = self.model_all.talk_time;
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate * tiem = [format dateFromString:string];
            NSDate * x = [tiem dateByAddingTimeInterval:8 * 60 * 60];
            
            
            NSString * str2 = [self compareDate:x];
            
            if([str2 isEqualToString:@"今天"] || [str2 isEqualToString:@"昨天"])
            {
                self.time.text = [NSString stringWithFormat:@"%@ %@",[self compareDate:x],str1];
                
            }
            else
            {
                NSString * str_yy = [str2 substringToIndex:10];
                
                NSString * str_mm_dd = [str_yy substringFromIndex:5];
                
                self.time.text = [NSString stringWithFormat:@"%@ %@",str_mm_dd,str1];
            }

            
            
            CGFloat x_length = [self.model_all.talk_content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 90, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
            //            NSLog(@"%f",x_length);
            
            self.talk_content = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(self.image_touxiang.frame) + 5, SCREEN_WIDTH - 80, x_length)];
            self.talk_content.text = @"";
            self.talk_content.numberOfLines = 0;
            self.talk_content.font = [UIFont systemFontOfSize:15];
//            self.talk_content.backgroundColor = [UIColor orangeColor];
            
            [self.view_bg addSubview:self.talk_content];
            //赋值
            self.talk_content.text = self.model_all.talk_content;

            
            if([self.model_all.talk_content length] == 0)
            {
                self.talk_content.hidden = YES;
                
                for (int i = 0; i < [self.arr_filelist count]; i ++)
                {
                    int x = (int )i / 3;
                    int y = i % 3;
                    //                        NSLog(@"%d  %d",x,y);
                    
                    CGFloat length = (SCREEN_WIDTH - 90) / 3;
                    
                    Shuoshuo_Model * modle_list = self.arr_filelist[i];
                    
                    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(70 + (length + 5) * y, CGRectGetMaxY(self.image_touxiang.frame) + 10 + (length + 0 + 5) * x, length, length + 0)];
                    //tag
//                    image.tag = i;
                    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
                    btn.frame = CGRectMake(70 + (length + 5) * y, CGRectGetMaxY(self.image_touxiang.frame) + 10 + (length + 0 + 5) * x, length, length + 0);
                    //                    btn.backgroundColor = [UIColor orangeColor];
                    [btn addTarget:self action:@selector(btnshuoshuoAction:) forControlEvents:(UIControlEventTouchUpInside)];
                    btn.tag = i;
                    
                    image.backgroundColor = [UIColor orangeColor];
                    
                    if([modle_list.file_type isEqualToString:@"1"])
                    {
                        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/talk/%@",Url_pic,modle_list.file_path]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
                    }
                    else
                    {
                        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/talk/%@",Url_pic,modle_list.file_name]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
                    }
                    
                    [self.view_bg addSubview:image];
                    
                    [self.view_bg addSubview:btn];
                    //加视频覆盖
                    if([modle_list.file_type isEqualToString:@"2"])
                    {
                        UIImageView * image_pic = [[UIImageView alloc] init];
                        image_pic.frame = CGRectMake(70 + length/ 2 - 12.5, CGRectGetMaxY(self.talk_content.frame) + length / 2 - 25.5, 25, 25);
                        image_pic.image = [UIImage imageNamed:@"qwertkjkdjfkd"];
                        [self.view_bg addSubview:image_pic];
                    }
                }
                
            }
            else
            {
                for (int i = 0; i < [self.arr_filelist count]; i ++)
                {
                    int x = (int )i / 3;
                    int y = i % 3;
                    //                        NSLog(@"%d  %d",x,y);
                    
                    CGFloat length = (SCREEN_WIDTH - 90) / 3;
                    
                    Shuoshuo_Model * modle_list = self.arr_filelist[i];
                    
                    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(70 + (length + 5) * y, CGRectGetMaxY(self.talk_content.frame) + 10 + (length + 0 + 5) * x, length, length + 0)];
                    //tag
                    image.tag = i;
                    
                    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
                    btn.frame = CGRectMake(70 + (length + 5) * y, CGRectGetMaxY(self.talk_content.frame) + 10 + (length + 0 + 5) * x, length, length + 0);
                    //                    btn.backgroundColor = [UIColor orangeColor];
                    [btn addTarget:self action:@selector(btnshuoshuoAction:) forControlEvents:(UIControlEventTouchUpInside)];
                    btn.tag = i;
                    
                    image.backgroundColor = [UIColor orangeColor];
                    
                    if([modle_list.file_type isEqualToString:@"1"])
                    {
                        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/talk/%@",Url_pic,modle_list.file_path]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
                        
//                        image.image = [UIImage imageNamed:@"sudisudiusidusidu"];
                        
                    }
                    else
                    {
                        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/talk/%@",Url_pic,modle_list.file_name]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
                    }
                    [self.view_bg addSubview:image];
                    [self.view_bg addSubview:btn];
                    //加视频覆盖
                    if([modle_list.file_type isEqualToString:@"2"])
                    {
                        UIImageView * image_pic = [[UIImageView alloc] init];
                        image_pic.frame = CGRectMake(70 + length/ 2 - 12.5, CGRectGetMaxY(self.talk_content.frame) + 13 + length / 2 - 18.5, 25, 25);
                        image_pic.image = [UIImage imageNamed:@"qwertkjkdjfkd"];
                        [self.view_bg addSubview:image_pic];
                    }
                }
            }
        
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
- (void)p_bottomView
{
    self.bottom_View = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    self.bottom_View.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottom_View];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.bottom_View addSubview:line];
    
    UIView * view_1 = [[UIView alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 90, 40)];
    view_1.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    view_1.layer.borderWidth = 1;
    [self.bottom_View addSubview:view_1];
    
    UIImageView * image_1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    image_1.image = [UIImage imageNamed:@"01_3323232323"];
    [view_1 addSubview:image_1];
    
    self.bottom_text = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image_1.frame) + 10, 5, SCREEN_WIDTH - 90 - CGRectGetMaxX(image_1.frame) - 18, 30)];
    [self registerForKeyboardNotifications];
    //    self.bottom_text.backgroundColor = [UIColor orangeColor];
//    self.bottom_text.placeholder = @"我来说几句";
    self.bottom_text.delegate = self;
    [view_1 addSubview:self.bottom_text];
    
    
    self.bottom_btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.bottom_btn.frame = CGRectMake(CGRectGetMaxX(view_1.frame) + 10, 5, 60, 40);
    self.bottom_btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.bottom_btn setTitle:@"发布" forState:(UIControlStateNormal)];
    self.bottom_btn.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.bottom_btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [self.bottom_View addSubview:self.bottom_btn];
    
    [self.bottom_btn addTarget:self action:@selector(bottom_btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.view_viewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.view_viewbg.backgroundColor = [UIColor blackColor];
    self.view_viewbg.hidden = YES;
    [self.view addSubview:self.view_viewbg];
    [self.view bringSubviewToFront:self.view_viewbg];

    //手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.view_viewbg addGestureRecognizer:tapGesture];
}

- (void)bottom_btnAction:(UIButton *)sender
{
    if([self.bottom_text.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入文字后再发布评论" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
//        [self.bottom_text resignFirstResponder];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else
    {
//        NSLog(@"发布");
        [self.bottom_text resignFirstResponder];
        
        if([self.index length] == 0)
        {//直接就给内容留言
//            NSLog(@"0");
            NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];

            DataProvider * dataprovider=[[DataProvider alloc] init];
            [dataprovider setDelegateObject:self setBackFunctionName:@"talkReply:"];
            
            [dataprovider TakeGoodWithTalk_id:self.talk_id member_id:[userdefault objectForKey:@"member_id"] reply_content:self.bottom_text.text reply_status:@"0"];
            
            [SVProgressHUD showWithStatus:@"正在发布..." maskType:SVProgressHUDMaskTypeBlack];

        }
        else
        {//回复留言
//            NSLog(@"1");
            
            Shuoshuo_Model * model = self.arr_replylist[[self.index integerValue]];
            
            NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
            
            if([[userdefault objectForKey:@"member_id"] isEqualToString:model.member_id])
            {
                DataProvider * dataprovider=[[DataProvider alloc] init];
                [dataprovider setDelegateObject:self setBackFunctionName:@"talkReply:"];
                
                [dataprovider TakeGoodWithTalk_id:self.talk_id member_id:[userdefault objectForKey:@"member_id"] reply_content:self.bottom_text.text reply_status:@"0"];
                
                [SVProgressHUD showWithStatus:@"正在发布..." maskType:SVProgressHUDMaskTypeBlack];

            }
            else
            {
                
                if([[userdefault objectForKey:@"member_nickname"] length] != 0)
                {
                    NSString * str = [NSString stringWithFormat:@"%@对%@回复:%@",[userdefault objectForKey:@"member_nickname"],model.member_username,self.bottom_text.text];
                    
                    DataProvider * dataprovider=[[DataProvider alloc] init];
                    [dataprovider setDelegateObject:self setBackFunctionName:@"talkReply:"];
                    
                    [dataprovider TakeGoodWithTalk_id:self.talk_id member_id:[userdefault objectForKey:@"member_id"] reply_content:str reply_status:@"0"];
                    
                    [SVProgressHUD showWithStatus:@"正在发布..." maskType:SVProgressHUDMaskTypeBlack];
                }
                else
                {
                    NSString * str = [NSString stringWithFormat:@"%@对%@回复:%@",[userdefault objectForKey:@"member_username"],model.member_username,self.bottom_text.text];
                    
                    DataProvider * dataprovider=[[DataProvider alloc] init];
                    [dataprovider setDelegateObject:self setBackFunctionName:@"talkReply:"];
                    
                    [dataprovider TakeGoodWithTalk_id:self.talk_id member_id:[userdefault objectForKey:@"member_id"] reply_content:str reply_status:@"0"];
                    
                    [SVProgressHUD showWithStatus:@"正在发布..." maskType:SVProgressHUDMaskTypeBlack];
                }
                
                
                


            }
        }
    }
}

#pragma mark - 留言数据
- (void)talkReply:(id )dict
{
//    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"发布成功" maskType:(SVProgressHUDMaskTypeBlack)];
            
            self.bottom_text.text = nil;
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            [self p_data];
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] maskType:SVProgressHUDMaskTypeBlack];
    }
}

#pragma mark - textField代理 和通知收回键盘
- (BOOL )textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if([self.bottom_text.text length] == 0)
    {
        self.bottom_text.placeholder = @"";
        
        self.index = @"";
    }
    
    return YES;
}
//获取键盘高度
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    
    CGSize keyboardSize = [value CGRectValue].size;
    
    //    NSLog(@"keyBoard:%f", keyboardSize.height);  //
    
    [UIView animateWithDuration:0.5 animations:^{
        self.bottom_View.frame = CGRectMake(0, SCREEN_HEIGHT - 50 - keyboardSize.height, SCREEN_WIDTH, 50);
        [self.view bringSubviewToFront:self.bottom_View];
    }];
}

- (void) keyboardWasHidden:(NSNotification *) notif
{
    [UIView animateWithDuration:0.5 animations:^{
        self.bottom_View.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
        [self.view bringSubviewToFront:self.bottom_View];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.bottom_text resignFirstResponder];
    
    if([self.bottom_text.text length] == 0)
    {
        self.bottom_text.placeholder = @"";
        
        self.index = @"";
    }
}


#pragma mark - 懒加载
- (NSMutableArray *)arr_filelist
{
    if(_arr_filelist == nil)
    {
        self.arr_filelist = [NSMutableArray array];
    }
    
    return _arr_filelist;
}

- (NSMutableArray *)arr_replylist
{
    if(_arr_replylist == nil)
    {
        self.arr_replylist = [NSMutableArray array];
    }
    
    return _arr_replylist;
}


#pragma mark - 判断今天
-(NSString *)compareDate:(NSDate *)date{
    
    NSDate * today = [NSDate date];
    NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow:-86400];
    NSDate * refDate = date;
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * refDateString = [[refDate description] substringToIndex:10];
    
    if ([refDateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([refDateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }
    else
    {
        return [self formatDate:date];
    }
}

-(NSString *)formatDate:(NSDate *)date{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //[formatter setDateFormat:@"MM-dd    HH:mm"];
    NSString* str = [formatter stringFromDate:date];
    return str;
    
}


@end

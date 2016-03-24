//
//  TextDetailViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/1.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "TextDetailViewController.h"

#import "TextTableViewCell.h"
#import "NextTextViewController.h"
#import "TuwenDetail_Model.h"
#import "Pinglun_Models.h"
#import "UMSocial.h"


@interface TextDetailViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate ,UMSocialUIDelegate>

@property (nonatomic, strong) UITableView * tableView;

//headView
@property (nonatomic, strong) UIView * headView;
//头视图
@property (nonatomic, strong) UILabel * name;
@property (nonatomic, strong) UILabel * read_number;

@property (nonatomic, strong) UIImageView * image_collect;
@property (nonatomic, strong) UILabel * text_collect;
@property (nonatomic, strong) UIButton * btn_collect;

@property (nonatomic, strong) UIButton * btn_share;

@property (nonatomic, strong) UIImageView * head_image;
@property (nonatomic, strong) UILabel * head_text;

@property (nonatomic, strong) UILabel * head_comment;

//底部栏
@property (nonatomic, strong) UIView * bottom_View;
@property (nonatomic, strong) UITextField * bottom_text;
@property (nonatomic, strong) UIButton * bottom_btn;

//数据
@property (nonatomic, strong) NSMutableArray * arr_detail;

@property (nonatomic, strong) NSMutableArray * arr_pinglun;

@property (nonatomic, assign) NSInteger page;
@end

@implementation TextDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self p_navi];
    
    [self p_headView];
    
    [self p_bottomView];
    
    [self p_setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navi

- (void)p_navi
{
    _lblTitle.text = [NSString stringWithFormat:@"详情"];
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
    [self p_shifouzan];
    
    [self p_data];
    
    [self p_dataPinglun];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

#pragma mark - 布局

- (void)p_setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    __weak __typeof(self) weakSelf = self;
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self p_dataPinglun1];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf loadNewData];
    }];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableHeaderView = self.headView;
    
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
    return self.arr_pinglun.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = @"";
    if(self.arr_pinglun.count == 0)
    {
        str = @"手机打开手机的空间设计的款式简单款式简单款就是看的就是空间打开手机看的就是宽带接口设计的技术肯定就是空间打开数据库的技术可简单接口技术的间设计的款式简单款式简单款就是看的就是空间";
    }
    else
    {
        Pinglun_Models * model = self.arr_pinglun[indexPath.row];
        str = [NSString stringWithFormat:@"%@",model.comment_content];
    }

    return 95 + [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 100, 10000)    options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_textDetail" forIndexPath:indexPath];
    
    if(self.arr_pinglun.count != 0)
    {
        Pinglun_Models * model = self.arr_pinglun[indexPath.row];
        
        [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/member/%@",Url_pic,model.member_headpic]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
        //
        if([model.member_nickname length] == 0 || [model.member_nickname isEqualToString:@"<null>"])
        {
            cell.name.text = [NSString stringWithFormat:@"%@",model.member_username];
        }
        else
        {
            cell.name.text = [NSString stringWithFormat:@"%@",model.member_nickname];
        }
        
        cell.time.text = [NSString stringWithFormat:@"%@",model.comment_time];
        
        cell.detail.text = [NSString stringWithFormat:@"%@",model.comment_content];
    }
    else
    {
        cell.image.image = [UIImage imageNamed:@"placeholder_short.jpg"];
        
        cell.name.text = @"剃头匠";
        cell.detail.text = @"剃头匠";
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"评论详情");
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(self.arr_pinglun.count != 0)
    {
        Pinglun_Models * model = self.arr_pinglun[indexPath.row];
        
        NextTextViewController * nextTextViewController = [[NextTextViewController alloc] init];
        
        nextTextViewController.model = model;
        
        nextTextViewController.article_id = model.article_id;
        
        nextTextViewController.length = [model.comment_content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 100, 10000)    options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        [self showViewController:nextTextViewController sender:nil];
    }
}

#pragma mark - headView

- (void)p_headView
{
    self.headView = [[UIView alloc] init];
    self.headView.backgroundColor = [UIColor whiteColor];
    
    //标题
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 28)];
    self.name.text = @"2016年度时尚发型设计展示";
    self.name.font = [UIFont systemFontOfSize:20];
//    self.name.backgroundColor = [UIColor orangeColor];
    [self.headView addSubview:self.name];
    
    //浏览量
    UIImageView * image_1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.name.frame) + 5, 25, 25)];
    image_1.image = [UIImage imageNamed:@"yanjing"];
    [self.headView addSubview:image_1];
    
    self.read_number = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image_1.frame) + 3, CGRectGetMinY(image_1.frame) + 2.5, 50, 20)];
    self.read_number.font = [UIFont systemFontOfSize:13];
    self.read_number.text = @"1.2万";
//    self.read_number.backgroundColor = [UIColor orangeColor];
    [self.headView addSubview:self.read_number];
    
    //收藏
    self.image_collect = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.read_number.frame) + 5, CGRectGetMaxY(self.name.frame) + 5, 25, 25)];
    self.image_collect.image = [UIImage imageNamed:@"01collect_16"];
    [self.headView addSubview:self.image_collect];
    
    self.text_collect = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.image_collect.frame) + 3, CGRectGetMinY(image_1.frame) + 2.5, 50, 20)];
    self.text_collect.font = [UIFont systemFontOfSize:13];
    self.text_collect.text = @"收藏";
//        self.text_collect.backgroundColor = [UIColor orangeColor];
    [self.headView addSubview:self.text_collect];
    
    self.btn_collect = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_collect.frame = CGRectMake(CGRectGetMinX(self.image_collect.frame), CGRectGetMaxY(self.name.frame) + 5, CGRectGetMaxX(self.text_collect.frame) -  CGRectGetMinX(self.image_collect.frame), 25);
    [self.headView addSubview:self.btn_collect];
    [self.btn_collect addTarget:self action:@selector(btn_collectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //分享
    UIImageView * image_2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.btn_collect.frame) + 5, CGRectGetMaxY(self.name.frame) + 5, 25, 25)];
    image_2.image = [UIImage imageNamed:@"01share_21"];
    [self.headView addSubview:image_2];
    
    UILabel * lable_2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image_2.frame) + 3, CGRectGetMinY(image_2.frame) + 2.5, 50, 20)];
    lable_2.font = [UIFont systemFontOfSize:13];
    lable_2.text = @"分享";
    [self.headView addSubview:lable_2];
    
    self.btn_share = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_share.frame = CGRectMake(CGRectGetMinX(image_2.frame), CGRectGetMaxY(self.name.frame) + 5, CGRectGetMaxX(lable_2.frame) -  CGRectGetMinX(image_2.frame), 25);
    [self.headView addSubview:self.btn_share];
    [self.btn_share addTarget:self action:@selector(btn_shareAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.head_image = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.btn_share.frame) + 10, SCREEN_WIDTH - 20, 200)];
    self.head_image.layer.masksToBounds = YES;
    [self.head_image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Placeholder_long.jpg"]];
    [self.headView addSubview:self.head_image];
    
    
    NSString * str = @"jksjdksjkdsjkdjskjdksjkdskdksjdkskdjskjdksjdkjskdjksjdksjdksjkdjskdjksjdksjdks时间快速打开手机打开手机的就是看就看大家时间的快速健康的就是空间打开手机的空间";
    CGFloat length_x = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 10000)    options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    
    self.head_text = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.head_image.frame) + 10, SCREEN_WIDTH - 20, length_x)];
    self.head_text.text = str;
    self.head_text.numberOfLines = 0;
    self.head_text.font = [UIFont systemFontOfSize:14];
    self.head_text.textColor = [UIColor grayColor];
    [self.headView addSubview:self.head_text];
    
    //
    UILabel * label_3 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.head_text.frame) + 40, 70, 25)];
    label_3.text = @"评论";
    [self.headView addSubview:label_3];
    
    self.head_comment = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_3.frame) + 10, CGRectGetMaxY(self.head_text.frame) + 40, SCREEN_WIDTH  - CGRectGetMaxX(label_3.frame) - 20, 25)];
//    self.head_comment.backgroundColor = [UIColor orangeColor];
    self.head_comment.textColor = [UIColor grayColor];
    self.head_comment.text = @"共0条评论";
    self.head_comment.font = [UIFont systemFontOfSize:15];
    self.head_comment.textAlignment = NSTextAlignmentRight;
    [self.headView addSubview:self.head_comment];
    
    self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(label_3.frame) + 10);
}

#pragma mark - btn收藏 和 分享
- (void)btn_collectAction:(UIButton *)sender
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    if([[userdefault objectForKey:@"member_id"] length] == 0)
    {
        LoginViewController * loginViewController = [[LoginViewController alloc] init];
        
        [self showViewController:loginViewController sender:nil];
    }
    else
    {
        TuwenDetail_Model * model = self.arr_detail.firstObject;
        
        DataProvider * dataprovider=[[DataProvider alloc] init];
        [dataprovider setDelegateObject:self setBackFunctionName:@"createArticle:"];
        
        [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] article_id:model.article_id];
    }
}

- (void)btn_shareAction:(UIButton *)sender
{
    NSLog(@"分享");
    //使用第三方
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56e8cf6867e58ea9710004b8"
                                      shareText:@"快来下载剃头匠"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,nil]
                                       delegate:self];
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
    self.bottom_text.placeholder = @"我来说几句";
    self.bottom_text.delegate = self;
    [view_1 addSubview:self.bottom_text];
    
    
    self.bottom_btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.bottom_btn.frame = CGRectMake(CGRectGetMaxX(view_1.frame) + 10, 5, 60, 40);
    self.bottom_btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.bottom_btn setTitle:@"发布" forState:(UIControlStateNormal)];
    self.bottom_btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.bottom_btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [self.bottom_View addSubview:self.bottom_btn];
    
    [self.bottom_btn addTarget:self action:@selector(bottom_btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)bottom_btnAction:(UIButton *)sender
{
    if([self.bottom_text.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入文字后再发布评论" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        [self.bottom_text resignFirstResponder];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else
    {
//        NSLog(@"发布");
        [self.bottom_text resignFirstResponder];
        
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        
        if([[userdefault objectForKey:@"member_id"] length] == 0)
        {
            LoginViewController * loginViewController = [[LoginViewController alloc] init];
            
            [self showViewController:loginViewController sender:nil];
        }
        else
        {
            DataProvider * dataprovider=[[DataProvider alloc] init];
            [dataprovider setDelegateObject:self setBackFunctionName:@"createLiuyan:"];
            
            [dataprovider createWithArticle_id:self.article_id reply_id:@"0" member_id:[userdefault objectForKey:@"member_id"] comment_content:self.bottom_text.text];
        }
    }
}

#pragma mark - textField代理 和通知收回键盘
- (BOOL )textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
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
}

#pragma mark - 数据加载
- (void)p_data
{
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getArticles:"];
    
    [dataprovider getArticlesWithArticle_id:self.article_id];
}

- (void)getArticles:(id )dict
{
//    NSLog(@"%@",dict);

    self.arr_detail = nil;
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"articlelist"])
            {
                TuwenDetail_Model * model = [[TuwenDetail_Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_detail addObject:model];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            
            TuwenDetail_Model * model = self.arr_detail.firstObject;
            
            self.name.text = [NSString stringWithFormat:@"%@",model.article_title];
            
            if([model.article_click length] * 2 >= 5)
            {
                float x = [model.article_click integerValue] / 10000.0;
                self.read_number.text = [NSString stringWithFormat:@"%.2f万",x];
            }
            else
            {
                self.read_number.text = [NSString stringWithFormat:@"%@",model.article_click];
            }
            
            self.head_image.layer.masksToBounds = YES;
            [self.head_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/article/%@",Url_pic,model.article_pic]] placeholderImage:[UIImage imageNamed:@"placeholder_short.jpg"]];
            
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

#pragma mark - 获取某条图文的一级评论列表并分页
- (void)p_dataPinglun
{
    self.page = 1;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getCommentList:"];
    
    [dataprovider getCommentListWithArticle_id:self.article_id reply_id:@"0" pagenumber:@"1" pagesize:@"10"];
}

- (void)p_dataPinglun1
{
    self.page ++;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getCommentList1:"];
    
    [dataprovider getCommentListWithArticle_id:self.article_id reply_id:@"0" pagenumber:[NSString stringWithFormat:@"%ld",self.page] pagesize:@"10"];
}

- (void)getCommentList:(id )dict
{
//    NSLog(@"%@",dict);
    
    self.arr_pinglun = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"commentlist"])
            {
                Pinglun_Models * model = [[Pinglun_Models alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_pinglun addObject:model];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            self.head_comment.text = [NSString stringWithFormat:@"共%@条评论",dict[@"data"][@"page"][@"total"]];
            
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

- (void)getCommentList1:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"commentlist"])
            {
                Pinglun_Models * model = [[Pinglun_Models alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_pinglun addObject:model];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            self.head_comment.text = [NSString stringWithFormat:@"共%@条评论",dict[@"data"][@"page"][@"total"]];
            
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

#pragma mark - 点赞
- (void)createArticle:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            if([self.image_collect.image isEqual:[UIImage imageNamed:@"01collect_16"]])
            {
                //收藏
                self.image_collect.image = [UIImage imageNamed:@"h_collect"];
                self.text_collect.textColor = navi_bar_bg_color;
            }
            else
            {
                //取消收藏
                self.image_collect.image = [UIImage imageNamed:@"01collect_16"];
                self.text_collect.textColor = [UIColor blackColor];
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


#pragma mark - 发布评论接口
- (void)createLiuyan:(id )dict
{
    //    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"评论成功" maskType:(SVProgressHUDMaskTypeBlack)];
            
            self.bottom_text.text = nil;
            
            [self p_dataPinglun];
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

#pragma mark - 是否点赞
- (void)p_shifouzan
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    if([[userdefault objectForKey:@"member_id"] length] != 0)
    {
        DataProvider * dataprovider=[[DataProvider alloc] init];
        [dataprovider setDelegateObject:self setBackFunctionName:@"isFavorite:"];
        
        [dataprovider isFavoriteWithMember_id:[userdefault objectForKey:@"member_id"] article_id:self.article_id];
    }
}

- (void)isFavorite:(id )dict
{
    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSString * str = [NSString stringWithFormat:@"%@",dict[@"data"][@"is_favorite"]];
            
            if([str isEqualToString:@"1"])
            {//点赞状态
                //收藏
                self.image_collect.image = [UIImage imageNamed:@"h_collect"];
                self.text_collect.textColor = navi_bar_bg_color;
            }
            else
            {
                //取消收藏
                self.image_collect.image = [UIImage imageNamed:@"01collect_16"];
                self.text_collect.textColor = [UIColor blackColor];
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
- (NSMutableArray *)arr_detail
{
    if(_arr_detail == nil)
    {
        self.arr_detail = [NSMutableArray array];
    }
    
    return _arr_detail;
}

- (NSMutableArray *)arr_pinglun
{
    if(_arr_pinglun == nil)
    {
        self.arr_pinglun = [NSMutableArray array];
    }
    
    return _arr_pinglun;
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

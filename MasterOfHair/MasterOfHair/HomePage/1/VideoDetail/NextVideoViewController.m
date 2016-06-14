//
//  NextVideoViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/3/7.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "NextVideoViewController.h"

#import "Pinglun_Models.h"
#import "NextTextTableViewCell.h"
@interface NextVideoViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView * tableView;
//头视图
@property (nonatomic, strong) UIView * head_view;

@property (nonatomic, strong) UIImageView * head_image;
@property (nonatomic, strong) UILabel * head_name;
@property (nonatomic, strong) UILabel * head_time;
@property (nonatomic, strong) UILabel * head_detail;

//底部栏
@property (nonatomic, strong) UIView * bottom_View;
@property (nonatomic, strong) UITextField * bottom_text;
@property (nonatomic, strong) UIButton * bottom_btn;

//数据
@property (nonatomic, strong) NSMutableArray * arr_data;

@property (nonatomic, assign) NSInteger page;

@end

@implementation NextVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
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
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 80, 0, 0);
    
    [self.view addSubview:self.tableView];
    
    __weak __typeof(self) weakSelf = self;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self p_data1];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf loadNewData];
    }];
    
    self.tableView.tableHeaderView = self.head_view;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //注册
    [self.tableView registerClass:[NextTextTableViewCell class] forCellReuseIdentifier:@"cell_pinglun"];
}

#pragma mark - tableview代理
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr_data.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    NSString * str = @"";
    
    if(self.arr_data.count == 0)
    {
        str = @"手机打开手机的空间设计的款式简单款式简单款就是看的就是空间打开手机看的就是宽带接口设计的";
    }
    else
    {
        Pinglun_Models * model = self.arr_data[indexPath.row];
        
        str = [NSString stringWithFormat:@"%@",model.discuss_content];
    }
    
    return 80 + [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 80 - 50 - 20, 10000)    options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NextTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_pinglun" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(self.arr_data.count != 0)
    {
        Pinglun_Models * model = self.arr_data[indexPath.row];
        
        [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/member/%@",Url_pic,model.member_headpic]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
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
    else
    {
        cell.image.image = [UIImage imageNamed:@"placeholder_short.jpg"];
        
        cell.name.text = @"剃头匠";
        cell.detail.text = @"剃头匠";
    }
    
    
    return cell;
}

#pragma mark - 头部栏
- (void)p_headView
{
    self.head_view = [[UIView alloc] init];
    
    
    self.head_image = [[UIImageView alloc] init];
    self.head_image.frame = CGRectMake(10, 10, 60, 60);
//    self.head_image.backgroundColor = [UIColor orangeColor];
    self.head_image.layer.cornerRadius = 30;
    self.head_image.layer.masksToBounds = YES;
    [self.head_view addSubview:self.head_image];
    
    [self.head_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/member/%@",Url_pic,self.model_pinglu.member_headpic]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    
    self.head_name = [[UILabel alloc] init];
    self.head_name.textColor = [UIColor grayColor];
    self.head_name.frame = CGRectMake(CGRectGetMaxX(self.head_image.frame) + 10, CGRectGetMinY(self.head_image.frame) + 5, SCREEN_WIDTH - 50 - CGRectGetMaxX(self.head_image.frame) - 10, 20);
    self.head_name.text = @"哈哈和还好";
    //    self.head_name.backgroundColor = [UIColor orangeColor];
    self.head_name.font = [UIFont systemFontOfSize:14];
    [self.head_view addSubview:self.head_name];
    
    if([self.model_pinglu.member_nickname length] == 0 || [self.model_pinglu.member_nickname isEqualToString:@"<null>"])
    {
        self.head_name.text = [NSString stringWithFormat:@"%@",self.model_pinglu.member_username];
    }
    else
    {
        self.head_name.text = [NSString stringWithFormat:@"%@",self.model_pinglu.member_nickname];
    }
    
    self.head_time = [[UILabel alloc] init];
    self.head_time.frame = CGRectMake(CGRectGetMaxX(self.head_image.frame) + 10, CGRectGetMaxY(self.head_name.frame) + 5, SCREEN_WIDTH - 50 - CGRectGetMaxX(self.head_image.frame) - 10, 20);
    self.head_time.textColor = [UIColor grayColor];
    self.head_time.text = @"2016-03-01 22:20:11";
    //        self.head_time.backgroundColor = [UIColor orangeColor];
    self.head_time.font = [UIFont systemFontOfSize:14];
    [self.head_view addSubview:self.head_time];
        
    self.head_time.text = [NSString stringWithFormat:@"%@",self.model_pinglu.discuss_time];

    
//    NSString * str = @"jksjdksjkdsjkdjskjdksjkdskdksjdkskdjskjdksj手机的空间";
//    CGFloat length_x = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - CGRectGetMaxX(self.head_image.frame) - 20, 10000)    options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    
    self.head_detail = [[UILabel alloc] init];
    self.head_detail.frame = CGRectMake(CGRectGetMaxX(self.head_image.frame) + 10, CGRectGetMaxY(self.head_image.frame) + 5, SCREEN_WIDTH - CGRectGetMaxX(self.head_image.frame) - 20, self.length);
    self.head_detail.font = [UIFont systemFontOfSize:14];
//    self.head_detail.text = @"剃头匠";
    self.head_detail.numberOfLines = 0;
    [self.head_view addSubview:self.head_detail];
    
    self.head_detail.text = [NSString stringWithFormat:@"%@",self.model_pinglu.discuss_content];
    
    self.head_view.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(self.head_detail.frame) + 10);
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
    self.bottom_btn.titleLabel.font = [UIFont systemFontOfSize:19];
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
        NSLog(@"发布");
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
            
            [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] discuss_content:self.bottom_text.text video_id:[NSString stringWithFormat:@"%@",self.model_pinglu.video_id] reply_id:self.model_pinglu.discuss_id];
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

#pragma mark - 列表数据
- (void)p_data
{
    self.page = 1;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getReplyList:"];
    
    [dataprovider getReplyListWithDiscuss_id:self.discuss_id pagenumber:@"1" pagesize:@"10"];
}

- (void)p_data1
{
    self.page ++;
    
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getReplyList1:"];
    
    [dataprovider getReplyListWithDiscuss_id:self.discuss_id pagenumber:[NSString stringWithFormat:@"%ld",(long)self.page] pagesize:@"10"];
}

#pragma mark - 数据
//掉数据
- (void)getReplyList:(id )dict
{
//    NSLog(@"%@",dict);
    
    self.arr_data = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSArray * arr_ = dict[@"data"][@"discusslist"];
            
            NSDictionary * dic = arr_.firstObject;
            
            for (NSDictionary * dict_data in dic[@"replylist"])
            {
                Pinglun_Models * model_data = [[Pinglun_Models alloc] init];
                
                [model_data setValuesForKeysWithDictionary:dict_data];
                
                [self.arr_data addObject:model_data];
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

- (void)getReplyList1:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSArray * arr_ = dict[@"data"][@"discusslist"];
            
            NSDictionary * dic = arr_.firstObject;
            
            for (NSDictionary * dict_data in dic[@"replylist"])
            {
                Pinglun_Models * model_data = [[Pinglun_Models alloc] init];
                
                [model_data setValuesForKeysWithDictionary:dict_data];
                
                [self.arr_data addObject:model_data];
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



#pragma mark - 发布评论接口
- (void)createLiuyan:(id )dict
{
    //    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"评论成功" maskType:(SVProgressHUDMaskTypeBlack)];
            
            self.bottom_text.text = nil;
            
            [self p_data];
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
- (NSMutableArray * )arr_data
{
    if(_arr_data == nil)
    {
        self.arr_data = [NSMutableArray array];
    }
    
    return _arr_data;
}

#pragma mark - 下拉刷新
- (void)example01
{
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}

-(void)example02
{
    
    [self.tableView.mj_footer beginRefreshing];
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    });
    
}



@end

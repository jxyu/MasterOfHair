//
//  ZhaopingfabuViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/3/22.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "ZhaopingfabuViewController.h"

#import "xinziViewController.h"
#import "fenleifabuViewController.h"
#import "fabudizhiViewController.h"

#import "VPImageCropperViewController.h"
#define ORIGINAL_MAX_WIDTH 640.0f

@interface ZhaopingfabuViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate ,UIImagePickerControllerDelegate, UINavigationControllerDelegate,VPImageCropperDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) UITextField * text_jingli;
@property (nonatomic, strong) UITextField * text_jingli1;

@property (nonatomic, strong) UIImageView * image_pic;
@property (nonatomic, strong ) UIView * view_bg;



@property (nonatomic, strong) UIImageView * portraitImageView;
@property (nonatomic, strong) NSData * imageData;

//
@property (nonatomic, strong) NSMutableArray * arr_data;

@end

@implementation ZhaopingfabuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arr_data = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy;
    
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
    _lblTitle.text = [NSString stringWithFormat:@"详情页"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    _lblLeft.text=@"返回";
    _lblLeft.textAlignment=NSTextAlignmentLeft;
    
    _btnRight.hidden = YES;
}

//返回
- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    UITextField * text_1 = [self.view viewWithTag:100];
    UIImageView * image_1 = [self.view viewWithTag:101];
    if([[userdefault objectForKey:@"zhaopingxinzi_name_1"] length] != 0)
    {
        text_1.text =  [userdefault objectForKey:@"zhaopingxinzi_name_1"];
        image_1.hidden = YES;
        
        [self.arr_data replaceObjectAtIndex:2 withObject:[userdefault objectForKey:@"zhaopingxinzi_name_1"]];
    }
    else
    {
        text_1.placeholder = @"请选择薪资区间";
        image_1.hidden = NO;
        [self.arr_data replaceObjectAtIndex:2 withObject:@""];
        
    }
    
    
    UITextField * text_2 = [self.view viewWithTag:200];
    UIImageView * image_2 = [self.view viewWithTag:201];
    if([[userdefault objectForKey:@"zhaopingfei_name_2"] length] != 0)
    {
        text_2.text =  [userdefault objectForKey:@"zhaopingfei_name_2"];
        image_2.hidden = YES;
        
        [self.arr_data replaceObjectAtIndex:3 withObject:[userdefault objectForKey:@"zhaopingfei_name_2"]];
    }
    else
    {
        text_2.placeholder = @"请选择分类";
        image_2.hidden = NO;
        [self.arr_data replaceObjectAtIndex:3 withObject:@""];
    }
    
    UITextField * text_3 = [self.view viewWithTag:300];
    UIImageView * image_3 = [self.view viewWithTag:301];
    if([[userdefault objectForKey:@"diquweizhi3_"] length] != 0)
    {
        text_3.text =  [userdefault objectForKey:@"diquweizhi3_"];
        image_3.hidden = YES;
        
        [self.arr_data replaceObjectAtIndex:4 withObject:[userdefault objectForKey:@"diquweizhi3_"]];
    }
    else
    {
        text_3.placeholder = @"请选择城市";
        image_3.hidden = NO;
        [self.arr_data replaceObjectAtIndex:4 withObject:@""];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //刷新tableView(记住,要更新放在主线程中)
        
        [self.tableView reloadData];
    });
    
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self p_headView];
    
    self.tableView.tableHeaderView = self.view_bg;    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - 头布局
- (void)p_headView
{
    self.view_bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    self.view_bg.backgroundColor = [UIColor whiteColor];
    
    UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 10)];
    view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view_bg addSubview:view_line];
    
    self.image_pic = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 80, 80)];
    //    self.image_pic.backgroundColor = [UIColor orangeColor];
    self.image_pic.image = [UIImage imageNamed:@"shuoshuo111111111"];
    [self.view_bg addSubview:self.image_pic];
    
    self.image_pic.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture4:)];
    tapGesture4.numberOfTapsRequired = 1; //点击次数
    tapGesture4.numberOfTouchesRequired = 1; //点击手指数
    [self.image_pic addGestureRecognizer:tapGesture4];
}


#pragma mark - 代理
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 17;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 6 || indexPath.row == 13 || indexPath.row == 16)
    {
        return 100;
    }
    else if(indexPath.row == 7 || indexPath.row == 14)
    {
        return 10;
    }
    else
    {
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    switch (indexPath.row)
    {
        case 0:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.text = @"招聘职位";
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 10, 1, 30)];
            view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            
            if([self.arr_data[0] length] == 0)
            {
                detail.placeholder = @"请输入招聘职位";
            }
            else
            {
                detail.text = self.arr_data[0];
            }
            
            detail.delegate = self;
            detail.tag = 10001;
            detail.clearButtonMode = UITextFieldViewModeAlways;
            [cell addSubview:detail];
        }
            break;
        case 1:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.text = @"招聘人数";
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 10, 1, 30)];
            view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            
            if([self.arr_data[1] length] == 0)
            {
                detail.placeholder = @"请输入招聘的人数";
            }
            else
            {
                detail.text = self.arr_data[1];
            }
            
            detail.delegate = self;
            detail.tag = 10002;
            detail.clearButtonMode = UITextFieldViewModeAlways;
            [cell addSubview:detail];
        }
            break;
        case 2:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.text = @"预计薪资";
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 10, 1, 30)];
            view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15 - 30, 30)];
            detail.enabled = NO;
            if ([self.arr_data[2] length] == 0)
            {
                detail.placeholder = @"请选择薪资区间";
            }
            else
            {
                detail.text = self.arr_data[2];
            }
            [cell addSubview:detail];
            
            UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(detail.frame) + 5, 12.5, 25, 25)];
            image.image = [UIImage imageNamed:@"01fanhui_07"];
            
            detail.tag = 100;
            image.tag = 101;
            
            [cell addSubview:image];
        }
            break;
        case 3:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            //            name.textColor = [UIColor grayColor];
            name.text = @"职位分类";
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 10, 1, 30)];
            view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15 - 30, 30)];
            detail.enabled = NO;
            
            if ([self.arr_data[3] length] == 0)
            {
                detail.placeholder = @"请选择分类";
            }
            else
            {
                detail.text = self.arr_data[3];
            }
            
            [cell addSubview:detail];
            
            UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(detail.frame) + 5, 12.5, 25, 25)];
            image.image = [UIImage imageNamed:@"01fanhui_07"];
            
            detail.tag = 200;
            image.tag = 201;
            
            [cell addSubview:image];
        }
            break;
        case 4:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            //            name.textColor = [UIColor grayColor];
            name.text = @"选择城市";
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 10, 1, 30)];
            view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15 - 30, 30)];
            detail.enabled = NO;
            
            
            if ([self.arr_data[4] length] == 0)
            {
                detail.placeholder = @"请选择城市";
            }
            else
            {
                detail.text = self.arr_data[4];
            }
            
            [cell addSubview:detail];
            
            UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(detail.frame) + 5, 12.5, 25, 25)];
            image.image = [UIImage imageNamed:@"01fanhui_07"];
            
            detail.tag = 300;
            image.tag = 301;
            
            [cell addSubview:image];
        }
            break;
        case 5:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.text = @"工作地点";
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 10, 1, 30)];
            view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            
            if([self.arr_data[5] length] == 0)
            {
                detail.placeholder = @"请输入预计工作地点";
            }
            else
            {
                detail.text = self.arr_data[5];
            }
            
            detail.delegate = self;
            detail.tag = 10003;
            detail.clearButtonMode = UITextFieldViewModeAlways;
            [cell addSubview:detail];
        }
            break;
            
        case 6:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            //            name.textColor = [UIColor grayColor];
            name.text = @"职位描述";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 10, 1, 80)];
            view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [cell addSubview:view_line];
            
            UITextView * detail = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 80)];
            detail.delegate = self;
            detail.font = [UIFont systemFontOfSize:17];
            detail.tag = 10004;
            [cell addSubview:detail];
            
            if ([self.arr_data[6] length] == 0)
            {
                self.text_jingli = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
                self.text_jingli.delegate = self;
                self.text_jingli.placeholder = @"请输入职位描述";
                self.text_jingli.clearButtonMode = UITextFieldViewModeAlways;
                self.text_jingli.enabled = NO;
            }
            else
            {
                self.text_jingli.hidden = YES;
                detail.text = self.arr_data[6];
            }
            
            [cell addSubview:self.text_jingli];
        }
            break;
        case 7:
        {
            UIView * view_bg = [[UIView alloc] initWithFrame:CGRectMake(- 5, 0, SCREEN_WIDTH + 10, 10)];
            view_bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            [cell addSubview:view_bg];
        }
            break;
            
        case 8:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            //            name.textColor = [UIColor grayColor];
            name.text = @"公司名称";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 10, 1, 30)];
            view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            
            if([self.arr_data[7] length] == 0)
            {
                detail.placeholder = @"请输入公司名称";
            }
            else
            {
                detail.text = self.arr_data[7];
            }
            
            detail.delegate = self;
            detail.tag = 10005;
            detail.clearButtonMode = UITextFieldViewModeAlways;
            [cell addSubview:detail];
        
        }
            break;
         
        case 9:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            //            name.textColor = [UIColor grayColor];
            name.text = @"公司规模";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 10, 1, 30)];
            view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            
            if([self.arr_data[8] length] == 0)
            {
                detail.placeholder = @"请输入公司规模";
            }
            else
            {
                detail.text = self.arr_data[8];
            }
            
            detail.delegate = self;
            detail.tag = 10006;
            detail.clearButtonMode = UITextFieldViewModeAlways;
            [cell addSubview:detail];
        }
            break;
            
        case 10:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            //            name.textColor = [UIColor grayColor];
            name.text = @"公司性质";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 10, 1, 30)];
            view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            
            if([self.arr_data[9] length] == 0)
            {
                detail.placeholder = @"请输入公司性质";
            }
            else
            {
                detail.text = self.arr_data[9];
            }
            
            detail.delegate = self;
            detail.tag = 10007;
            detail.clearButtonMode = UITextFieldViewModeAlways;
            [cell addSubview:detail];
        }
            break;
          
        case 11:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            //            name.textColor = [UIColor grayColor];
            name.text = @"所属行业";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 10, 1, 30)];
            view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            
            if([self.arr_data[10] length] == 0)
            {
                detail.placeholder = @"请输入所属行业";
            }
            else
            {
                detail.text = self.arr_data[10];
            }
            
            detail.delegate = self;
            detail.tag = 10008;
            detail.clearButtonMode = UITextFieldViewModeAlways;
            [cell addSubview:detail];
        }
            break;
            
        case 12:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            //            name.textColor = [UIColor grayColor];
            name.text = @"公司地址";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 10, 1, 30)];
            view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            
            if([self.arr_data[11] length] == 0)
            {
                detail.placeholder = @"请输入公司地址";
            }
            else
            {
                detail.text = self.arr_data[11];
            }
            
            detail.delegate = self;
            detail.tag = 10009;
            detail.clearButtonMode = UITextFieldViewModeAlways;
            [cell addSubview:detail];
        }
            break;
            
        case 13:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            //            name.textColor = [UIColor grayColor];
            name.text = @"公司简介";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 10, 1, 80)];
            view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [cell addSubview:view_line];
            
            UITextView * detail = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 80)];
            detail.delegate = self;
            detail.font = [UIFont systemFontOfSize:17];
            detail.tag = 10010;
            [cell addSubview:detail];
            
            if ([self.arr_data[12] length] == 0)
            {
                self.text_jingli1 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
                self.text_jingli1.delegate = self;
                self.text_jingli1.placeholder = @"请输入公司简介";
                self.text_jingli1.clearButtonMode = UITextFieldViewModeAlways;
                self.text_jingli1.enabled = NO;
            }
            else
            {
                self.text_jingli1.hidden = YES;
                detail.text = self.arr_data[12];
            }
            
            [cell addSubview:self.text_jingli1];
        }
            break;
            
        case 14:
        {
            UIView * view_bg = [[UIView alloc] initWithFrame:CGRectMake(- 5, 0, SCREEN_WIDTH + 10, 10)];
            view_bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            [cell addSubview:view_bg];
        }
            break;
           
        case 15:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            //            name.textColor = [UIColor grayColor];
            name.text = @"联系方式";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 10, 1, 30)];
            view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            
            if([self.arr_data[13] length] == 0)
            {
                detail.placeholder = @"请输入联系方式";
            }
            else
            {
                detail.text = self.arr_data[13];
            }
            
            detail.delegate = self;
            detail.tag = 10011;
            detail.clearButtonMode = UITextFieldViewModeAlways;
            [cell addSubview:detail];
        }
            break;
            
        case 16:
        {
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            UIButton * btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
            btn.frame = CGRectMake(15, 20, SCREEN_WIDTH - 30, 40);
            [btn setTitle:@"立即发布" forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            
            btn.backgroundColor = navi_bar_bg_color;
            [cell addSubview:btn];
            
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        }
            break;
        default:
            break;
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 2:
        {
            xinziViewController * zhaopinxinziViewController = [[xinziViewController alloc] init];
            
            [self showViewController:zhaopinxinziViewController sender:nil];
        }
            break;
        case 3:
        {
            fenleifabuViewController * enleifabuViewController = [[fenleifabuViewController alloc] init];
            
            [self showViewController:enleifabuViewController sender:nil];
        }
            break;
        case 4:
        {
            fabudizhiViewController * enleifabuViewController = [[fabudizhiViewController alloc] init];
            
            [self showViewController:enleifabuViewController sender:nil];
        }
            break;
        default:
            break;
    }
}

#pragma mark - textView

- (BOOL)textViewShouldEndEditing:(UITextField *)textField
{
    if(textField.tag == 10004)
    {
        [self.arr_data replaceObjectAtIndex:6 withObject:textField.text];
    }
    else if(textField.tag == 10010)
    {
        [self.arr_data replaceObjectAtIndex:12 withObject:textField.text];
    }
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    if(textView.tag == 10004)
    {
        self.text_jingli.hidden = YES;
        
        [UIView animateWithDuration:0.7 animations:^{
            
            self.tableView.contentOffset = CGPointMake(0, 400);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    else if(textView.tag == 10010)
    {
        self.text_jingli1.hidden = YES;
        
        [UIView animateWithDuration:0.7 animations:^{
            
            self.tableView.contentOffset = CGPointMake(0, 750);
            
        } completion:^(BOOL finished) {
            
        }];
    }
}


#pragma mark - textfile
- (void )touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (int i = 1; i < 14; i ++)
    {
        UITextField * text1 = [self.view viewWithTag:10000 + i];
        [text1 resignFirstResponder];
    }
    
    UITextView * text = [self.view viewWithTag:10004];
    if([text.text length] == 0)
    {
        self.text_jingli.hidden = NO;
    }
    
    UITextView * text1 = [self.view viewWithTag:10010];
    if([text1.text length] == 0)
    {
        self.text_jingli1.hidden = NO;
    }
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.tableView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (BOOL )textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSInteger x = textField.tag - 10000;
    
    switch (x)
    {
        case 1:
        {
            [self.arr_data replaceObjectAtIndex:0 withObject:textField.text];
        }
            break;
        case 2:
        {
            [self.arr_data replaceObjectAtIndex:1 withObject:textField.text];
        }
            break;
        case 3:
        {
            [self.arr_data replaceObjectAtIndex:5 withObject:textField.text];
        }
            break;
        case 5:
        {
            [self.arr_data replaceObjectAtIndex:7 withObject:textField.text];
        }
            break;
        case 6:
        {
            [self.arr_data replaceObjectAtIndex:8 withObject:textField.text];
        }
            break;
        case 7:
        {
            [self.arr_data replaceObjectAtIndex:9 withObject:textField.text];
        }
            break;
        case 8:
        {
            [self.arr_data replaceObjectAtIndex:10 withObject:textField.text];
        }
            break;
        case 9:
        {
            [self.arr_data replaceObjectAtIndex:11 withObject:textField.text];
        }
            break;
        case 11:
        {
            [self.arr_data replaceObjectAtIndex:13 withObject:textField.text];
        }
            break;
        default:
            break;
    }
    
    return YES;
}

- (void )textFieldDidBeginEditing:(UITextField *)textField
{
    NSInteger x = textField.tag - 10000;
    
    if(x == 1)
    {
        [UIView animateWithDuration:0.7 animations:^{
            
            self.tableView.contentOffset = CGPointMake(0, 50);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if(x == 2)
    {
        [UIView animateWithDuration:0.7 animations:^{
            
            self.tableView.contentOffset = CGPointMake(0, 100);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    else if(x > 2 && x < 5)
    {
        NSIndexPath * scrollIndexPath = [NSIndexPath indexPathForRow:x + 1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
    }
    else if(x >= 5 && x < 9)
    {
        NSIndexPath * scrollIndexPath = [NSIndexPath indexPathForRow:x + 2 inSection:0];
        [self.tableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
    }
    else if(x == 9)
    {
        [UIView animateWithDuration:0.7 animations:^{
            
            self.tableView.contentOffset = CGPointMake(0, 700);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    else if(x == 11)
    {
        [UIView animateWithDuration:0.7 animations:^{
            
            self.tableView.contentOffset = CGPointMake(0, 800);
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark - 点击
- (void)btnAction:(UIButton *)sender
{
    
    for (int i = 1; i < 14; i ++)
    {
        UITextField * text1 = [self.view viewWithTag:10000 + i];
        [text1 resignFirstResponder];
    }
    
    UITextView * text = [self.view viewWithTag:10004];
    if([text.text length] == 0)
    {
        self.text_jingli.hidden = NO;
    }
    
    UITextView * text1 = [self.view viewWithTag:10010];
    if([text1.text length] == 0)
    {
        self.text_jingli1.hidden = NO;
    }
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.tableView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
        DataProvider * dataprovider=[[DataProvider alloc] init];
        
        [dataprovider setDelegateObject:self setBackFunctionName:@"Recruit:"];
        
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        //
        UITextField * text_tel = [self.view viewWithTag:10011];
        
        if(self.imageData == nil)
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"图片不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
        }
        else if([self.arr_data[0] length] == 0)
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"所填写的内容不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
        }
        else if([self.arr_data[1] length] == 0)
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"所填写的内容不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
        }
        else if([self.arr_data[2] length] == 0)
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"所选择的内容不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
        }
        else if([self.arr_data[3] length] == 0)
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"所选择的内容不能为空" preferredStyle:(UIAlertControllerStyleAlert)];

            [self presentViewController:alert animated:YES completion:^{

            }];

            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {

            }];

            [alert addAction:action];
        }
        else if([self.arr_data[4] length] == 0)
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"所选择的内容不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
        }
        else if([self.arr_data[5] length] == 0)
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"所填写的内容不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
        }
        else if([self.arr_data[6] length] == 0)
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"所填写的内容不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
        }
        else if([self.arr_data[7] length] == 0)
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"所填写的内容不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
        }
        else if([self.arr_data[8] length] == 0)
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"所填写的内容不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
        }
        else if([self.arr_data[9] length] == 0)
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"所填写的内容不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
        }
        else if([self.arr_data[10] length] == 0)
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"所填写的内容不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
        }
        else if([self.arr_data[11] length] == 0 )
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"所填写的内容不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
        }
        else if([self.arr_data[12] length] == 0 )
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"所填写的内容不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
        }
        else if([self.arr_data[13] length] == 0 || [text_tel.text length] == 0)
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"所填写的内容不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
        }
        else
        {
            if([self.arr_data[13] length] == 0)
            {
                UITextField * text = [self.view viewWithTag:10011];
                
                [SVProgressHUD showWithStatus:@"请稍等..." maskType:SVProgressHUDMaskTypeBlack];
                
                [dataprovider createWithimage:self.imageData number:self.arr_data[1] workname:self.arr_data[0] salary_id:[userdefault objectForKey:@"zhaopingxinzi_id_1"] type_id:[userdefault objectForKey:@"zhaopingfei_id_2"] area_id:[userdefault objectForKey:@"diquweizhi_id3_"] location:self.arr_data[5] job_description:self.arr_data[6] company_name:self.arr_data[7] company_locat:self.arr_data[11] company_scale:self.arr_data[8] company_brief:self.arr_data[12] company_natrue:self.arr_data[9] company_industry:self.arr_data[10] telephone:text.text];
                
                
            }
            else
            {
                [SVProgressHUD showWithStatus:@"请稍等..." maskType:SVProgressHUDMaskTypeBlack];
                
                //[userdefault objectForKey:@"diquweizhi_id3_"]
                [dataprovider createWithimage:self.imageData number:self.arr_data[1] workname:self.arr_data[0] salary_id:[userdefault objectForKey:@"zhaopingxinzi_id_1"] type_id:[userdefault objectForKey:@"zhaopingfei_id_2"] area_id:[userdefault objectForKey:@"diquweizhi_id3_"] location:self.arr_data[5] job_description:self.arr_data[6] company_name:self.arr_data[7] company_locat:self.arr_data[11] company_scale:self.arr_data[8] company_brief:self.arr_data[12] company_natrue:self.arr_data[9] company_industry:self.arr_data[10] telephone:self.arr_data[13]];
            }
        }
    }];
}

- (void)Recruit:(id )dict
{
    //    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"发布成功" maskType:(SVProgressHUDMaskTypeBlack)];
            
            [self.navigationController popViewControllerAnimated:YES];

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


#pragma mark - 照相
-(void)tapGesture4:(id)sender
{
    for (int i = 1; i < 12; i ++)
    {
        UITextField * text1 = [self.view viewWithTag:10000 + i];
        [text1 resignFirstResponder];
    }
    
    UITextView * text = [self.view viewWithTag:10004];
    if([text.text length] == 0)
    {
        self.text_jingli.hidden = NO;
    }
    
    UITextView * text1 = [self.view viewWithTag:10010];
    if([text1.text length] == 0)
    {
        self.text_jingli1.hidden = NO;
    }
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.tableView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self p_pick];
}

- (void)p_pick
{
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    self.portraitImageView.image = editedImage;
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
        [self saveImage:editedImage withName:@"avatar.jpg"];
        
        NSData *imageData = UIImagePNGRepresentation(editedImage);
        
        self.image_pic.image = editedImage;
        self.imageData = imageData;
    }];
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}
#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}
- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}



@end

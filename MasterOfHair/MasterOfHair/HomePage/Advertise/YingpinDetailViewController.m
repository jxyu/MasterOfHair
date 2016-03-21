//
//  YingpinDetailViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/3/21.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "YingpinDetailViewController.h"
#import "Advertise_Model.h"

@interface YingpinDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) Advertise_Model * model_detail;

@end

@implementation YingpinDetailViewController

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
    _lblTitle.text = [NSString stringWithFormat:@"详情页"];
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
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView代理

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 13;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 4 || indexPath.row == 10 || indexPath.row == 12)
    {
        return 10;
    }
    else if(indexPath.row == 9)
    {
        if ([self.model_detail.work_experience length] == 0)
        {
            return 50;
        }
        else
        {
          CGFloat x_length = [self.model_detail.work_experience boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 100, 10000)    options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
            
            return x_length + 30;
        }
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
            name.textColor = [UIColor grayColor];
            name.text = @"应聘职位";
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            detail.text = self.model_detail.intention_position;
            
            [cell addSubview:detail];
        }
            break;
        case 1:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"期望薪资";
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            detail.text = self.model_detail.status_name;
            
            [cell addSubview:detail];
        }
            break;
        case 2:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"职位分类";
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            detail.text = self.model_detail.type_name;
            
            [cell addSubview:detail];
        }
            break;
        case 3:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"工作地点";
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            detail.text = self.model_detail.locationid;
            
            [cell addSubview:detail];
        }
            break;
         case 4:
        {
            UIView * view_bg = [[UIView alloc] initWithFrame:CGRectMake(- 5, 0, SCREEN_WIDTH + 10, 10)];
            view_bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
//            view_bg.layer.borderColor = [UIColor grayColor].CGColor;
//            view_bg.layer.borderWidth = 1;
            
            [cell addSubview:view_bg];
        }
            break;
        case 5:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"姓名";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            detail.text = self.model_detail.name;
            
            [cell addSubview:detail];
        }
            break;
        case 6:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"年龄";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            detail.text = self.model_detail.age;
            
            [cell addSubview:detail];
        }
            break;
        case 7:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"性别";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            detail.text = self.model_detail.sex;
            
            [cell addSubview:detail];
        }
            break;
        case 8:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"居住地址";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            detail.text = self.model_detail.domicile;
            
            [cell addSubview:detail];
        }
            break;
        case 9:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"工作经历";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            CGFloat x_length = [self.model_detail.work_experience boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 100, 10000)    options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, x_length + 15)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 5, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, x_length + 20)];
            detail.numberOfLines = 0;
            detail.text = self.model_detail.work_experience;
            
            [cell addSubview:detail];
        }
            break;
        case 10:
        {
            UIView * view_bg = [[UIView alloc] initWithFrame:CGRectMake(- 5, 0, SCREEN_WIDTH + 10, 10)];
            view_bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
            //            view_bg.layer.borderColor = [UIColor grayColor].CGColor;
            //            view_bg.layer.borderWidth = 1;
            
            [cell addSubview:view_bg];
        }
            break;
        case 11:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"联系方式";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            
            UIView * view_call = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 0, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 10, 50)];
//            view_call.backgroundColor = [UIColor orangeColor];
            [cell addSubview:view_call];
            
            UIImageView * image_ = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 15, 10, 30, 30)];
            image_.image = [UIImage imageNamed:@"yijianbohao"];
//            image_.backgroundColor = [UIColor orangeColor];
            [cell addSubview:image_];
            
            UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image_.frame) , 10, 70, 30)];
            detail.textColor = navi_bar_bg_color;
            detail.text = @"一键拨号";
            
            [cell addSubview:detail];
            
            
            //手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
            tapGesture.numberOfTapsRequired = 1; //点击次数
            tapGesture.numberOfTouchesRequired = 1; //点击手指数
            [view_call addGestureRecognizer:tapGesture];
        }
            break;
        case 12:
        {
            UIView * view_bg = [[UIView alloc] initWithFrame:CGRectMake(- 5, 0, SCREEN_WIDTH + 10, 10)];
            view_bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
            //            view_bg.layer.borderColor = [UIColor grayColor].CGColor;
            //            view_bg.layer.borderWidth = 1;
            
            [cell addSubview:view_bg];
        }
        default:
            
            break;
    }
    

    return cell;
}




#pragma mark - 接口
- (void)p_data
{
    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"Recruit:"];
    //
    [dataprovider talkWithvitae_id:self.vitae_id];
}

//数据
- (void)Recruit:(id )dict
{
    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            NSArray * arr_list = dict[@"data"][@"vitaelist"];
            
            self.model_detail = [[Advertise_Model alloc] init];
            
            [self.model_detail setValuesForKeysWithDictionary:arr_list.firstObject];
            
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

#pragma mark - 点击事件
- (void)tapGesture:(id)sender
{
    if([self.model_detail.telephone length] != 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"拨打号码:%@",self.model_detail.telephone]preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
        
        
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            NSURL * url1 = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model_detail.telephone]];
            
            [[UIApplication sharedApplication] openURL:url1];
        }];
        
        [alert addAction:action1];
    }
}





@end

//
//  NewshouhuoViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/26.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "NewshouhuoViewController.h"

#import "AppDelegate.h"
#import "Shengshiqu_Model.h"
@interface NewshouhuoViewController () <UITextFieldDelegate, UIScrollViewDelegate, UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UITextField * name;
@property (nonatomic, strong) UITextField * tel;
@property (nonatomic, strong) UITextField * address;
@property (nonatomic, strong) UITextField * address_detail;

//
@property (nonatomic, strong) UIPickerView * pickerView;

@property (nonatomic, strong) UIButton * btn_ok;
@property (nonatomic, strong) UIButton * btn_cancel;

//
@property (nonatomic, assign) NSInteger index1;
@property (nonatomic, assign) NSInteger index2;
@property (nonatomic, assign) NSInteger index3;

@property (nonatomic, copy) NSString * str_address;

//数据
@property (nonatomic, strong) NSMutableArray * arr_sheng;
@property (nonatomic, strong) NSMutableArray * arr_shi;
@property (nonatomic, strong) NSMutableArray * arr_qu;


@end

@implementation NewshouhuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self p_data];
    
    [self p_navi];
    
    [self p_setupView];
    
    [self p_selectAddress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navi
- (void)p_navi
{
    _lblTitle.text = @"新建收货地址";
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    _lblLeft.text=@"返回";
    _lblLeft.textAlignment=NSTextAlignmentLeft;
    [self addRightbuttontitle:@"保存"];
}
//返回
- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//点击修改按钮
- (void)clickRightButton:(UIButton *)sender
{
    [self.name resignFirstResponder];
    [self.tel resignFirstResponder];
    [self.address_detail resignFirstResponder];
    [self.address resignFirstResponder];
    
//    NSLog(@"提示保存成功");
    if([self.name.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"收货人不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    
    if([self.tel.text length] != 11)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"收货电话格式不正确" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    
    if([self.str_address length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择省市区" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    
    if([self.address_detail.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"详细地址不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }

    //
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否保存信息" preferredStyle:(UIAlertControllerStyleAlert)];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        
        NSMutableString * str = [NSMutableString string];
        NSMutableString * str1 = [NSMutableString string];
        NSMutableString * str2 = [NSMutableString string];
        
        if(self.arr_sheng.count != 0)
        {
            Shengshiqu_Model * model = self.arr_sheng[self.index1 - 1];
            str = model.area_id.mutableCopy;
        }
        
        if(self.arr_shi.count != 0)
        {
            Shengshiqu_Model * model = self.arr_shi[self.index2];
            str1 = model.area_id.mutableCopy;
        }
        else
        {
            str1 = [NSString stringWithFormat:@""].mutableCopy;
        }
        
        if(self.arr_qu.count != 0)
        {
            Shengshiqu_Model * model = self.arr_qu[self.index3];
            str2 = model.area_id.mutableCopy;
        }
        else
        {
            str2 = [NSString stringWithFormat:@""].mutableCopy;
        }
        
        NSLog(@"%@ ----  %@ --------  %@",str,str1,str2);
        
        DataProvider * dataprovider=[[DataProvider alloc] init];
        
        [dataprovider setDelegateObject:self setBackFunctionName:@"create:"];
        
        [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] consignee:self.name.text mobile:self.tel.text province:str city:str1 area:str2 address:self.address_detail.text];
    }];
    
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action1];
    [alert addAction:action];
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
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT);
    self.scrollView.delegate = self;
    
    [self.view addSubview:self.scrollView];
    
    [self p_setupView1];
}

- (void)p_setupView1
{
    UIView * view_white = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view_white.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white];
    
    self.name = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 30)];
    self.name.placeholder = @"收货人姓名";
    self.name.delegate = self;
    self.name.font = [UIFont systemFontOfSize:15];
    [view_white addSubview:self.name];
    
    
    UIView * view_white1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_white.frame) + 2, SCREEN_WIDTH, 50)];
    view_white1.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white1];
    
    self.tel = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 30)];
    self.tel.placeholder = @"手机号码";
    self.tel.delegate = self;
    self.tel.font = [UIFont systemFontOfSize:15];
    [view_white1 addSubview:self.tel];
    
    
    
    UIView * view_white2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_white1.frame) + 2, SCREEN_WIDTH, 50)];
    view_white2.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white2];
    
    self.address = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 30)];
    self.address.placeholder = @"请选择 省 市 县";
    self.address.delegate = self;
    self.address.font = [UIFont systemFontOfSize:15];
    self.address.userInteractionEnabled = NO;
    [view_white2 addSubview:self.address];
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture1:)];
    //设置点击次数和点击手指数
    tapGesture1.numberOfTapsRequired = 1; //点击次数
    tapGesture1.numberOfTouchesRequired = 1; //点击手指数
    [view_white2 addGestureRecognizer:tapGesture1];
    
    UIView * view_white3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_white2.frame) + 2, SCREEN_WIDTH, 50)];
    view_white3.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white3];
    
    self.address_detail = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 30)];
    self.address_detail.placeholder = @"详细地址";
    self.address_detail.delegate = self;
    self.address_detail.font = [UIFont systemFontOfSize:15];
    [view_white3 addSubview:self.address_detail];
}


#pragma mark - textfiled的代理

- (BOOL )textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.name resignFirstResponder];
    [self.tel resignFirstResponder];
    [self.address_detail resignFirstResponder];
    [self.address resignFirstResponder];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if([textField isEqual:self.address])
    {
        [UIView animateWithDuration:0.7 animations:^{
            
            self.scrollView.contentOffset = CGPointMake(0, 90);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if([textField isEqual:self.address_detail])
    {
        [UIView animateWithDuration:0.7 animations:^{
            
            self.scrollView.contentOffset = CGPointMake(0, 120);
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark - scrollView代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.name resignFirstResponder];
    [self.tel resignFirstResponder];
    [self.address_detail resignFirstResponder];
    [self.address resignFirstResponder];
    
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
        self.pickerView.hidden = YES;
        self.btn_cancel.hidden = YES;
        self.btn_ok.hidden = YES;
    }];
}

#pragma mark - 地区选择器
- (void)p_selectAddress
{
    self.btn_cancel = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_cancel.frame = CGRectMake(0, SCREEN_HEIGHT - 64, 80, 30);
    [self.btn_cancel setTitle:@"取消" forState:(UIControlStateNormal)];
    [self.btn_cancel setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.btn_cancel.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.scrollView addSubview:self.btn_cancel];
    self.btn_cancel.hidden = YES;
    
    [self.btn_cancel addTarget:self action:@selector(btn_cancelAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.btn_ok = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_ok.frame = CGRectMake(SCREEN_WIDTH - 80,  SCREEN_HEIGHT - 64, 80, 30);
    [self.btn_ok setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.btn_ok setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.btn_ok.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.scrollView addSubview:self.btn_ok];
    self.btn_ok.hidden = YES;
    
    [self.btn_ok addTarget:self action:@selector(btn_okAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.btn_cancel.frame) + 10, SCREEN_WIDTH, 200)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.backgroundColor = [UIColor grayColor];
    [self.scrollView addSubview:self.pickerView];
    self.pickerView.hidden = YES;
}

//代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
            return self.arr_sheng.count;
            break;
        case 1:
            return self.arr_shi.count;
            break;
        case 2:
            return self.arr_qu.count;
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            Shengshiqu_Model * model = self.arr_sheng[row];
            
            return model.area_name;
        }
            break;
        case 1:
        {
            Shengshiqu_Model * model = self.arr_shi[row];
            
            return model.area_name;
        }
            break;
        case 2:
        {
            Shengshiqu_Model * model = self.arr_qu[row];
            
            return model.area_name;
        }
            break;
        default:
            return nil;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //    NSLog(@"%ld  --------   %ld",row,component);
    
    switch (component) {
        case 0:
        {
//            NSLog(@"%ld",(long)row);
            self.index1 = row + 1;
            //
            Shengshiqu_Model * model = self.arr_sheng[row];
            
            DataProvider * dataprovider=[[DataProvider alloc] init];
            [dataprovider setDelegateObject:self setBackFunctionName:@"getAreas1:"];
            [dataprovider getAreasWithParent_id:model.area_id];
            
        }
            break;
        case 1:
        {
            self.index2 = row;
            
            Shengshiqu_Model * model = self.arr_shi[row];
            
            DataProvider * dataprovider=[[DataProvider alloc] init];
            [dataprovider setDelegateObject:self setBackFunctionName:@"getAreas2:"];
            [dataprovider getAreasWithParent_id:model.area_id];
        }
            break;
        case 2:
        {
            self.index3 = row;
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - 地区选择的手势
- (void)tapGesture1:(id)sender
{
    
    self.pickerView.hidden = NO;
    self.btn_cancel.hidden = NO;
    self.btn_ok.hidden = NO;
    
    [self.name resignFirstResponder];
    [self.tel resignFirstResponder];
    [self.address_detail resignFirstResponder];
    [self.address resignFirstResponder];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 240);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)btn_cancelAction:(UIButton *)sender
{
    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
        self.pickerView.hidden = YES;
        self.btn_cancel.hidden = YES;
        self.btn_ok.hidden = YES;
    }];
}

- (void)btn_okAction:(UIButton *)sender
{
    
    if(self.index1 == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择地址详情" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else
    {
        NSMutableString * str = [NSMutableString string];
        NSMutableString * str1 = [NSMutableString string];
        NSMutableString * str2 = [NSMutableString string];
        
        if(self.arr_sheng.count != 0)
        {
            Shengshiqu_Model * model = self.arr_sheng[self.index1 - 1];
            str = model.area_name.mutableCopy;
        }
        
        if(self.arr_shi.count != 0)
        {
            Shengshiqu_Model * model = self.arr_shi[self.index2];
            str1 = model.area_name.mutableCopy;
        }
        
        if(self.arr_qu.count != 0)
        {
            Shengshiqu_Model * model = self.arr_qu[self.index3];
            str2 = model.area_name.mutableCopy;
        }
        
        self.str_address = [NSString stringWithFormat:@"%@%@%@",str,str1,str2];
        self.address.text = self.str_address;
        
        [UIView animateWithDuration:0.7 animations:^{
            
            self.scrollView.contentOffset = CGPointMake(0, 0);
            
        } completion:^(BOOL finished) {
            
            self.pickerView.hidden = YES;
            self.btn_cancel.hidden = YES;
            self.btn_ok.hidden = YES;
        }];
    }
}

#pragma mark - 获取所有省份
- (void)p_data
{
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"getAreas:"];
    [dataprovider getAreasWithParent_id:@"0"];
}

//数据
- (void)getAreas:(id )dict
{
    //    NSLog(@"%@",dict);
    
    self.arr_sheng = nil;
    self.arr_shi = nil;
    self.arr_qu = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"arealist"])
            {
                Shengshiqu_Model * model = [[Shengshiqu_Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_sheng addObject:model];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            [self.pickerView reloadAllComponents];
        }
    }
    else
    {
        //        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] ];
    }
    
}

- (void)getAreas1:(id )dict
{
    //    NSLog(@"%@",dict);
    
    self.arr_shi = nil;
    self.arr_qu = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"arealist"])
            {
                Shengshiqu_Model * model = [[Shengshiqu_Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_shi addObject:model];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            [self.pickerView reloadAllComponents];
        }
    }
    else
    {
        //        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] ];
    }
    
}

- (void)getAreas2:(id )dict
{
    //    NSLog(@"%@",dict);
    
    self.arr_qu = nil;
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            for (NSDictionary * dic in dict[@"data"][@"arealist"])
            {
                Shengshiqu_Model * model = [[Shengshiqu_Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.arr_qu addObject:model];
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            [self.pickerView reloadAllComponents];
        }
    }
    else
    {
        //        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] ];
    }
    
}

#pragma mark - 添加收货地址
- (void)create:(id )dict
{
    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"  ];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] ];
    }
}


#pragma mark - 懒加载
- (NSMutableArray *)arr_sheng
{
    if(_arr_sheng == nil)
    {
        self.arr_sheng = [NSMutableArray array];
    }
    
    return _arr_sheng;
}

- (NSMutableArray *)arr_shi
{
    if(_arr_shi == nil)
    {
        self.arr_shi = [NSMutableArray array];
    }
    
    return _arr_shi;
}

- (NSMutableArray *)arr_qu
{
    if(_arr_qu == nil)
    {
        self.arr_qu = [NSMutableArray array];
    }
    
    return _arr_qu;
}



@end

//
//  EditshouhuoViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/26.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "EditshouhuoViewController.h"

#import "AppDelegate.h"
@interface EditshouhuoViewController () <UITextFieldDelegate, UIScrollViewDelegate, UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UITextField * name;
@property (nonatomic, strong) UITextField * tel;
@property (nonatomic, strong) UITextField * address;
@property (nonatomic, strong) UITextField * address_detail;
@property (nonatomic, strong) UIButton * btn_morenAddress;

//
@property (nonatomic, strong) UIPickerView * pickerView;

@property (nonatomic, strong) UIButton * btn_ok;
@property (nonatomic, strong) UIButton * btn_cancel;

//
@property (nonatomic, copy) NSString * text1;
@property (nonatomic, copy) NSString * text2;
@property (nonatomic, copy) NSString * text3;


@end

@implementation EditshouhuoViewController

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
    _lblTitle.text = @"编辑收货地址";
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    [self addRightbuttontitle:@"修改"];
}
//返回
- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//点击修改按钮
- (void)clickRightButton:(UIButton *)sender
{
//    NSLog(@"提示修改成功");
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否保存修改的信息" preferredStyle:(UIAlertControllerStyleAlert)];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
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
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT - 64 + 5);
    
    [self p_setupView1];
    
    [self p_selectAddress];
}

- (void)p_setupView1
{
    UIView * view_white = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view_white.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 30)];
    label1.text = @"收货人";
    label1.textColor = [UIColor grayColor];
    label1.font = [UIFont systemFontOfSize:19];
    [view_white addSubview:label1];
    
    self.name = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(label1.frame) - 20 , 30)];
    self.name.text = self.model.consignee;
    self.name.delegate = self;
    self.name.font = [UIFont systemFontOfSize:19];
//    self.name.backgroundColor = [UIColor orangeColor];
    [view_white addSubview:self.name];
    
    
    UIView * view_white1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_white.frame) + 2, SCREEN_WIDTH, 50)];
    view_white1.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white1];
    
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 30)];
    label2.text = @"手机号码";
    label2.textColor = [UIColor grayColor];
    label2.font = [UIFont systemFontOfSize:19];
    [view_white1 addSubview:label2];
    
    self.tel = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 5, 12, SCREEN_WIDTH - CGRectGetMaxX(label1.frame) - 20 , 30)];
    self.tel.text = self.model.mobile;
    self.tel.font = [UIFont systemFontOfSize:19];
    self.tel.delegate = self;
    [view_white1 addSubview:self.tel];
    
    
    UIView * view_white2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_white1.frame) + 2, SCREEN_WIDTH, 50)];
    view_white2.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white2];
    
    UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 30)];
    label3.text = @"所在地区";
    label3.textColor = [UIColor grayColor];
    label3.font = [UIFont systemFontOfSize:19];
    [view_white2 addSubview:label3];
    
    self.address = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(label1.frame) - 20 , 30)];
    NSString * str = [NSString stringWithFormat:@"%@%@%@",self.model.province,self.model.city,self.model.area];

    self.address.text = str;
    self.address.delegate = self;
    self.address.font = [UIFont systemFontOfSize:19];
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
    
    UILabel * label4 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 30)];
    label4.text = @"详细地址";
//    label4.backgroundColor = [UIColor orangeColor];
    label4.font = [UIFont systemFontOfSize:19];
    label4.textColor = [UIColor grayColor];
    [view_white3 addSubview:label4];
    
    self.address_detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(label1.frame) - 20 , 30)];
    self.address_detail.text = self.model.address;
    self.address_detail.font = [UIFont systemFontOfSize:19];
    self.address_detail.delegate = self;
    [view_white3 addSubview:self.address_detail];
    
    
    
    UIView * view_white4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_white3.frame) + 40, SCREEN_WIDTH, 50)];
    view_white4.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white4];
    
    UILabel * label5 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 150, 30)];
    label5.text = @"删除收货地址";
    label5.textColor = [UIColor redColor];
    label5.font = [UIFont systemFontOfSize:19];
    [view_white4 addSubview:label5];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    //设置点击次数和点击手指数
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [view_white4 addGestureRecognizer:tapGesture];
    
    
    self.btn_morenAddress = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_morenAddress.frame = CGRectMake(15, SCREEN_HEIGHT - 10 - 45 - 64, SCREEN_WIDTH - 30, 45);
    self.btn_morenAddress.backgroundColor = navi_bar_bg_color;
    [self.btn_morenAddress setTitle:@"设为默认地址" forState:(UIControlStateNormal)];
    self.btn_morenAddress.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.btn_morenAddress setTintColor:[UIColor whiteColor]];
    [self.scrollView addSubview:self.btn_morenAddress];
    
    [self.btn_morenAddress addTarget:self action:@selector(btn_morenAddressAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

#pragma mark - 轻击手势触发方法  和设为默认地址
-(void)tapGesture:(id)sender
{
//    NSLog(@"走删除流程， 给提示");
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除该收货地址" preferredStyle:(UIAlertControllerStyleAlert)];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action1];
    [alert addAction:action];
}

//设为默认地址
- (void)btn_morenAddressAction:(UIButton *)sender
{
    DataProvider * dataprovider=[[DataProvider alloc] init];
    [dataprovider setDelegateObject:self setBackFunctionName:@"update:"];
    
    [dataprovider updateWithAddress_id:self.model.address_id is_default:@"1"];
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
            
            self.scrollView.contentOffset = CGPointMake(0, 140);
            
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
}

#pragma mark - 地区选择器
- (void)p_selectAddress
{
    
    self.btn_cancel = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_cancel.frame = CGRectMake(0, CGRectGetMaxY(self.btn_morenAddress.frame) + 15, 80, 30);
    [self.btn_cancel setTitle:@"取消" forState:(UIControlStateNormal)];
    [self.btn_cancel setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.btn_cancel.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.scrollView addSubview:self.btn_cancel];
    self.btn_cancel.hidden = YES;
    
    [self.btn_cancel addTarget:self action:@selector(btn_cancelAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.btn_ok = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_ok.frame = CGRectMake(SCREEN_WIDTH - 80, CGRectGetMaxY(self.btn_morenAddress.frame) + 15, 80, 30);
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
    return 111;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return @"wolaji";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    NSLog(@"%ld  --------   %ld",row,component);
    
    switch (component) {
        case 0:
        {
            NSLog(@"%ld",row);
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
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

    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
        self.pickerView.hidden = YES;
        self.btn_cancel.hidden = YES;
        self.btn_ok.hidden = YES;
    }];
}

#pragma mark - 设为默认收货地址
- (void)update:(id )dict
{
    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"设置成功" maskType:(SVProgressHUDMaskTypeBlack)];
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







@end

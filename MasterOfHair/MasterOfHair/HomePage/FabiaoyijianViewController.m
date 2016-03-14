//
//  FabiaoyijianViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/3/11.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "FabiaoyijianViewController.h"

@interface FabiaoyijianViewController () <UITextViewDelegate>

@property (nonatomic, strong) UITextView * text;

@end

@implementation FabiaoyijianViewController

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
    _lblTitle.text = [NSString stringWithFormat:@"发表意见"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    
    [self addRightbuttontitle:@"保存"];
}

//返回
- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

- (void )clickRightButton:(UIButton *)sender
{
    [self.text resignFirstResponder];
    
    if([self.text.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"发表的意见不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else
    {
        //调接口，
    }
}

#pragma makr - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.text = [[UITextView alloc] initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, 200)];
    self.text.font = [UIFont systemFontOfSize:17];
    self.text.delegate = self;
    [self.view addSubview:self.text];
}

#pragma mark - textView点击
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.text resignFirstResponder];
}





@end

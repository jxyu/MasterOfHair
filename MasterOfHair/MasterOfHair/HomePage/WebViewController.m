//
//  WebViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/3/10.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (nonatomic, strong) UIWebView * webView;

@end

@implementation WebViewController

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
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    
    switch ([self.type integerValue])
    {
        case 1:
        {
            _lblTitle.text = [NSString stringWithFormat:@"会员说明"];
        }
            break;
        case 2:
        {
            _lblTitle.text = [NSString stringWithFormat:@"分销说明"];
        }
            break;
        case 3:
        {
            _lblTitle.text = [NSString stringWithFormat:@"合作开店"];
        }
            break;
        case 4:
        {
            _lblTitle.text = [NSString stringWithFormat:@"支付帮助"];
        }
            break;
        case 5:
        {
            _lblTitle.text = [NSString stringWithFormat:@"慈善基金会说明"];
        }
            break;
        case 6:
        {
            _lblTitle.text = [NSString stringWithFormat:@"联系我们"];
        }
            break;
        default:
            break;
    }
    
    
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

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    NSString * path = [NSString stringWithFormat:@"%@web/viewmenu&id=%@",Url,self.type];
    NSURL * url = [NSURL URLWithString:path];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.view addSubview:self.webView];
}



@end

//
//  AdvertiseClassesViewController.m
//  MasterOfHair
//
//  Created by 于金祥 on 16/2/17.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "AdvertiseClassesViewController.h"

@interface AdvertiseClassesViewController ()
@property (nonatomic,strong)UIScrollView * mainScrollView;

@end

@implementation AdvertiseClassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lblRight.text=@"关闭";
    
    [self.view addSubview:self.mainScrollView];
    
    [self.mainScrollView zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.edgeInsets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    
    UIButton * btn_all=[[UIButton alloc] init];
    [btn_all setTitle:@"全部" forState:UIControlStateNormal];
    [btn_all setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.mainScrollView addSubview:btn_all];
    
    [btn_all zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpace(20);
        layout.topSpace(10);
        layout.heightValue(44);
        layout.rightSpace(20);
    }];
    
//    for (int i=0; i<8; i++) {
//        UIView * lastview=[[self.mainScrollView subviews] lastObject];
//        UIButton * btn_class=[[UIButton alloc] init];
//        [btn_class setTitle:[NSString stringWithFormat:@"分类%d",i] forState:UIControlStateNormal];
//        [btn_class setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self.mainScrollView addSubview:btn_class];
//        
//        [btn_class zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
//            layout.leftSpace(20);
//            layout.topSpaceByView(lastview,10);
//            layout.heightValue(44);
//            layout.rightSpace(20);
//        }];
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

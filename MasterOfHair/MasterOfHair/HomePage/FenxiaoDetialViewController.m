//
//  FenxiaoDetialViewController.m
//  MasterOfHair
//
//  Created by 于金祥 on 16/4/18.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "FenxiaoDetialViewController.h"
#import "DataProvider.h"

@interface FenxiaoDetialViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *mainTableView;
@property (nonatomic,strong)NSArray * mainDataArray;

@end

@implementation FenxiaoDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_navi];
    
    
}



-(void)p_GetDetialData
{
    DataProvider * dataorpvoder=[[DataProvider alloc] init];
    
    [dataorpvoder setDelegateObject:self setBackFunctionName:@"p_GetDetialDataCallBack:"];
    
    [dataorpvoder GetyongjinDetialWithmember_id:self.member_id];
}

-(void)p_GetDetialDataCallBack:(id)dict
{
    DLog(@"%@",dict);
}

#pragma mark - navi
- (void)p_navi
{
    _lblTitle.text = [NSString stringWithFormat:@"佣金详情"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    [self addLeftButton:@"iconfont-fanhui"];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainDataArray.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)mainTableView
{
    if (self.mainTableView==nil) {
        self.mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    }
    return self.mainTableView;
}



@end

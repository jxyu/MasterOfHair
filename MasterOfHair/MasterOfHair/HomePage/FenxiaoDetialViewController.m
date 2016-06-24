//
//  FenxiaoDetialViewController.m
//  MasterOfHair
//
//  Created by 于金祥 on 16/4/18.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "FenxiaoDetialViewController.h"
#import "DataProvider.h"
#import "FenxiaoDetialTableViewCell.h"

@interface FenxiaoDetialViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *mainTableView;
@property (nonatomic,strong)NSArray * mainDataArray;

@end

@implementation FenxiaoDetialViewController
{
    int pagenumber;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pagenumber=1;
    
    [self p_navi];
    
    [self p_GetDetialData];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    
    
    self.mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.mainTableView.delegate=self;
    self.mainTableView.dataSource=self;
    
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf p_GetDetialData];
        
        
    }];
    
    self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        
    }];
    
}



-(void)p_GetDetialData
{
    DataProvider * dataorpvoder=[[DataProvider alloc] init];
    
    [dataorpvoder setDelegateObject:self setBackFunctionName:@"p_GetDetialDataCallBack:"];
    
    [dataorpvoder GetyongjinDetialWithmember_id:self.member_id andorder_status:self.Order_stute andmember_level:self.member_level andpagenumber:@"1" andpagesize:@"10"];
}

-(void)p_GetDetialDataCallBack:(id)dict
{
    DLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue]==1) {
        
        self.mainDataArray=[[NSArray alloc] initWithArray:dict[@"data"][@"orderlist"]];
        
        [self.mainTableView reloadData];
    }
    else
    {
        
    }
}

-(void)LoadMoreData
{
    ++pagenumber;
    DataProvider * dataorpvoder=[[DataProvider alloc] init];
    
    [dataorpvoder setDelegateObject:self setBackFunctionName:@"p_GetDetialDataCallBack:"];
    
    [dataorpvoder GetyongjinDetialWithmember_id:self.member_id andorder_status:self.Order_stute andmember_level:self.member_level andpagenumber:[NSString stringWithFormat:@"%d",pagenumber] andpagesize:@"10"];
}
-(void)LoadMoreDataCallBack:(id)dict
{
    if ([dict[@"status"][@"succeed"] intValue]==1) {
        
        NSMutableArray * itemMutablearray=[[NSMutableArray alloc] initWithArray:self.mainDataArray];
        
        NSArray * itemarray=[[NSArray alloc] initWithArray:dict[@"data"][@"orderlist"]];
        for (id item in itemarray) {
            [itemMutablearray addObject:item];
        }
        self.mainDataArray=[[NSArray alloc] initWithArray:itemMutablearray];
        
        [self.mainTableView reloadData];
        
    }
    else
    {
        --pagenumber;
    }
}

#pragma mark - navi
- (void)p_navi
{
    _lblTitle.text = [NSString stringWithFormat:@"佣金详情"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    [self addLeftButton:@"iconfont-fanhui"];
    _lblLeft.text=@"返回";
    _lblLeft.textAlignment=NSTextAlignmentLeft;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainDataArray.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"佣金变动详情";
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor grayColor]];
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FenxiaoDetialTableViewCell *displayCell = (FenxiaoDetialTableViewCell*)cell;
    
    NSDictionary * dict=self.mainDataArray[indexPath.row];
    displayCell.lbl_date.text=[dict[@"orders_time"] isEqual:[NSNull null]]?@"":[NSString stringWithFormat:@"  %@",dict[@"orders_time"]];
    
    displayCell.lbl_price.text=[dict[@"order_brokerage"] isEqual:[NSNull null]]?@"":[NSString stringWithFormat:@"￥%@",dict[@"order_brokerage"]];
    
    int status=[self.Order_stute intValue];
    
    switch (status) {
        case 1:
            displayCell.lbl_stute.text=@"未付款";
            break;
        case 2:
            displayCell.lbl_stute.text=@"已付款";
            break;
        case 4:
            displayCell.lbl_stute.text=@"已完成";
            break;
            
        default:
            break;
    }
    
    displayCell.lbl_title.text=[dict[@"order_number"] isEqual:[NSNull null]]?@"":[NSString stringWithFormat:@"  %@",dict[@"order_number"]];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"fenxiaoDetialTableViewCellIdentifier";
    FenxiaoDetialTableViewCell *itemcell = (FenxiaoDetialTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    itemcell  = [[[NSBundle mainBundle] loadNibNamed:@"FenxiaoDetialTableViewCell" owner:self options:nil] lastObject];
    itemcell.layer.masksToBounds=YES;
    itemcell.frame=CGRectMake(itemcell.frame.origin.x, itemcell.frame.origin.y, tableView.frame.size.width, itemcell.frame.size.height);
    
    
    
    
    
    return itemcell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

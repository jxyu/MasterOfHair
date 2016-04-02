//
//  shangchengdingdanDetailViewController.h
//  MasterOfHair
//
//  Created by 鞠超 on 16/4/2.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "BaseNavigationController.h"

#import "DINGDAN_Model.h"

@interface shangchengdingdanDetailViewController : BaseNavigationController

@property (nonatomic, strong) DINGDAN_Model * model_all;

@property (nonatomic, strong) NSMutableArray * arr_list;

@end

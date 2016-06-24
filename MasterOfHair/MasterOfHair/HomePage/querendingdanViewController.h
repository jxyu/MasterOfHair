//
//  querendingdanViewController.h
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/26.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "BaseNavigationController.h"

#import "chanpinDetail_Models.h"
#import "Chanpingxiangqing_Models.h"

@interface querendingdanViewController : BaseNavigationController

@property (nonatomic, strong) chanpinDetail_Models * chanpinDetail;

@property (nonatomic, strong) Chanpingxiangqing_Models * Chanpingxiangqing;

@property (nonatomic) NSInteger good_Num;

@end

//
//  NextTextViewController.h
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/2.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "BaseNavigationController.h"
#import "Pinglun_Models.h"
@interface NextTextViewController : BaseNavigationController

@property (nonatomic, copy) NSString * article_id;

@property (nonatomic, assign) float length;

@property (nonatomic, strong) Pinglun_Models * model;

@end

//
//  NextVideoViewController.h
//  MasterOfHair
//
//  Created by 鞠超 on 16/3/7.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "BaseNavigationController.h"
#import "Pinglun_Models.h"
@interface NextVideoViewController : BaseNavigationController

@property (nonatomic, copy) NSString * discuss_id;

@property (nonatomic, assign) float length;

@property (nonatomic, strong) Pinglun_Models * model_pinglu;

@end

//
//  ZhifuViewController.h
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/29.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "BaseNavigationController.h"

@interface ZhifuViewController : BaseNavigationController

@property (nonatomic, strong) UILabel * name;

@property (nonatomic, strong) UILabel * price;

@property (nonatomic, copy) NSString * course_id;

@property (nonatomic, copy) NSString * name_course;
@property (nonatomic, copy) NSString * money;



@end

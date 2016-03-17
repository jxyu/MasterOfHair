//
//  Wenxiulanmengdingdan_Model.h
//  MasterOfHair
//
//  Created by 鞠超 on 16/3/17.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Wenxiulanmengdingdan_Model : NSObject

@property (nonatomic, copy) NSString * member_id;
@property (nonatomic, copy) NSString * order_code;
@property (nonatomic, copy) NSString * order_id;
@property (nonatomic, copy) NSString * order_payable;
@property (nonatomic, copy) NSString * order_realpay;
@property (nonatomic, copy) NSString * order_time;

@property (nonatomic, copy) NSString * pay_method;
@property (nonatomic, copy) NSString * product_id;
@property (nonatomic, copy) NSString * product_name;
@property (nonatomic, copy) NSString * store_id;
@property (nonatomic, copy) NSString * store_name;


@property (nonatomic, copy) NSString * technician_id;
@property (nonatomic, copy) NSString * technician_name;
@property (nonatomic, copy) NSString * union_order_status;

@end

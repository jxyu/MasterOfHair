//
//  Store_Model.h
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/28.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store_Model : NSObject

@property (nonatomic, copy) NSString * store_name;

@property (nonatomic, copy) NSString * stroe_ID;

@property (nonatomic, strong) NSMutableArray * arr_goods;


@end

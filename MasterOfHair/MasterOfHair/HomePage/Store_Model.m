
//
//  Store_Model.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/28.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "Store_Model.h"

@implementation Store_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSMutableArray *)arr_goods
{
    if(_arr_goods == nil)
    {
        self.arr_goods = [NSMutableArray array];
    }
    return _arr_goods;
}



@end

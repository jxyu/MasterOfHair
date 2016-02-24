//
//  Single_Model.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/28.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "Single_Model.h"

@implementation Single_Model

+ (instancetype )singel
{
    static Single_Model * single = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        single = [[Single_Model alloc] init];
        
    });
    return single;
}




@end

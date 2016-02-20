//
//  DataProvider.h
//  BuerShopping
//
//  Created by 于金祥 on 15/5/30.
//  Copyright (c) 2015年 zykj.BuerShopping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataProvider : NSObject
{
    id CallBackObject;
    NSString * callBackFunctionName;
}

/**
 *  设置回调函数
 *
 *  @param cbobject     回调对象
 *  @param selectorName 回调函数
 */
- (void)setDelegateObject:(id)cbobject setBackFunctionName:(NSString *)selectorName;


#pragma mark - 注册
- (void)registerWithMember_username:(NSString *)member_username member_password:(NSString *)member_password spread_id:(NSString *)spread_id;

#pragma mark - 登陆
- (void)loginWithMember_username:(NSString *)member_username member_password:(NSString *)member_password;

#pragma mark - 重置密码
- (void)resetPasswordWithMember_username:(NSString *)member_username member_password:(NSString *)member_password;

#pragma mark - 商城产品接口
- (void)productWithcity_id:(NSString *)city_id category_id:(NSString *)category_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark - 所有区域
- (void)area;

#pragma mark - 商城详情页
- (void)getProductsWithProduction_id:(NSString *)production_id;
















@end

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
- (void)productWithcity_id:(NSString *)city_id category_id:(NSString *)category_id is_maker:(NSString *)is_maker is_sell:(NSString *)is_sell pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark - 所有区域
- (void)area;

#pragma mark - 商城详情页
- (void)getProductsWithProduction_id:(NSString *)production_id;

#pragma mark - 获取某会员的所有收货地址
- (void)getAddressesWithMember_id:(NSString *)member_id;

#pragma mark - 获取某会员的默认收货地址（购买的时候用）
- (void)getAddressesWithMember_id:(NSString *)member_id is_default:(NSString *)is_default;

#pragma mark - 设为默认收货地址
- (void)updateWithAddress_id:(NSString *)address_id is_default:(NSString *)is_default;

#pragma mark - 获取所有省份
- (void)getAreasWithParent_id:(NSString *)parent_id;

#pragma mark - 删除收货地址
- (void)deleteWithAddress_id:(NSString *)address_id;

#pragma mark - 修改收货地址
- (void)updateWithAddress_id:(NSString *)address_id consignee:(NSString *)consignee mobile:(NSString *)mobile province:(NSString *)province city:(NSString *)city area:(NSString *)area address:(NSString *)address;

#pragma mark - 添加收货地址
- (void)createWithMember_id:(NSString *)member_id consignee:(NSString *)consignee mobile:(NSString *)mobile province:(NSString *)province city:(NSString *)city area:(NSString *)area address:(NSString *)address;

#pragma mark - 轮播图接口
- (void)getSlidesWithSlide_type:(NSString *)slide_type;


#pragma mark - 获取所有产品分类
- (void)getCategories;

#pragma mark - 获取某产品分类的子类
- (void)getCategoriesWithCategory_parent_id:(NSString *)category_parent_id;

#pragma mark - 加入购物车
- (void)createWithProduction_id:(NSString *)production_id number:(NSString *)number price:(NSString *)price member_id:(NSString *)member_id specs_id:(NSString *)specs_id;

#pragma mark - 获取购物车列表界面
- (void)shopcartWithMember_id:(NSString *)member_id;

#pragma mark - 设为默认收货地址
- (void)getProductListWithProduction_keyword:(NSString *)production_keyword is_maker:(NSString *)is_maker is_sell:(NSString *)is_sell;

#pragma mark - 获取某分类的图文列表并分页
- (void)getArticleListWithChannel_id:(NSString *)channel_id status_code:(NSString *)status_code pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark - 获取某分类的视频列表并分页
- (void)getArticleListWithVideo_type:(NSString *)video_type is_free:(NSString *)is_free pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark - 获取所有产品分类
- (void)getChannels;

#pragma mark - 视频关键词搜索
- (void)getVideoListWithVideo_keyword:(NSString *)video_keyword pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark - 图文关键词搜索
- (void)getArticleListWithArticle_keyword:(NSString *)article_keyword pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark - 获取某视频详情
- (void)getVideosWithVideo_id:(NSString *)video_id;

#pragma mark - 获取某个视频的一级评论列表并分页
- (void)getDiscussListWithVideo_id:(NSString *)video_id reply_id:(NSString *)reply_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark - 获取产品热门列表
- (void)getRecommendProductsWithCity_id:(NSString *)city_id is_sell:(NSString *)is_sell;

#pragma mark - 编辑购物车(修改数量)
- (void)createWithProduction_id:(NSString *)production_id number:(NSString *)number  member_id:(NSString *)member_id specs_id:(NSString *)specs_id;

#pragma mark - 获取某视频详情
- (void)deleteWithShopcart_id:(NSString *)shopcart_id;

#pragma mark - 添加一个订单(POST提交)
- (void)createWithMember_id:(NSString *)member_id shop_id:(NSString *)shop_id shipping_method:(NSString *)shipping_method pay_method:(NSString *)pay_method pay_status:(NSString *)pay_status leave_word:(NSString *)leave_word production_info:(NSMutableArray *)production_info;


#pragma mark - 获取产品热门列表
- (void)createWithMember_id:(NSString *)member_id production_id:(NSString *)production_id;

#pragma mark - 判断产品是否被收藏
- (void)isFavoriteWithMember_id:(NSString *)member_id production_id:(NSString *)production_id;

#pragma mark - 获取随机热门视频
- (void)GetRecommendVideoList;

#pragma mark - 确认订单(购物车点结算)
- (void)getConfirmOrderWithShopcart_id:(NSString *)shopcart_id;

#pragma mark - 获取热门随机图文
- (void)getRecommendArticleList;














@end

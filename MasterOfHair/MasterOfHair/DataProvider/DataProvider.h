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
- (void)createWithMember_id:(NSString *)member_id shop_id:(NSString *)shop_id shipping_method:(NSString *)shipping_method pay_method:(NSString *)pay_method address_id:(NSString *)address_id pay_status:(NSString *)pay_status leave_word:(NSString *)leave_word production_info:(NSMutableArray *)production_info;

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

#pragma mark - 会员资料修改
- (void)updateWithMember_id:(NSString *)member_id member_nickname:(NSString *)member_nickname;

#pragma mark - 会员头像修改
- (void)UploadHeadPicWithMember_id:(NSString *)member_id member_headpic:(NSData *)member_headpic;

#pragma mark - 加入收藏/取消收藏
- (void)createWithMember_id:(NSString *)member_id article_id:(NSString *)article_id;

#pragma mark - 判断图文是否被收藏
- (void)isFavoriteWithMember_id:(NSString *)member_id article_id:(NSString *)article_id;

#pragma mark - 加入收藏/取消收藏
- (void)createWithMember_id:(NSString *)member_id video_id:(NSString *)video_id;

#pragma mark - 判断视频是否被收藏
- (void)isFavoriteWithMember_id:(NSString *)member_id video_id:(NSString *)video_id;

#pragma mark - 获取某会员的收藏列表并分页
- (void)getProductionFavoriteListWithMember_id:(NSString *)member_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark - 删除收藏（支持群删除）
- (void)ProductionFavoriteWithFavorite_id:(NSString *)favorite_id;


#pragma mark - 获取某会员的收藏列表并分页
- (void)getVideoFavoriteListWithMember_id:(NSString *)member_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark - 删除收藏（支持群删除）
- (void)VideoFavoriteWithFavorite_id:(NSString *)favorite_id;

#pragma mark - 添加视频评论
- (void)createWithMember_id:(NSString *)member_id discuss_content:(NSString *)discuss_content video_id:(NSString *)video_id reply_id:(NSString *)reply_id;

#pragma mark - 获取某条视频评论的回复列表并分页
- (void)getReplyListWithDiscuss_id:(NSString *)discuss_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark - 获取某图文详情
- (void)getArticlesWithArticle_id:(NSString *)article_id;

#pragma mark - 获取某条图文的一级评论列表并分页
- (void)getCommentListWithArticle_id:(NSString *)article_id reply_id:(NSString *)reply_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark - 添加图文评论）
- (void)createWithArticle_id:(NSString *)article_id reply_id:(NSString *)reply_id member_id:(NSString *)member_id comment_content:(NSString *)comment_content;

#pragma mark - 获取某条图文评论的回复列表并分页
- (void)getReplyListWithComment_id:(NSString *)comment_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark - 加入收藏/取消收藏
- (void)ArticleFavoriteWithMember_id:(NSString *)member_id article_id:(NSString *)article_id;

#pragma mark - 获取某会员的收藏列表并分页
- (void)getArticleFavoriteListWithMember_id:(NSString *)member_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark - 删除收藏（支持群删除）
- (void)deletetuwenWithFavorite_id:(NSString *)favorite_id;

#pragma mark - 获取某会员的收藏列表并分页
- (void)getCityWithLng:(NSString *)lng lat:(NSString *)lat;



#pragma mark -  获取单个课程详情
- (void)CourseWithCourse_id:(NSString *)course_id;


#pragma mark -  获取单个课程详情的web页
- (void)CourseIntroWithCourse_id:(NSString *)course_id;

#pragma mark -  获取某用户的所有订单
- (void)getOrdersWithMember_id:(NSString *)member_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark -  获取某用户的所有“未付款”订单并分页
- (void)getOrdersWithMember_id:(NSString *)member_id order_status:(NSString *)order_status pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark -  发表意见接口
- (void)createWithMember_id:(NSString *)member_id suggest_content:(NSString *)suggest_content;

#pragma mark -  获取个人是否申请成功
- (void)ApplyagentWithMember_id:(NSString *)member_id;

#pragma mark -  申请代理商(post)
- (void)createWithMember_id:(NSString *)member_id applyAgent_name:(NSString *)applyAgent_name applyAgent_phone:(NSString *)applyAgent_phone idcard_frond:(NSData *)idcard_frond idcard_side:(NSData *)idcard_side framework_image:(NSData *)framework_image business_image:(NSData *)business_image;

#pragma mark - 会员密码修改
- (void)createWithMember_username:(NSString *)member_username member_password:(NSString *)member_password member_new_password:(NSString *)member_new_password;

#pragma mark -  获取某会员"钱包"流水记录
- (void)createWithMember_id:(NSString *)member_id record_type:(NSString *)record_type pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark -  获取会员详细信息
- (void)GetMembersWithMember_id:(NSString *)member_id;

#pragma mark - 申请提现
- (void)createWithMember_id:(NSString *)member_id record_type:(NSString *)record_type  change_type:(NSString *)change_type alipay_account:(NSString *)alipay_account change_amount:(NSString *)change_amount;

#pragma mark -  获取统计数据
- (void)StatisticalDataWithMember_id:(NSString *)member_id;

#pragma mark -  获取一级会员列表并分页
- (void)GetFirstLevelMembersWithMember_id:(NSString *)member_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark -  获取二级会员列表并分页
- (void)GetSecondLevelMembersWithMember_id:(NSString *)member_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;


#pragma mark -  取消订单
- (void)updateWithOrders_id:(NSString *)orders_id order_status:(NSString *)order_status;

#pragma mark -  删除订单
- (void)deleteWithOrders_id:(NSString *)orders_id;


#pragma mark - 获取名师名店列表（不进行分页）：
- (void)FamousTeacherpagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;


#pragma mark - 获取名师详细信息（不进行分页）：
- (void)FamousTeacherWithTeacher_id:(NSString *)teacher_id;

#pragma mark - 获取合作店列表（根据城市）
- (void)CooperateStoreWithTeacher_id:(NSString *)city_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark - 获取高级技师列表
- (void)SeniorTechnicianWithcity_id:(NSString *)city_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;


#pragma mark - 获取高级技师详情
- (void)SeniorTechnicianWithTechnician_id:(NSString *)technician_id;

#pragma mark - 获取合作店下产品列表
- (void)GetStoreProductsWithStore_id:(NSString *)store_id;

#pragma mark - (3)添加一个订单
- (void)createWithStore_id:(NSString *)store_id member_id:(NSString *)member_id product_id:(NSString *)product_id technician_id:(NSString *)technician_id order_payable:(NSString *)order_payable order_realpay:(NSString *)order_realpay union_order_status:(NSString *)union_order_status pay_method:(NSString *)pay_method;


#pragma mark - (2)获取某用户的所有订单并分页
- (void)GetOrdersWithmember_id:(NSString *)member_id union_order_status:(NSString *)union_order_status pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark - 删除多个或一个订单
- (void)deleteWithStore_id:(NSString *)order_id;

#pragma mark - 商盟产品接口
- (void)productWithcategory_id:(NSString *)category_id is_maker:(NSString *)is_maker is_sell:(NSString *)is_sell pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;


//#pragma mark - 添加一个订单(POST提交)(new)
//- (void)createWithMember_id:(NSString *)member_id pay_method:(NSString *)pay_method  pay_status:(NSString *)pay_status orderlist:(NSMutableArray *)orderlist;

#pragma mark -  说说
- (void)createWithMember_id:(NSString *)member_id talk_content:(NSString *)talk_content;

#pragma mark -  说说1(图片)
- (void)createWithMember_id:(NSString *)member_id talk_content:(NSString *)talk_content file_type:(NSString *)file_type file_path1:(NSData *)file_path1 file_path2:(NSData *)file_path2 file_path3:(NSData *)file_path3 file_path4:(NSData *)file_path4 file_path5:(NSData *)file_path5 file_path6:(NSData *)file_path6;

#pragma mark -  说说1(图片)
- (void)createWithMember_id:(NSString *)member_id talk_content:(NSString *)talk_content file_type:(NSString *)file_type arr:(NSMutableArray *)arr;

#pragma mark -  说说1(视频)
- (void)createWithMember_id:(NSString *)member_id talk_content:(NSString *)talk_content file_type:(NSString *)file_type Path:(NSURL *)videoPath;


#pragma mark -  说说分页列表
- (void)talkAllWithmember_id:(NSString *)member_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark -  说说点赞
- (void)TakeGoodWithMember_id:(NSString *)member_id talk_id:(NSString *)talk_id;


#pragma mark -  获取单条说说详情
- (void)TakeGoodWithTalk_id:(NSString *)talk_id member_id:(NSString *)member_id;

#pragma mark -  说说留言
- (void)TakeGoodWithTalk_id:(NSString *)talk_id member_id:(NSString *)member_id reply_content:(NSString *)reply_content reply_status:(NSString *)reply_status;

#pragma mark -  说说分页列表（某一用户）
- (void)talkWithmember_id:(NSString *)member_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark -  说说删除
- (void)talkWithtalk_id:(NSString *)talk_id;

#pragma mark -  获取某城市的招聘信息列表
- (void)talkWithArea_id:(NSString *)area_id salary_id:(NSString *)salary_id type_id:(NSString *)type_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;

#pragma mark -  获取某城市的应聘信息列表：
- (void)VitaeWithArea_id:(NSString *)area_id salary_id:(NSString *)salary_id type_id:(NSString *)type_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize;


#pragma mark -  6）招聘类别
- (void)RecruitType;


#pragma mark -  7）招聘薪资区间
- (void)RecruitSalary;

#pragma mark - 获取单个应聘详情
- (void)talkWithvitae_id:(NSString *)vitae_id;

#pragma mark -  获取单个招聘详情
- (void)talkWithrecruit_id:(NSString *)recruit_id;

#pragma mark - 发布简历（post提交）
- (void)createWithimage:(NSData *)image member_id:(NSString *)member_id name:(NSString *)name age:(NSString *)age sex:(NSString *)sex domicile:(NSString *)domicile work_experience:(NSString *)work_experience telephone:(NSString *)telephone intention_position:(NSString *)intention_position salary_id:(NSString *)salary_id type_id:(NSString *)type_id locationid:(NSString *)locationid area_id:(NSString *)area_id;

#pragma mark -  发布招聘（post提交）
- (void)createWithimage:(NSData *)image number:(NSString *)number workname:(NSString *)workname salary_id:(NSString *)salary_id type_id:(NSString *)type_id area_id:(NSString *)area_id location:(NSString *)location job_description:(NSString *)job_description company_name:(NSString *)company_name company_locat:(NSString *)company_locat company_scale:(NSString *)company_scale company_brief:(NSString *)company_brief company_natrue:(NSString *)company_natrue company_industry:(NSString *)company_industry telephone:(NSString *)telephone;


#pragma mark -  充值
- (void)createWithMember_id:(NSString *)member_id pay_total:(NSString *)pay_total pay_method:(NSString *)pay_method;


#pragma mark -  订单支付接口
- (void)createWithMember_id:(NSString *)member_id orders_id:(NSString *)orders_id pay_method:(NSString *)pay_method orders_total:(NSString * )orders_total;


#pragma mark -  升级金卡会员支付接口
- (void)upgradeRecordWithMember_id:(NSString *)member_id pay_total:(NSString *)pay_total pay_method:(NSString * )pay_method;

#pragma mark -  	（3）会员报名
- (void)SignupWithMember_id:(NSString *)member_id course_id:(NSString *)course_id pay_method:(NSString * )pay_method;

#pragma mark - 获取课程列表
- (void)CourseWithPagenumber:(NSString *)pagenumber status:(NSString *)status;


#pragma mark -  视频支付接口
- (void)SignupWithMember_id:(NSString *)member_id video_id:(NSString *)video_id pay_total:(NSString * )pay_total pay_method:(NSString *)pay_method;

#pragma mark -  首页签到接口
- (void)CreateAutoLoginUrlWithMember_id:(NSString *)member_username;

#pragma mark -  判断课程是否报名
- (void)ifsignupWithCourse_id:(NSString *)course_id member_id:(NSString *)member_id;

#pragma mark - 获取某会员的收货地址
- (void)getAddressesWithaddress_id:(NSString *)address_id;










@end

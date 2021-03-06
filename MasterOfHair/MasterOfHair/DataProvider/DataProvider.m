//
//  DataProvider.m
//  BuerShopping
//
//  Created by 于金祥 on 15/5/30.
//  Copyright (c) 2015年 zykj.BuerShopping. All rights reserved.
//

#import "DataProvider.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFURLRequestSerialization.h"
#import "SVProgressHUD.h"
//#import "HttpRequest.h"

//#define Url @"http://115.28.67.86:8033/"
//#define Url @"http://hihome.zhongyangjituan.com/



@implementation DataProvider

#pragma mark - 注册
- (void)registerWithMember_username:(NSString *)member_username member_password:(NSString *)member_password spread_id:(NSString *)spread_id
{
    if(member_username && member_password)
    {
        NSString * url=[NSString stringWithFormat:@"%@site/register",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_username\":\"%@\",\"member_password\":\"%@\",\"spread_id\":\"%@\"}",member_username,member_password,spread_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 登陆
- (void)loginWithMember_username:(NSString *)member_username member_password:(NSString *)member_password
{
    if(member_username && member_password)
    {
        NSString * url=[NSString stringWithFormat:@"%@site/login",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_username\":\"%@\",\"member_password\":\"%@\"}",member_username,member_password]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 重置密码
- (void)resetPasswordWithMember_username:(NSString *)member_username member_password:(NSString *)member_password
{
    if(member_username && member_password)
    {
        NSString * url=[NSString stringWithFormat:@"%@site/resetPassword",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_username\":\"%@\",\"member_password\":\"%@\"}",member_username,member_password]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 商城产品接口
- (void)productWithcity_id:(NSString *)city_id category_id:(NSString *)category_id is_maker:(NSString *)is_maker is_sell:(NSString *)is_sell pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(city_id && category_id && pagenumber && pagesize && is_maker && is_sell)
    {
        NSString * url=[NSString stringWithFormat:@"%@product/getProductList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"city_id\":\"%@\",\"category_id\":\"%@\",\"is_maker\":\"%@\",\"is_sell\":\"%@\"}",city_id,category_id,is_maker,is_sell],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 所有区域
- (void)area
{
    NSString * url = [NSString stringWithFormat:@"%@area/getCities",Url];
    
    [self PostRequest:url andpram:nil];
}

#pragma mark - 商城详情页
- (void)getProductsWithProduction_id:(NSString *)production_id
{
    if(production_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@product/getProducts",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"production_id\":\"%@\"}",production_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取某会员的所有收货地址
- (void)getAddressesWithMember_id:(NSString *)member_id
{
    if(member_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@address/getAddresses",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\"}",member_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取某会员的默认收货地址
- (void)getAddressesWithMember_id:(NSString *)member_id is_default:(NSString *)is_default
{
    if(member_id && is_default)
    {
        NSString * url=[NSString stringWithFormat:@"%@address/getAddresses",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"is_default\":\"%@\"}",member_id,is_default]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 设为默认收货地址
- (void)updateWithAddress_id:(NSString *)address_id is_default:(NSString *)is_default
{
    if(address_id && is_default)
    {
        NSString * url=[NSString stringWithFormat:@"%@address/update",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"address_id\":\"%@\",\"is_default\":\"%@\"}",address_id,is_default]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取所有省份
- (void)getAreasWithParent_id:(NSString *)parent_id
{
    if(parent_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@area/getAreas",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"parent_id\":\"%@\"}",parent_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 删除收货地址
- (void)deleteWithAddress_id:(NSString *)address_id
{
    if(address_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@address/delete",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"address_id\":\"%@\"}",address_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 修改收货地址
- (void)updateWithAddress_id:(NSString *)address_id consignee:(NSString *)consignee mobile:(NSString *)mobile province:(NSString *)province city:(NSString *)city area:(NSString *)area address:(NSString *)address
{
    if(address_id && consignee && mobile && province && city && area && address)
    {
        NSString * url=[NSString stringWithFormat:@"%@address/update",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"address_id\":\"%@\",\"consignee\":\"%@\",\"mobile\":\"%@\",\"province\":\"%@\",\"city\":\"%@\",\"area\":\"%@\",\"address\":\"%@\"}",address_id,consignee,mobile,province,city,area,address]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 添加收货地址
- (void)createWithMember_id:(NSString *)member_id consignee:(NSString *)consignee mobile:(NSString *)mobile province:(NSString *)province city:(NSString *)city area:(NSString *)area address:(NSString *)address
{
    if(member_id && consignee && mobile && province && city && area && address)
    {
        NSString * url=[NSString stringWithFormat:@"%@address/create",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"consignee\":\"%@\",\"mobile\":\"%@\",\"province\":\"%@\",\"city\":\"%@\",\"area\":\"%@\",\"address\":\"%@\"}",member_id,consignee,mobile,province,city,area,address]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 轮播图接口
- (void)getSlidesWithSlide_type:(NSString *)slide_type
{
    if(slide_type)
    {
        NSString * url=[NSString stringWithFormat:@"%@slide/getSlides",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"slide_type\":\"%@\"}",slide_type]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取所有产品分类
- (void)getCategories
{
    NSString * url=[NSString stringWithFormat:@"%@category/getCategories",Url];
    
    [self PostRequest:url andpram:nil];
}

#pragma mark - 获取某产品分类的子类
- (void)getCategoriesWithCategory_parent_id:(NSString *)category_parent_id
{
    if(category_parent_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@category/getCategories",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"category_parent_id\":\"%@\"}",category_parent_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 加入购物车
- (void)createWithProduction_id:(NSString *)production_id number:(NSString *)number price:(NSString *)price member_id:(NSString *)member_id specs_id:(NSString *)specs_id
{
    if(production_id && number && price && member_id && specs_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@shopcart/create",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"production_id\":\"%@\",\"number\":\"%@\",\"price\":\"%@\",\"member_id\":\"%@\",\"specs_id\":\"%@\"}",production_id,number,price,member_id,specs_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取购物车列表界面
- (void)shopcartWithMember_id:(NSString *)member_id
{
    if(member_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@shopcart/shopcart",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\"}",member_id]};
        
        [self PostRequest:url andpram:prm];
    }
    
}

#pragma mark - 设为默认收货地址
- (void)getProductListWithProduction_keyword:(NSString *)production_keyword is_maker:(NSString *)is_maker is_sell:(NSString *)is_sell
{
    if(production_keyword && is_maker && is_sell)
    {
        NSString * url=[NSString stringWithFormat:@"%@product/getProductList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"production_name\":\"%@\",\"is_maker\":\"%@\",\"is_sell\":\"%@\"}",production_keyword,is_maker,is_sell]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取某分类的图文列表并分页
- (void)getArticleListWithChannel_id:(NSString *)channel_id status_code:(NSString *)status_code pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(channel_id && status_code && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@article/getArticleList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"channel_id\":\"%@\",\"status_code\":\"%@\"}",channel_id,status_code],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取某分类的视频列表并分页
- (void)getArticleListWithVideo_type:(NSString *)video_type is_free:(NSString *)is_free pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(video_type && is_free && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@video/getVideoList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"video_type\":\"%@\",\"is_free\":\"%@\"}",video_type,is_free],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取所有产品分类
- (void)getChannels
{
    NSString * url=[NSString stringWithFormat:@"%@channel/getChannels",Url];
    
    [self PostRequest:url andpram:nil];
}


#pragma mark - 视频关键词搜索
- (void)getVideoListWithVideo_keyword:(NSString *)video_keyword pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(video_keyword && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@video/getVideoList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"video_title\":\"%@\"}",video_keyword],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 图文关键词搜索
- (void)getArticleListWithArticle_keyword:(NSString *)article_keyword pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(article_keyword && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@article/getArticleList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"article_title\":\"%@\"}",article_keyword],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取某视频详情
- (void)getVideosWithVideo_id:(NSString *)video_id
{
    if(video_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@video/getVideos",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"video_id\":\"%@\"}",video_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取某个视频的一级评论列表并分页
- (void)getDiscussListWithVideo_id:(NSString *)video_id reply_id:(NSString *)reply_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(video_id && reply_id && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@discuss/getDiscussList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"video_id\":\"%@\",\"reply_id\":\"%@\"}",video_id,reply_id],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取产品热门列表
- (void)getRecommendProductsWithCity_id:(NSString *)city_id is_sell:(NSString *)is_sell
{
    if(city_id && is_sell)
    {
        NSString * url=[NSString stringWithFormat:@"%@product/getRecommendProducts",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"city_id\":\"%@\",\"is_sell\":\"%@\",\"is_maker\":\"0\"}",city_id,is_sell]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 编辑购物车(修改数量)
- (void)createWithProduction_id:(NSString *)production_id number:(NSString *)number  member_id:(NSString *)member_id specs_id:(NSString *)specs_id
{
    if(production_id && number && member_id && specs_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@shopcart/create",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"production_id\":\"%@\",\"number\":\"%@\",\"member_id\":\"%@\",\"specs_id\":\"%@\"}",production_id,number,member_id,specs_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取某视频详情
- (void)deleteWithShopcart_id:(NSString *)shopcart_id
{
    if(shopcart_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@shopcart/delete",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"shopcart_id\":\"%@\"}",shopcart_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 添加一个订单(POST提交)
- (void)createWithMember_id:(NSString *)member_id shop_id:(NSString *)shop_id shipping_method:(NSString *)shipping_method pay_method:(NSString *)pay_method address_id:(NSString *)address_id pay_status:(NSString *)pay_status leave_word:(NSString *)leave_word production_info:(NSMutableArray *)production_info andwallet_password:(NSString *)wallet_password
{
    if(member_id && shop_id && shipping_method && pay_method && pay_status && leave_word && production_info && address_id &&wallet_password)
    {
        NSString * url=[NSString stringWithFormat:@"%@order/createOrder",Url];
        
        NSString *jsonString = [[NSString alloc] initWithData:[self toJSONData:production_info] encoding:NSUTF8StringEncoding];
        
         NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"shop_id\":\"%@\",\"shipping_method\":\"%@\",\"pay_method\":\"%@\",\"pay_status\":\"%@\",\"leave_word\":\"%@\",\"address_id\":\"%@\",\"production_info\":%@,\"wallet_password\":\"%@\"}",member_id,shop_id,shipping_method,pay_method,pay_status,leave_word,address_id,jsonString,wallet_password]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 加入收藏/取消收藏
- (void)createWithMember_id:(NSString *)member_id production_id:(NSString *)production_id
{
    if(member_id && production_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@ProductionFavorite/create",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"production_id\":\"%@\"}",member_id,production_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 判断产品是否被收藏
- (void)isFavoriteWithMember_id:(NSString *)member_id production_id:(NSString *)production_id
{
    if(member_id && production_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@ProductionFavorite/isFavorite",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"production_id\":\"%@\"}",member_id,production_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取随机热门视频
- (void)GetRecommendVideoList
{
    NSString * url=[NSString stringWithFormat:@"%@video/GetRecommendVideoList",Url];
    
    [self PostRequest:url andpram:nil];
}


#pragma mark - 确认订单(购物车点结算)
- (void)getConfirmOrderWithShopcart_id:(NSString *)shopcart_id
{
    if(shopcart_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@ShopCart/getConfirmOrder",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"shopcart_id\":\"%@\"}",shopcart_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取热门随机图文
- (void)getRecommendArticleList
{
    NSString * url=[NSString stringWithFormat:@"%@article/getRecommendArticleList",Url];
    
    [self PostRequest:url andpram:nil];
}


#pragma mark - 会员资料修改
- (void)updateWithMember_id:(NSString *)member_id member_nickname:(NSString *)member_nickname
{
    if(member_id && member_nickname)
    {
        NSString * url=[NSString stringWithFormat:@"%@site/update",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"member_nickname\":\"%@\"}",member_id,member_nickname]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 会员头像修改
- (void)UploadHeadPicWithMember_id:(NSString *)member_id member_headpic:(NSData *)member_headpic
{
    if(member_id && member_headpic)
    {
        NSString * url=[NSString stringWithFormat:@"%@site/UploadHeadPic",Url];
        NSDictionary * prm=@{@"member_id":member_id};
        
        [self ShowOrderuploadImageWithImage:member_headpic andurl:url andprm:prm andkey:nil];
    }
}


#pragma mark - 加入收藏/取消收藏
- (void)createWithMember_id:(NSString *)member_id article_id:(NSString *)article_id
{
    if(member_id && article_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@ArticleFavorite/create",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"article_id\":\"%@\"}",member_id,article_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 判断图文是否被收藏
- (void)isFavoriteWithMember_id:(NSString *)member_id article_id:(NSString *)article_id
{
    if(member_id && article_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@ArticleFavorite/isFavorite",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"article_id\":\"%@\"}",member_id,article_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 加入收藏/取消收藏
- (void)createWithMember_id:(NSString *)member_id video_id:(NSString *)video_id
{
    if(member_id && video_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@VideoFavorite/create",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"video_id\":\"%@\"}",member_id,video_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 判断视频是否被收藏
- (void)isFavoriteWithMember_id:(NSString *)member_id video_id:(NSString *)video_id
{
    if(member_id && video_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@VideoFavorite/isFavorite",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"video_id\":\"%@\"}",member_id,video_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取某会员的收藏列表并分页
- (void)getProductionFavoriteListWithMember_id:(NSString *)member_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(member_id && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@ProductionFavorite/getProductionFavoriteList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\"}",member_id],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 删除收藏（支持群删除）
- (void)ProductionFavoriteWithFavorite_id:(NSString *)favorite_id
{
    if(favorite_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@ProductionFavorite/delete",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"favorite_id\":\"%@\"}",favorite_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取某会员的收藏列表并分页
- (void)getVideoFavoriteListWithMember_id:(NSString *)member_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(member_id && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@VideoFavorite/getVideoFavoriteList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\"}",member_id],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 删除收藏（支持群删除）
- (void)VideoFavoriteWithFavorite_id:(NSString *)favorite_id
{
    if(favorite_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@VideoFavorite/delete",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"favorite_id\":\"%@\"}",favorite_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 添加视频评论
- (void)createWithMember_id:(NSString *)member_id discuss_content:(NSString *)discuss_content video_id:(NSString *)video_id reply_id:(NSString *)reply_id
{
    if(member_id && discuss_content && video_id && reply_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@discuss/create",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"discuss_content\":\"%@\",\"video_id\":\"%@\",\"reply_id\":\"%@\"}",member_id,discuss_content,video_id,reply_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取某条图文评论的回复列表并分页
- (void)getReplyListWithDiscuss_id:(NSString *)discuss_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(discuss_id && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@discuss/getReplyList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"discuss_id\":\"%@\"}",discuss_id],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取某图文详情
- (void)getArticlesWithArticle_id:(NSString *)article_id
{
    if(article_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@article/getArticles",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"article_id\":\"%@\"}",article_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取某条图文的一级评论列表并分页
- (void)getCommentListWithArticle_id:(NSString *)article_id reply_id:(NSString *)reply_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(article_id && reply_id && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@comment/getCommentList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"article_id\":\"%@\",\"reply_id\":\"%@\"}",article_id,reply_id],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 添加图文评论）
- (void)createWithArticle_id:(NSString *)article_id reply_id:(NSString *)reply_id member_id:(NSString *)member_id comment_content:(NSString *)comment_content
{
    if(article_id && reply_id && member_id && comment_content)
    {
        NSString * url=[NSString stringWithFormat:@"%@comment/create",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"article_id\":\"%@\",\"reply_id\":\"%@\",\"member_id\":\"%@\",\"comment_content\":\"%@\"}",article_id,reply_id,member_id,comment_content]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取某条图文评论的回复列表并分页
- (void)getReplyListWithComment_id:(NSString *)comment_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(comment_id && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@comment/getReplyList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"comment_id\":\"%@\"}",comment_id],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 加入收藏/取消收藏
- (void)ArticleFavoriteWithMember_id:(NSString *)member_id article_id:(NSString *)article_id
{
    if(article_id && member_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@ArticleFavorite/create",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"article_id\":\"%@\"}",member_id,article_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取某会员的收藏列表并分页
- (void)getArticleFavoriteListWithMember_id:(NSString *)member_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(member_id && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@ArticleFavorite/getArticleFavoriteList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\"}",member_id],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 删除收藏（支持群删除）
- (void)deletetuwenWithFavorite_id:(NSString *)favorite_id
{
    if(favorite_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@ArticleFavorite/delete",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"favorite_id\":\"%@\"}",favorite_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取某会员的收藏列表并分页
- (void)getCityWithLng:(NSString *)lng lat:(NSString *)lat
{
    if(lng && lat)
    {
        NSString * url=[NSString stringWithFormat:@"%@baidu/getCity",Url];
        NSDictionary * prm=@{@"lng":lng,@"lat":lat};
        
        [self GetRequest:url andpram:prm];
        
//        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取课程列表
- (void)CourseWithPagenumber:(NSString *)pagenumber status:(NSString *)status
{
    if(pagenumber && status)
    {
        NSString * url=[NSString stringWithFormat:@"%@Course/Course",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"status\":\"%@\"}",status],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\"}",pagenumber]};
        
        [self GetRequest:url andpram:prm];
    }
}


#pragma mark -  获取单个课程详情
- (void)CourseWithCourse_id:(NSString *)course_id
{
    if(course_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@Course/Course",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"course_id\":\"%@\"}",course_id]};
        
        [self GetRequest:url andpram:prm];
    }
}


#pragma mark -  获取单个课程详情的web页
- (void)CourseIntroWithCourse_id:(NSString *)course_id
{
    if(course_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@Course/Course",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"course_id\":\"%@\"}",course_id]};
        
        [self GetRequest:url andpram:prm];
    }
}

#pragma mark -  获取某用户的所有订单
- (void)getOrdersWithMember_id:(NSString *)member_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(member_id && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@order/getOrders",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\"}",member_id],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark -  获取某用户的所有“未付款”订单并分页
- (void)getOrdersWithMember_id:(NSString *)member_id order_status:(NSString *)order_status pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(member_id && order_status && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@order/getOrders",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"order_status\":\"%@\"}",member_id,order_status],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark -  发表意见接口
- (void)createWithMember_id:(NSString *)member_id suggest_content:(NSString *)suggest_content
{
    if(member_id && suggest_content)
    {
        NSString * url=[NSString stringWithFormat:@"%@suggest/create",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"suggest_content\":\"%@\"}",member_id,suggest_content]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark -  获取个人是否申请成功
- (void)ApplyagentWithMember_id:(NSString *)member_id
{
    if(member_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@Applyagent/Applyagent",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\"}",member_id]};
        
        [self GetRequest:url andpram:prm];
    }
}


#pragma mark -  申请代理商(post)
- (void)createWithMember_id:(NSString *)member_id applyAgent_name:(NSString *)applyAgent_name applyAgent_phone:(NSString *)applyAgent_phone idcard_frond:(NSData *)idcard_frond idcard_side:(NSData *)idcard_side framework_image:(NSData *)framework_image business_image:(NSData *)business_image
{
    if(member_id && applyAgent_name && applyAgent_phone && idcard_frond && idcard_side && framework_image && business_image)
    {
        NSString * url=[NSString stringWithFormat:@"%@Applyagent/create",Url];
        
        
        NSDictionary * prm = @{@"member_id":member_id,@"applyAgent_name":applyAgent_name,@"applyAgent_phone":applyAgent_phone};
        
        [self ShowOrderuploadImageWithImage1:idcard_frond Image2:idcard_side Image3:framework_image Image4:business_image andurl:url andprm:prm andkey:nil];
    }
}

#pragma mark - 会员密码修改
- (void)createWithMember_username:(NSString *)member_username member_password:(NSString *)member_password member_new_password:(NSString *)member_new_password
{
    if(member_username && member_password && member_new_password)
    {
        NSString * url=[NSString stringWithFormat:@"%@site/updatePassword",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_username\":\"%@\",\"member_password\":\"%@\",\"member_new_password\":\"%@\"}",member_username,member_password,member_new_password]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark -  获取某会员"钱包"流水记录
- (void)createWithMember_id:(NSString *)member_id record_type:(NSString *)record_type pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(member_id && record_type && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@cashRecord/getCashRecords",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"record_type\":\"%@\"}",member_id,record_type],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark -  获取会员详细信息
- (void)GetMembersWithMember_id:(NSString *)member_id
{
    if(member_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@site/GetMembers",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\"}",member_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 申请提现
- (void)createWithMember_id:(NSString *)member_id record_type:(NSString *)record_type  change_type:(NSString *)change_type alipay_account:(NSString *)alipay_account change_amount:(NSString *)change_amount andremark:(NSString *)remark andbank_account:(NSString *)bank_account andwallet_password:(NSString *)wallet_password
{
    if(member_id && record_type && change_type && alipay_account && change_amount&&remark&&bank_account&&wallet_password)
    {
        NSString * url=[NSString stringWithFormat:@"%@cashRecord/create",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"record_type\":\"%@\",\"change_type\":\"%@\",\"alipay_account\":\"%@\",\"change_amount\":\"%@\",\"remark\":\"%@\",\"bank_account\":\"%@\",\"wallet_password\":\"%@\"}",member_id,record_type,change_type,alipay_account,change_amount,remark,bank_account,wallet_password]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark -  获取统计数据
- (void)StatisticalDataWithMember_id:(NSString *)member_id
{
    if(member_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@site/StatisticalData",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\"}",member_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark -  获取一级会员列表并分页
- (void)GetFirstLevelMembersWithMember_id:(NSString *)member_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(member_id && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@site/GetFirstLevelMembers",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\"}",member_id],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark -  获取二级会员列表并分页
- (void)GetSecondLevelMembersWithMember_id:(NSString *)member_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(member_id && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@site/GetSecondLevelMembers",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\"}",member_id],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark -  取消订单
- (void)updateWithOrders_id:(NSString *)orders_id order_status:(NSString *)order_status
{
    if(orders_id && order_status)
    {
        NSString * url=[NSString stringWithFormat:@"%@order/update",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"orders_id\":\"%@\",\"order_status\":\"%@\"}",orders_id,order_status]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark -  删除订单
- (void)deleteWithOrders_id:(NSString *)orders_id
{
    if(orders_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@order/delete",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"orders_id\":\"%@\"}",orders_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取名师名店列表（进行分页）：
- (void)FamousTeacherpagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    NSString * url=[NSString stringWithFormat:@"%@FamousTeacher/Teacher",Url];
    
    NSDictionary * prm=@{@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};

    [self PostRequest:url andpram:prm];
}

#pragma mark - 获取名师详细信息（不进行分页）：
- (void)FamousTeacherWithTeacher_id:(NSString *)teacher_id
{
    if(teacher_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@FamousTeacher/Teacher",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"teacher_id\":\"%@\"}",teacher_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取合作店列表（根据城市）
- (void)CooperateStoreWithTeacher_id:(NSString *)city_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(city_id && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@CooperateStore/CooperateStore",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"city_id\":\"%@\"}",city_id],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取高级技师列表
- (void)SeniorTechnicianWithcity_id:(NSString *)city_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(city_id && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@SeniorTechnician/SeniorTechnician",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"city_id\":\"%@\"}",city_id],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取高级技师详情
- (void)SeniorTechnicianWithTechnician_id:(NSString *)technician_id
{
    if(technician_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@SeniorTechnician/SeniorTechnician",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"technician_id\":\"%@\"}",technician_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取合作店下产品列表
- (void)GetStoreProductsWithStore_id:(NSString *)store_id
{
    if(store_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@StoreProduct/GetStoreProducts",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"store_id\":\"%@\"}",store_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - (3)添加一个订单
- (void)createWithStore_id:(NSString *)store_id member_id:(NSString *)member_id product_id:(NSString *)product_id technician_id:(NSString *)technician_id order_payable:(NSString *)order_payable order_realpay:(NSString *)order_realpay union_order_status:(NSString *)union_order_status pay_method:(NSString *)pay_method andwallet_password:(NSString *)wallet_password
{
    if(store_id && member_id && product_id && technician_id && order_payable && order_realpay && union_order_status && pay_method&&wallet_password)
    {
        NSString * url=[NSString stringWithFormat:@"%@UnionOrder/create",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"store_id\":\"%@\",\"member_id\":\"%@\",\"product_id\":\"%@\",\"technician_id\":\"%@\",\"order_payable\":\"%@\",\"order_realpay\":\"%@\",\"union_order_status\":\"%@\",\"pay_method\":\"%@\",\"wallet_password\":\"%@\"}",store_id,member_id,product_id,technician_id,order_payable,order_realpay,union_order_status,pay_method,wallet_password]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - (2)获取某用户的所有订单并分页
- (void)GetOrdersWithmember_id:(NSString *)member_id union_order_status:(NSString *)union_order_status pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(member_id && union_order_status && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@UnionOrder/GetOrders",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"union_order_status\":\"%@\"}",member_id,union_order_status],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 删除多个或一个订单
- (void)deleteWithStore_id:(NSString *)order_id
{
    if(order_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@UnionOrder/delete",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"order_id\":\"%@\"}",order_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 商盟产品接口
- (void)productWithcategory_id:(NSString *)category_id is_maker:(NSString *)is_maker is_sell:(NSString *)is_sell pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(category_id && pagenumber && pagesize && is_maker && is_sell)
    {
        NSString * url=[NSString stringWithFormat:@"%@product/getProductList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"category_id\":\"%@\",\"is_maker\":\"%@\",\"is_sell\":\"%@\"}",category_id,is_maker,is_sell],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}

//#pragma mark - 添加一个订单(POST提交)
//- (void)createWithMember_id:(NSString *)member_id pay_method:(NSString *)pay_method  pay_status:(NSString *)pay_status orderlist:(NSMutableArray *)orderlist
//{
//    if(member_id && pay_method && pay_status && orderlist)
//    {
//        NSString * url=[NSString stringWithFormat:@"%@order/create",Url];
//        
//        NSString *jsonString = [[NSString alloc] initWithData:[self toJSONData:orderlist] encoding:NSUTF8StringEncoding];
//        
//        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"pay_method\":\"%@\",\"pay_status\":\"%@\",\"orderlist\":\"%@\"}",member_id,pay_method,pay_status,orderlist]};
//        
//        
//        [self PostRequest:url andpram:prm];
//    }
//}


#pragma mark -  说说
- (void)createWithMember_id:(NSString *)member_id talk_content:(NSString *)talk_content
{
    if(member_id && talk_content)
    {
        NSString * url=[NSString stringWithFormat:@"%@talk/create",Url];
                
        NSDictionary * prm = @{@"member_id":member_id,@"talk_content":talk_content};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark -  说说1(图片)
- (void)createWithMember_id:(NSString *)member_id talk_content:(NSString *)talk_content file_type:(NSString *)file_type file_path1:(NSData *)file_path1 file_path2:(NSData *)file_path2 file_path3:(NSData *)file_path3 file_path4:(NSData *)file_path4 file_path5:(NSData *)file_path5 file_path6:(NSData *)file_path6
{
    if(member_id && file_type)
    {
        NSString * url=[NSString stringWithFormat:@"%@talk/create",Url];
        
        NSDictionary * prm = @{@"member_id":member_id,@"talk_content":talk_content,@"file_type":file_type};
        
        [self ShowOrderuploadImageWithImage1:file_path1 Image2:file_path2 Image3:file_path3 Image4:file_path4 Image5:file_path5 Image6:file_path6 andurl:url andprm:prm andkey:nil];
    }
}

#pragma mark -  说说1(图片)
- (void)createWithMember_id:(NSString *)member_id talk_content:(NSString *)talk_content file_type:(NSString *)file_type arr:(NSMutableArray *)arr
{
    if(member_id && file_type)
    {
        NSString * url=[NSString stringWithFormat:@"%@talk/create",Url];
        
        NSDictionary * prm = @{@"member_id":member_id,@"talk_content":talk_content,@"file_type":file_type};
        
        [self ShowOrderuploadImageWithArr:arr andurl:url andprm:prm andkey:nil];
    }
}


#pragma mark -  说说1(视频)
- (void)createWithMember_id:(NSString *)member_id talk_content:(NSString *)talk_content file_type:(NSString *)file_type Path:(NSURL *)videoPath
{
    if(member_id && file_type && videoPath)
    {
        NSString * url=[NSString stringWithFormat:@"%@talk/Video",Url];
//        NSData* imageData = [[NSData alloc] initWithContentsOfURL:videoPath];
//            NSString *imagebase64= [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        //    NSDictionary *prm = @{@"fileName":@"video.mov",@"filestream":imagebase64};
//        NSDictionary * prm = @{@"member_id":member_id,@"talk_content":talk_content,@"file_type":file_type,@"file_path":imageData,@"file_name":@"video.mov"};
        
        NSDictionary * prm = @{@"member_id":member_id,@"talk_content":talk_content,@"file_type":file_type};
        
        [self uploadVideo1WithFilePath:videoPath andurl:url andprm:prm];
        
//        [self PostRequest:url andpram:prm];
    }
}



#pragma mark -  说说分页列表
- (void)talkAllWithmember_id:(NSString *)member_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(pagenumber && pagesize && member_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@talk/talkAll",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\"}",member_id],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark -  说说点赞
- (void)TakeGoodWithMember_id:(NSString *)member_id talk_id:(NSString *)talk_id
{
    if(member_id && talk_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@Reply/TakeGood",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"talk_id\":\"%@\"}",member_id,talk_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark -  获取单条说说详情
- (void)TakeGoodWithTalk_id:(NSString *)talk_id member_id:(NSString *)member_id
{
    if(talk_id && member_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@talk/talkGood",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"talk_id\":\"%@\",\"member_id\":\"%@\"}",talk_id,member_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark -  说说留言
- (void)TakeGoodWithTalk_id:(NSString *)talk_id member_id:(NSString *)member_id reply_content:(NSString *)reply_content reply_status:(NSString *)reply_status
{
    if(talk_id && member_id && reply_content && reply_status)
    {
        NSString * url=[NSString stringWithFormat:@"%@Reply/talkReply",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"talk_id\":\"%@\",\"member_id\":\"%@\",\"reply_content\":\"%@\",\"reply_status\":\"%@\"}",talk_id,member_id,reply_content,reply_status]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark -  说说分页列表（某一用户）
- (void)talkWithmember_id:(NSString *)member_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(pagenumber && pagesize && member_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@talk/talk",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\"}",member_id],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark -  说说删除
- (void)talkWithtalk_id:(NSString *)talk_id
{
    if(talk_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@talk/delete",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"talk_id\":\"%@\"}",talk_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark -  获取某城市的招聘信息列表
- (void)talkWithArea_id:(NSString *)area_id salary_id:(NSString *)salary_id type_id:(NSString *)type_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(pagenumber && pagesize && area_id && salary_id && type_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@Recruit/Recruit",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"area_id\":\"%@\",\"salary_id\":\"%@\",\"type_id\":\"%@\"}",area_id,salary_id,type_id],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark -  获取某城市的应聘信息列表：
- (void)VitaeWithArea_id:(NSString *)area_id salary_id:(NSString *)salary_id type_id:(NSString *)type_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(pagenumber && pagesize && area_id && salary_id && type_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@Vitae/Vitae",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"area_id\":\"%@\",\"salary_id\":\"%@\",\"type_id\":\"%@\"}",area_id,salary_id,type_id],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark -  6）招聘类别
- (void)RecruitType
{
    NSString * url=[NSString stringWithFormat:@"%@Recruit/Type",Url];
    
    [self PostRequest:url andpram:nil];
}

#pragma mark -  7）招聘薪资区间
- (void)RecruitSalary
{
    NSString * url=[NSString stringWithFormat:@"%@Recruit/Salary",Url];
    
    [self PostRequest:url andpram:nil];
}


#pragma mark - 获取单个应聘详情
- (void)talkWithvitae_id:(NSString *)vitae_id
{
    if(vitae_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@Vitae/Vitae",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"vitae_id\":\"%@\"}",vitae_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark -  获取单个招聘详情
- (void)talkWithrecruit_id:(NSString *)recruit_id
{
    if(recruit_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@Recruit/Recruit",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"recruit_id\":\"%@\"}",recruit_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark -  发布简历（post提交）
- (void)createWithimage:(NSData *)image member_id:(NSString *)member_id name:(NSString *)name age:(NSString *)age sex:(NSString *)sex domicile:(NSString *)domicile work_experience:(NSString *)work_experience telephone:(NSString *)telephone intention_position:(NSString *)intention_position salary_id:(NSString *)salary_id type_id:(NSString *)type_id locationid:(NSString *)locationid area_id:(NSString *)area_id
{
    if(image && member_id && name && age &&sex &&domicile &&work_experience &&telephone &&intention_position &&salary_id &&type_id &&locationid &&area_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@Vitae/create",Url];
        
        NSDictionary * prm = @{@"member_id":member_id,@"name":name,@"age":age,@"sex":sex,@"domicile":domicile,@"work_experience":work_experience,@"telephone":telephone,@"intention_position":intention_position,@"salary_id":salary_id,@"type_id":type_id,@"locationid":locationid,@"area_id":area_id};
        
        [self ShowOrderuploadImageWithImage1_pic:image andurl:url andprm:prm andkey:nil];
    }
}


#pragma mark -  发布招聘（post提交）
- (void)createWithimage:(NSData *)image number:(NSString *)number workname:(NSString *)workname salary_id:(NSString *)salary_id type_id:(NSString *)type_id area_id:(NSString *)area_id location:(NSString *)location job_description:(NSString *)job_description company_name:(NSString *)company_name company_locat:(NSString *)company_locat company_scale:(NSString *)company_scale company_brief:(NSString *)company_brief company_natrue:(NSString *)company_natrue company_industry:(NSString *)company_industry telephone:(NSString *)telephone
{
    if(image && number && workname && salary_id &&type_id &&area_id &&location &&job_description &&company_name &&company_locat &&company_scale &&company_brief &&company_natrue && company_industry && telephone)
    {
        NSString * url=[NSString stringWithFormat:@"%@Recruit/create",Url];
        
        NSDictionary * prm = @{@"number":number,@"workname":workname,@"salary_id":salary_id,@"type_id":type_id,@"area_id":area_id,@"location":location,@"job_description":job_description,@"company_name":company_name,@"company_locat":company_locat,@"company_scale":company_scale,@"company_brief":company_brief,@"company_natrue":company_natrue,@"company_industry":company_industry,@"telephone":telephone};
        
        [self ShowOrderuploadImageWithImage1_pic:image andurl:url andprm:prm andkey:nil];
    }
}

#pragma mark -  充值
- (void)createWithMember_id:(NSString *)member_id pay_total:(NSString *)pay_total pay_method:(NSString *)pay_method andwallet_password:(NSString *)wallet_password
{
    if(member_id && pay_total && pay_method&&wallet_password)
    {
        NSString * url=[NSString stringWithFormat:@"%@rechargeRecord/create",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"pay_total\":\"%@\",\"pay_method\":\"%@\",\"wallet_password\":\"%@\"}",member_id,pay_total,pay_method,wallet_password]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark -  订单支付接口
- (void)createWithMember_id:(NSString *)member_id orders_id:(NSString *)orders_id pay_method:(NSString *)pay_method orders_total:(NSString * )orders_total andwallet_password:(NSString *)wallet_password
{
    if(member_id && orders_id && pay_method && orders_total&&wallet_password)
    {
        NSString * url=[NSString stringWithFormat:@"%@order/payOrder",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"orders_id\":\"%@\",\"pay_method\":\"%@\",\"orders_total\":\"%@\",\"wallet_password\":\"%@\"}",member_id,orders_id,pay_method,orders_total,wallet_password]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark -  升级金卡会员支付接口
- (void)upgradeRecordWithMember_id:(NSString *)member_id pay_total:(NSString *)pay_total pay_method:(NSString * )pay_method andwallet_password:(NSString *)wallet_password
{
    if(member_id && pay_total && pay_method&&wallet_password)
    {
        NSString * url=[NSString stringWithFormat:@"%@upgradeRecord/create",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"pay_total\":\"%@\",\"pay_method\":\"%@\",\"wallet_password\":\"%@\"}",member_id,pay_total,pay_method,wallet_password]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark -  	（3）会员报名
- (void)SignupWithMember_id:(NSString *)member_id course_id:(NSString *)course_id pay_method:(NSString * )pay_method andwallet_password:(NSString *)wallet_password
{
    if(member_id && course_id && pay_method&&wallet_password)
    {
        NSString * url=[NSString stringWithFormat:@"%@Signup/create",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"course_id\":\"%@\",\"pay_method\":\"%@\",\"wallet_password\":\"%@\"}",member_id,course_id,pay_method,wallet_password]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark -  视频支付接口
- (void)SignupWithMember_id:(NSString *)member_id video_id:(NSString *)video_id pay_total:(NSString * )pay_total pay_method:(NSString *)pay_method andwallet_password:(NSString *)wallet_password
{
    if(member_id && video_id && pay_total && pay_method&&wallet_password)
    {
        NSString * url=[NSString stringWithFormat:@"%@VideoRecord/create",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"video_id\":\"%@\",\"pay_total\":\"%@\",\"pay_method\":\"%@\",\"wallet_password\":\"%@\"}",member_id,video_id,pay_total,pay_method,wallet_password]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark -  首页签到接口
- (void)CreateAutoLoginUrlWithMember_id:(NSString *)member_username
{
    if(member_username)
    {
        NSString * url=[NSString stringWithFormat:@"%@Duiba/CreateAutoLoginUrl",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_username\":\"%@\"}",member_username]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark -  判断课程是否报名
- (void)ifsignupWithCourse_id:(NSString *)course_id member_id:(NSString *)member_id
{
    if(member_id && course_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@signup/ifsignup",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"course_id\":\"%@\"}",member_id,course_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取某会员的收货地址
- (void)getAddressesWithaddress_id:(NSString *)address_id
{
    if(address_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@address/getAddresses",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"address_id\":\"%@\"}",address_id]};
        
        [self PostRequest:url andpram:prm];
    }
    
}


#pragma mark - 获取某会员的佣金来源详情
-(void)GetyongjinDetialWithmember_id:(NSString *)member_id andorder_status:(NSString *)order_status andmember_level:(NSString *)member_level andpagenumber:(NSString *)pagenumber andpagesize:(NSString *)pagesize
{
    if(member_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@site/GetOrdersWithBrokerage",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"order_status\":\"%@\",\"member_level\":\"%@\"}",member_id,order_status,member_level],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}
-(void)AppleVerifyWithmenber_id:(NSString *)member_id andverify_code:(NSData *)verify_code anduuid:(NSString *)uuid andtype:(NSString *)type
{
    if(member_id&&verify_code&&uuid&&type)
    {
        NSString * url=[NSString stringWithFormat:@"%@AppleVerify/Verify",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"verify_code\":\"%@\",\"uuid\":\"%@\",\"type\":\"%@\"}",member_id,verify_code,uuid,type]};
        
        [self PostRequest:url andpram:prm];
    }
}

-(void)GetRightList:(NSString *)uuid
{
    if(uuid)
    {
        NSString * url=[NSString stringWithFormat:@"%@AppleRight/GetRightList",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"uuid\":\"%@\"}",uuid]};
        
        [self PostRequest:url andpram:prm];
    }
}
-(void)AppleRightUpdate:(NSString *)uuid andtype:(NSString *)type
{
    if(uuid&&type)
    {
        NSString * url=[NSString stringWithFormat:@"%@AppleRight/GetRightList",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"uuid\":\"%@\",\"type\":\"%@\"}",uuid,type]};
        
        [self PostRequest:url andpram:prm];
    }
}
-(void)IsShowVIP
{
    NSString * url=[NSString stringWithFormat:@"%@AppleRight/ShowOrHideControl",Url];
    
    [self PostRequest:url andpram:nil];
}
-(void)setPasswordWithmember_id:(NSString *)member_id andwallet_password:(NSString *)wallet_password
{
    if(member_id&&wallet_password)
    {
        NSString * url=[NSString stringWithFormat:@"%@wallet/setPassword",Url];
        
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"wallet_password\":\"%@\"}",member_id,wallet_password]};
        
        [self PostRequest:url andpram:prm];
    }
}




































#pragma mark 赋值回调
- (void)setDelegateObject:(id)cbobject setBackFunctionName:(NSString *)selectorName
{
    CallBackObject = cbobject;
    callBackFunctionName = selectorName;
}


-(void)PostRequest:(NSString *)url andpram:(NSDictionary *)pram
{
    AFHTTPRequestOperationManager * manage=[[AFHTTPRequestOperationManager alloc] init];
    manage.responseSerializer=[AFHTTPResponseSerializer serializer];
    manage.requestSerializer=[AFHTTPRequestSerializer serializer];
    manage.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];//可接收到的数据类型
    manage.requestSerializer.timeoutInterval=20;//设置请求时限
    NSDictionary * prm =[[NSDictionary alloc] init];
    if (pram!=nil) {
        prm=pram;
    }
    [manage POST:url parameters:prm success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSDictionary * dict =responseObject;
        NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
//        /*解析xml字符串开始*/
//        SBXMLParser * parser = [[SBXMLParser alloc] init];
//        XMLElement * root = [parser parserXML:[str dataUsingEncoding:NSASCIIStringEncoding]];
//        NSLog(@"解析后：root=%@",root.text);
//        /*解析xml字符串结束*/
        NSLog(@"check time 1");
        NSData * data =[str dataUsingEncoding:NSUTF8StringEncoding];
        id dict =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        SEL func_selector = NSSelectorFromString(callBackFunctionName);
        if ([CallBackObject respondsToSelector:func_selector]) {
            NSLog(@"回调成功...");
            [CallBackObject performSelector:func_selector withObject:dict];
        }else{
            NSLog(@"回调失败...");
            [SVProgressHUD dismiss];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
        [SVProgressHUD showErrorWithStatus:@"请检查网络" maskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD dismiss];
    }];
}




-(void)GetRequest:(NSString *)url andpram:(NSDictionary *)pram
{
    AFHTTPRequestOperationManager * manage=[[AFHTTPRequestOperationManager alloc] init];
    manage.responseSerializer=[AFHTTPResponseSerializer serializer];
    manage.requestSerializer=[AFHTTPRequestSerializer serializer];
    manage.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];//可接收到的数据类型
    manage.requestSerializer.timeoutInterval=10;//设置请求时限
    NSDictionary * prm =[[NSDictionary alloc] init];
    if (pram!=nil) {
        prm=pram;
    }
    [manage GET:url parameters:prm success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSData * data =[str dataUsingEncoding:NSUTF8StringEncoding];
        
        id dict =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        SEL func_selector = NSSelectorFromString(callBackFunctionName);
        if ([CallBackObject respondsToSelector:func_selector]) {
            NSLog(@"回调成功...");
            [CallBackObject performSelector:func_selector withObject:dict];
        }else{
            NSLog(@"回调失败...");
            [SVProgressHUD dismiss];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
        [SVProgressHUD showErrorWithStatus:@"请检查网络" maskType:SVProgressHUDMaskTypeBlack];
    }];
}

- (void)uploadImageWithImage:(NSString *)imagePath andurl:(NSString *)url andprm:(NSDictionary *)prm
{
    NSData *data=[NSData dataWithContentsOfFile:imagePath];
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:prm constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"filestream" fileName:@"avatar.jpg" mimeType:@"image/jpg"];
//        [formData appendPartWithFileURL:<#(nonnull NSURL *)#> name:<#(nonnull NSString *)#> fileName:<#(nonnull NSString *)#> mimeType:<#(nonnull NSString *)#> error:<#(NSError *__autoreleasing  _Nullable * _Nullable)#>];
    }];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data =[str dataUsingEncoding:NSUTF8StringEncoding];
        id dict =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        SEL func_selector = NSSelectorFromString(callBackFunctionName);
        if ([CallBackObject respondsToSelector:func_selector]) {
            NSLog(@"回调成功...");
            [CallBackObject performSelector:func_selector withObject:dict];
        }else{
            NSLog(@"回调失败...");
            [SVProgressHUD dismiss];
        }
        NSLog(@"上传完成");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败->%@", error);
        [SVProgressHUD showErrorWithStatus:@"请检查网络" maskType:SVProgressHUDMaskTypeBlack];
    }];
    
    //执行
    NSOperationQueue * queue =[[NSOperationQueue alloc] init];
    [queue addOperation:op];
//    FileDetail *file = [FileDetail fileWithName:@"avatar.jpg" data:data];
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            file,@"FILES",
//                            @"avatar",@"name",
//                            key, @"key", nil];
//    NSDictionary *result = [HttpRequest upload:[NSString stringWithFormat:@"%@index.php?act=member_index&op=avatar_upload",Url] widthParams:params];
//    NSLog(@"%@",result);
}

- (void)UploadImageWithImage:(NSData *)imagedata andurl:(NSString *)url andprm:(NSDictionary *)prm
{
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:prm constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imagedata name:@"filestream" fileName:@"showorder_img.jpg" mimeType:@"image/jpg"];
    }];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data =[str dataUsingEncoding:NSUTF8StringEncoding];
        id dict =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        SEL func_selector = NSSelectorFromString(callBackFunctionName);
        if ([CallBackObject respondsToSelector:func_selector]) {
            NSLog(@"回调成功...");
            [CallBackObject performSelector:func_selector withObject:dict];
        }else{
            NSLog(@"回调失败...");
            [SVProgressHUD dismiss];
        }
        NSLog(@"上传完成");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败->%@", error);
        [SVProgressHUD showErrorWithStatus:@"请检查网络" maskType:SVProgressHUDMaskTypeBlack];
    }];
    
    //执行
    NSOperationQueue * queue =[[NSOperationQueue alloc] init];
    [queue addOperation:op];
    //    FileDetail *file = [FileDetail fileWithName:@"avatar.jpg" data:data];
    //    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
    //                            file,@"FILES",
    //                            @"avatar",@"name",
    //                            key, @"key", nil];
    //    NSDictionary *result = [HttpRequest upload:[NSString stringWithFormat:@"%@index.php?act=member_index&op=avatar_upload",Url] widthParams:params];
    //    NSLog(@"%@",result);
}


- (void)uploadVideoWithFilePath:(NSURL *)videoPath andurl:(NSString *)url andprm:(NSDictionary *)prm
{
    NSData *itemdata=[NSData dataWithContentsOfURL:videoPath];
//    
//    NSData * data=[[NSData alloc] initWithBase64EncodedData:itemdata options:0];
    
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [itemdata base64EncodedStringWithOptions:0];
    
    
    // NSData from the Base64 encoded str
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64Encoded options:0];
    
    
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:prm constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"filestream" fileName:@"video.mov" mimeType:@"video/quicktime"];
    }];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data =[str dataUsingEncoding:NSUTF8StringEncoding];
        id dict =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        SEL func_selector = NSSelectorFromString(callBackFunctionName);
        if ([CallBackObject respondsToSelector:func_selector]) {
            NSLog(@"回调成功...");
            [CallBackObject performSelector:func_selector withObject:dict];
        }else{
            NSLog(@"回调失败...");
            [SVProgressHUD dismiss];
        }
        NSLog(@"上传完成");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败->%@", error);
        [SVProgressHUD showErrorWithStatus:@"请检查网络" maskType:SVProgressHUDMaskTypeBlack];
    }];
    
    //执行
    NSOperationQueue * queue =[[NSOperationQueue alloc] init];
    [queue addOperation:op];
    //    FileDetail *file = [FileDetail fileWithName:@"avatar.jpg" data:data];
    //    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
    //                            file,@"FILES",
    //                            @"avatar",@"name",
    //                            key, @"key", nil];
    //    NSDictionary *result = [HttpRequest upload:[NSString stringWithFormat:@"%@index.php?act=member_index&op=avatar_upload",Url] widthParams:params];
    //    NSLog(@"%@",result);
}


// 将字典或者数组转化为JSON串
- (NSData *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}


- (void)ShowOrderuploadImageWithImage:(NSData *)imagedata andurl:(NSString *)url andprm:(NSDictionary *)prm andkey:(NSString *)key
{
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:prm constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        
        [formData appendPartWithFileData:imagedata name:@"member_headpic" fileName:@"member_headpic.png" mimeType:@"image/png"];
    }];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data =[str dataUsingEncoding:NSUTF8StringEncoding];
        id dict =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        SEL func_selector = NSSelectorFromString(callBackFunctionName);
        if ([CallBackObject respondsToSelector:func_selector]) {
            NSLog(@"回调成功...");
            [CallBackObject performSelector:func_selector withObject:dict];
        }else{
            NSLog(@"回调失败...");
            [SVProgressHUD dismiss];
        }
        NSLog(@"上传完成");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败->%@", error);
        [SVProgressHUD dismiss];
    }];
    
    //执行
    NSOperationQueue * queue =[[NSOperationQueue alloc] init];
    [queue addOperation:op];
    //    FileDetail *file = [FileDetail fileWithName:@"avatar.jpg" data:data];
    //    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
    //                            file,@"FILES",
    //                            @"avatar",@"name",
    //                            key, @"key", nil];
    //    NSDictionary *result = [HttpRequest upload:[NSString stringWithFormat:@"%@index.php?act=member_index&op=avatar_upload",Url] widthParams:params];
    //    NSLog(@"%@",result);
}


//
- (void)ShowOrderuploadImageWithImage1:(NSData *)idcard_frond Image2:(NSData *)idcard_side Image3:(NSData *)framework_image Image4:(NSData *)business_image andurl:(NSString *)url andprm:(NSDictionary *)prm andkey:(NSString *)key
{
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:prm constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //1
        [formData appendPartWithFileData:idcard_frond name:@"idcard_frond" fileName:@"idcard_frond.png" mimeType:@"image/png"];
        //2
        [formData appendPartWithFileData:idcard_side name:@"idcard_side" fileName:@"idcard_side.png" mimeType:@"image/png"];
        
        [formData appendPartWithFileData:framework_image name:@"framework_image" fileName:@"framework_image.png" mimeType:@"image/png"];
        
        [formData appendPartWithFileData:business_image name:@"business_image" fileName:@"business_image.png" mimeType:@"image/png"];
    }];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data =[str dataUsingEncoding:NSUTF8StringEncoding];
        id dict =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        SEL func_selector = NSSelectorFromString(callBackFunctionName);
        if ([CallBackObject respondsToSelector:func_selector]) {
            NSLog(@"回调成功...");
            [CallBackObject performSelector:func_selector withObject:dict];
        }else{
            NSLog(@"回调失败...");
            [SVProgressHUD dismiss];
        }
        NSLog(@"上传完成");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败->%@", error);
        [SVProgressHUD dismiss];
    }];
    
    //执行
    NSOperationQueue * queue =[[NSOperationQueue alloc] init];
    [queue addOperation:op];
    //    FileDetail *file = [FileDetail fileWithName:@"avatar.jpg" data:data];
    //    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
    //                            file,@"FILES",
    //                            @"avatar",@"name",
    //                            key, @"key", nil];
    //    NSDictionary *result = [HttpRequest upload:[NSString stringWithFormat:@"%@index.php?act=member_index&op=avatar_upload",Url] widthParams:params];
    //    NSLog(@"%@",result);
}



- (void)ShowOrderuploadImageWithImage1:(NSData *)image1 Image2:(NSData *)image2 Image3:(NSData *)image3 Image4:(NSData *)image4 Image5:(NSData *)image5 Image6:(NSData *)image6 andurl:(NSString *)url andprm:(NSDictionary *)prm andkey:(NSString *)key
{
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:prm constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //1
        [formData appendPartWithFileData:image1 name:@"file_path1" fileName:@"file_path1.png" mimeType:@"image/png"];
        //2
        [formData appendPartWithFileData:image2 name:@"file_path2" fileName:@"file_path2.png" mimeType:@"image/png"];
        
        [formData appendPartWithFileData:image3 name:@"file_path3" fileName:@"file_path3.png" mimeType:@"image/png"];
        
        [formData appendPartWithFileData:image4 name:@"file_path4" fileName:@"file_path4.png" mimeType:@"image/png"];
        
        [formData appendPartWithFileData:image5 name:@"file_path5" fileName:@"file_path5.png" mimeType:@"image/png"];
        
        [formData appendPartWithFileData:image6 name:@"file_path6" fileName:@"file_path6.png" mimeType:@"image/png"];
    }];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data =[str dataUsingEncoding:NSUTF8StringEncoding];
        id dict =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        SEL func_selector = NSSelectorFromString(callBackFunctionName);
        if ([CallBackObject respondsToSelector:func_selector]) {
            NSLog(@"回调成功...");
            [CallBackObject performSelector:func_selector withObject:dict];
        }else{
            NSLog(@"回调失败...");
            [SVProgressHUD dismiss];
        }
        NSLog(@"上传完成");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败->%@", error);
        [SVProgressHUD dismiss];
    }];
    
    //执行
    NSOperationQueue * queue =[[NSOperationQueue alloc] init];
    [queue addOperation:op];
    //    FileDetail *file = [FileDetail fileWithName:@"avatar.jpg" data:data];
    //    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
    //                            file,@"FILES",
    //                            @"avatar",@"name",
    //                            key, @"key", nil];
    //    NSDictionary *result = [HttpRequest upload:[NSString stringWithFormat:@"%@index.php?act=member_index&op=avatar_upload",Url] widthParams:params];
    //    NSLog(@"%@",result);
}


- (void)ShowOrderuploadImageWithArr:(NSMutableArray *)arr andurl:(NSString *)url andprm:(NSDictionary *)prm andkey:(NSString *)key
{
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:prm constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i = 0 ; i < arr.count; i ++)
        {
            //1
            [formData appendPartWithFileData:arr[i] name:[NSString stringWithFormat:@"file_path%d",i+1] fileName:[NSString stringWithFormat:@"file_path%d.png",i+1] mimeType:@"image/png"];
        }
    }];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data =[str dataUsingEncoding:NSUTF8StringEncoding];
        id dict =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        SEL func_selector = NSSelectorFromString(callBackFunctionName);
        if ([CallBackObject respondsToSelector:func_selector]) {
            NSLog(@"回调成功...");
            [CallBackObject performSelector:func_selector withObject:dict];
        }else{
            NSLog(@"回调失败...");
            [SVProgressHUD dismiss];
        }
        NSLog(@"上传完成");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败->%@", error);
        [SVProgressHUD dismiss];
    }];
    
    //执行
    NSOperationQueue * queue =[[NSOperationQueue alloc] init];
    [queue addOperation:op];
    //    FileDetail *file = [FileDetail fileWithName:@"avatar.jpg" data:data];
    //    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
    //                            file,@"FILES",
    //                            @"avatar",@"name",
    //                            key, @"key", nil];
    //    NSDictionary *result = [HttpRequest upload:[NSString stringWithFormat:@"%@index.php?act=member_index&op=avatar_upload",Url] widthParams:params];
    //    NSLog(@"%@",result);
}


- (void)uploadVideo1WithFilePath:(NSURL *)videoPath andurl:(NSString *)url andprm:(NSDictionary *)prm
{
    NSData *itemdata=[NSData dataWithContentsOfURL:videoPath];
    //
    //    NSData * data=[[NSData alloc] initWithBase64EncodedData:itemdata options:0];
    
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [itemdata base64EncodedStringWithOptions:0];
    
    
    // NSData from the Base64 encoded str
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64Encoded options:0];
    
    
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:prm constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"file_path" fileName:@"video.mov" mimeType:@"video/quicktime"];
    }];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data =[str dataUsingEncoding:NSUTF8StringEncoding];
        id dict =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        SEL func_selector = NSSelectorFromString(callBackFunctionName);
        if ([CallBackObject respondsToSelector:func_selector]) {
            NSLog(@"回调成功...");
            [CallBackObject performSelector:func_selector withObject:dict];
        }else{
            NSLog(@"回调失败...");
            [SVProgressHUD dismiss];
        }
        NSLog(@"上传完成");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败->%@", error);
        [SVProgressHUD showErrorWithStatus:@"请检查网络或防火墙" maskType:SVProgressHUDMaskTypeBlack];
    }];
    
    //执行
    NSOperationQueue * queue =[[NSOperationQueue alloc] init];
    [queue addOperation:op];
    //    FileDetail *file = [FileDetail fileWithName:@"avatar.jpg" data:data];
    //    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
    //                            file,@"FILES",
    //                            @"avatar",@"name",
    //                            key, @"key", nil];
    //    NSDictionary *result = [HttpRequest upload:[NSString stringWithFormat:@"%@index.php?act=member_index&op=avatar_upload",Url] widthParams:params];
    //    NSLog(@"%@",result);
}


- (void)ShowOrderuploadImageWithImage1_pic:(NSData *)image1 andurl:(NSString *)url andprm:(NSDictionary *)prm andkey:(NSString *)key
{
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:prm constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //1
        [formData appendPartWithFileData:image1 name:@"image" fileName:@"image.png" mimeType:@"image/png"];
    }];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data =[str dataUsingEncoding:NSUTF8StringEncoding];
        id dict =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        SEL func_selector = NSSelectorFromString(callBackFunctionName);
        if ([CallBackObject respondsToSelector:func_selector]) {
            NSLog(@"回调成功...");
            [CallBackObject performSelector:func_selector withObject:dict];
        }else{
            NSLog(@"回调失败...");
            [SVProgressHUD dismiss];
        }
        NSLog(@"上传完成");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败->%@", error);
        [SVProgressHUD dismiss];
    }];
    
    //执行
    NSOperationQueue * queue =[[NSOperationQueue alloc] init];
    [queue addOperation:op];
    //    FileDetail *file = [FileDetail fileWithName:@"avatar.jpg" data:data];
    //    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
    //                            file,@"FILES",
    //                            @"avatar",@"name",
    //                            key, @"key", nil];
    //    NSDictionary *result = [HttpRequest upload:[NSString stringWithFormat:@"%@index.php?act=member_index&op=avatar_upload",Url] widthParams:params];
    //    NSLog(@"%@",result);
}


@end

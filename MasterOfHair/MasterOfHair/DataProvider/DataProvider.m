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
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=site/register",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_username\":\"%@\",\"member_password\":\"%@\",\"spread_id\":\"%@\"}",member_username,member_password,spread_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 登陆
- (void)loginWithMember_username:(NSString *)member_username member_password:(NSString *)member_password
{
    if(member_username && member_password)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=site/login",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_username\":\"%@\",\"member_password\":\"%@\"}",member_username,member_password]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 重置密码
- (void)resetPasswordWithMember_username:(NSString *)member_username member_password:(NSString *)member_password
{
    if(member_username && member_password)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=site/resetPassword",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_username\":\"%@\",\"member_password\":\"%@\"}",member_username,member_password]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 商城产品接口
- (void)productWithcity_id:(NSString *)city_id category_id:(NSString *)category_id is_maker:(NSString *)is_maker is_sell:(NSString *)is_sell pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(city_id && category_id && pagenumber && pagesize && is_maker && is_sell)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=product/getProductList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"city_id\":\"%@\",\"category_id\":\"%@\",\"is_maker\":\"%@\",\"is_sell\":\"%@\"}",city_id,category_id,is_maker,is_sell],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 所有区域
- (void)area
{
    NSString * url = [NSString stringWithFormat:@"%@appbackend/index.php?r=area/getCities",Url];
    
    [self PostRequest:url andpram:nil];
}

#pragma mark - 商城详情页
- (void)getProductsWithProduction_id:(NSString *)production_id
{
    if(production_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=product/getProducts",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"production_id\":\"%@\"}",production_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取某会员的所有收货地址
- (void)getAddressesWithMember_id:(NSString *)member_id
{
    if(member_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=address/getAddresses",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\"}",member_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取某会员的默认收货地址
- (void)getAddressesWithMember_id:(NSString *)member_id is_default:(NSString *)is_default
{
    if(member_id && is_default)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=address/getAddresses",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"is_default\":\"%@\"}",member_id,is_default]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 设为默认收货地址
- (void)updateWithAddress_id:(NSString *)address_id is_default:(NSString *)is_default
{
    if(address_id && is_default)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=address/update",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"address_id\":\"%@\",\"is_default\":\"%@\"}",address_id,is_default]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取所有省份
- (void)getAreasWithParent_id:(NSString *)parent_id
{
    if(parent_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=area/getAreas",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"parent_id\":\"%@\"}",parent_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 删除收货地址
- (void)deleteWithAddress_id:(NSString *)address_id
{
    if(address_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=address/delete",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"address_id\":\"%@\"}",address_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 修改收货地址
- (void)updateWithAddress_id:(NSString *)address_id consignee:(NSString *)consignee mobile:(NSString *)mobile province:(NSString *)province city:(NSString *)city area:(NSString *)area address:(NSString *)address
{
    if(address_id && consignee && mobile && province && city && area && address)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=address/update",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"address_id\":\"%@\",\"consignee\":\"%@\",\"mobile\":\"%@\",\"province\":\"%@\",\"city\":\"%@\",\"area\":\"%@\",\"address\":\"%@\"}",address_id,consignee,mobile,province,city,area,address]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 添加收货地址
- (void)createWithMember_id:(NSString *)member_id consignee:(NSString *)consignee mobile:(NSString *)mobile province:(NSString *)province city:(NSString *)city area:(NSString *)area address:(NSString *)address
{
    if(member_id && consignee && mobile && province && city && area && address)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=address/create",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"consignee\":\"%@\",\"mobile\":\"%@\",\"province\":\"%@\",\"city\":\"%@\",\"area\":\"%@\",\"address\":\"%@\"}",member_id,consignee,mobile,province,city,area,address]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 轮播图接口
- (void)getSlidesWithSlide_type:(NSString *)slide_type
{
    if(slide_type)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=slide/getSlides",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"slide_type\":\"%@\"}",slide_type]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取所有产品分类
- (void)getCategories
{
    NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=category/getCategories",Url];
    
    [self PostRequest:url andpram:nil];
}

#pragma mark - 获取某产品分类的子类
- (void)getCategoriesWithCategory_parent_id:(NSString *)category_parent_id
{
    if(category_parent_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=category/getCategories",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"category_parent_id\":\"%@\"}",category_parent_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 加入购物车
- (void)createWithProduction_id:(NSString *)production_id number:(NSString *)number price:(NSString *)price member_id:(NSString *)member_id specs_id:(NSString *)specs_id
{
    if(production_id && number && price && member_id && specs_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=shopcart/create",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"production_id\":\"%@\",\"number\":\"%@\",\"price\":\"%@\",\"member_id\":\"%@\",\"specs_id\":\"%@\"}",production_id,number,price,member_id,specs_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取购物车列表界面
- (void)shopcartWithMember_id:(NSString *)member_id
{
    if(member_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=shopcart/shopcart",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\"}",member_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 设为默认收货地址
- (void)getProductListWithProduction_keyword:(NSString *)production_keyword is_maker:(NSString *)is_maker is_sell:(NSString *)is_sell
{
    if(production_keyword && is_maker && is_sell)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=product/getProductList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"production_keyword\":\"%@\",\"is_maker\":\"%@\",\"is_sell\":\"%@\"}",production_keyword,is_maker,is_sell]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取某分类的图文列表并分页
- (void)getArticleListWithChannel_id:(NSString *)channel_id status_code:(NSString *)status_code pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(channel_id && status_code && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=article/getArticleList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"channel_id\":\"%@\",\"status_code\":\"%@\"}",channel_id,status_code],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取某分类的视频列表并分页
- (void)getArticleListWithVideo_type:(NSString *)video_type is_free:(NSString *)is_free pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(video_type && is_free && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=video/getVideoList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"video_type\":\"%@\",\"is_free\":\"%@\"}",video_type,is_free],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取所有产品分类
- (void)getChannels
{
    NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=channel/getChannels",Url];
    
    [self PostRequest:url andpram:nil];
}


#pragma mark - 视频关键词搜索
- (void)getVideoListWithVideo_keyword:(NSString *)video_keyword pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(video_keyword && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=video/getVideoList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"video_keyword\":\"%@\"}",video_keyword],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 图文关键词搜索
- (void)getArticleListWithArticle_keyword:(NSString *)article_keyword pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(article_keyword && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=article/getArticleList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"article_keyword\":\"%@\"}",article_keyword],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取某视频详情
- (void)getVideosWithVideo_id:(NSString *)video_id
{
    if(video_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=video/getVideos",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"video_id\":\"%@\"}",video_id]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 获取某个视频的一级评论列表并分页
- (void)getDiscussListWithVideo_id:(NSString *)video_id reply_id:(NSString *)reply_id pagenumber:(NSString *)pagenumber pagesize:(NSString *)pagesize
{
    if(video_id && reply_id && pagenumber && pagesize)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=discuss/getDiscussList",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"video_id\":\"%@\",\"reply_id\":\"%@\"}",video_id,reply_id],@"page":[NSString stringWithFormat:@"{\"pagenumber\":\"%@\",\"pagesize\":\"%@\"}",pagenumber,pagesize]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取产品热门列表
- (void)getRecommendProductsWithCity_id:(NSString *)city_id is_sell:(NSString *)is_sell
{
    if(city_id && is_sell)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=product/getRecommendProducts",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"city_id\":\"%@\",\"is_sell\":\"%@\"}",city_id,is_sell]};
        
        [self PostRequest:url andpram:prm];
    }
}

#pragma mark - 编辑购物车(修改数量)
- (void)createWithProduction_id:(NSString *)production_id number:(NSString *)number  member_id:(NSString *)member_id specs_id:(NSString *)specs_id
{
    if(production_id && number && member_id && specs_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=shopcart/create",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"production_id\":\"%@\",\"number\":\"%@\",\"member_id\":\"%@\",\"specs_id\":\"%@\"}",production_id,number,member_id,specs_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 获取某视频详情
- (void)deleteWithShopcart_id:(NSString *)shopcart_id
{
    if(shopcart_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=shopcart/delete",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"shopcart_id\":\"%@\"}",shopcart_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 添加一个订单(POST提交)
- (void)createWithMember_id:(NSString *)member_id shop_id:(NSString *)shop_id shipping_method:(NSString *)shipping_method pay_method:(NSString *)pay_method pay_status:(NSString *)pay_status leave_word:(NSString *)leave_word production_info:(NSString *)production_info production_id:(NSString *)production_id specs_id:(NSString *)specs_id production_count:(NSString *)production_count
{
    if(member_id && shop_id && shipping_method && pay_method && pay_status && leave_word && production_info && production_id && specs_id && production_count)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=order/create",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"shop_id\":\"%@\",\"shipping_method\":\"%@\",\"pay_method\":\"%@\"\"pay_status\":\"%@\",\"leave_word\":\"%@\"\"production_info\":\"%@\"}",member_id,shop_id,shipping_method,pay_method,pay_status,leave_word,production_info],@"page":[NSString stringWithFormat:@"{\"production_id\":\"%@\",\"specs_id\":\"%@\",,\"production_count\":\"%@\"}",production_id,specs_id,production_count]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 加入收藏/取消收藏
- (void)createWithMember_id:(NSString *)member_id production_id:(NSString *)production_id
{
    if(member_id && production_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=ProductionFavorite/create",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"production_id\":\"%@\"}",member_id,production_id]};
        
        [self PostRequest:url andpram:prm];
    }
}


#pragma mark - 判断产品是否被收藏
- (void)isFavoriteWithMember_id:(NSString *)member_id production_id:(NSString *)production_id
{
    if(member_id && production_id)
    {
        NSString * url=[NSString stringWithFormat:@"%@appbackend/index.php?r=ProductionFavorite/isFavorite",Url];
        NSDictionary * prm=@{@"json":[NSString stringWithFormat:@"{\"member_id\":\"%@\",\"production_id\":\"%@\"}",member_id,production_id]};
        
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

@end

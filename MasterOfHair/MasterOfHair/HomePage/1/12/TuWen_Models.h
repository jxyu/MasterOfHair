//
//  TuWen_Models.h
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/24.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TuWen_Models : NSObject

//图文的
@property (nonatomic, copy) NSString * article_click;
@property (nonatomic, copy) NSString * article_id;
@property (nonatomic, copy) NSString * article_keyword;
@property (nonatomic, copy) NSString * article_pic;
@property (nonatomic, copy) NSString * article_title;
@property (nonatomic, copy) NSString * channel_id;



//视频的
@property (nonatomic, copy) NSString * is_free;
@property (nonatomic, copy) NSString * video_click;
@property (nonatomic, copy) NSString * video_id;
@property (nonatomic, copy) NSString * video_img;
@property (nonatomic, copy) NSString * video_price;
@property (nonatomic, copy) NSString * video_title;
@property (nonatomic, copy) NSString * video_type;
@property (nonatomic, copy) NSString * video_url;


@property (nonatomic, copy) NSString * create_time;
@property (nonatomic, copy) NSString * video_brief;
@property (nonatomic, copy) NSString * video_keyword;



@end

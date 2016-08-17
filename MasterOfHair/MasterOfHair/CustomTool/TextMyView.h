//
//  TextMyView.h
//  UITextViewPlaceholder
//
//  Created by Ibokan1 on 16/3/1.
//  Copyright © 2016年 郑子帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextMyView : UITextView

/**
 *  textView 中的提示语
 */
@property (strong, nonatomic) NSString * placeholder;

/**
 *  textView 中提示语的颜色
 */
@property (strong, nonatomic)UIColor * placeholderColor;

/**
 *  textView 中提示语的字号
 */
@property (strong, nonatomic)UIFont * placeholderFont;














@end

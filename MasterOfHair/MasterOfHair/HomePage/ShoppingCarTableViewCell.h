//
//  ShoppingCarTableViewCell.h
//  MasterOfHair
//
//  Created by 鞠超 on 16/1/23.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCarTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton * btn_select;

@property (nonatomic, strong) UIImageView * image;

@property (nonatomic, strong) UILabel * title;

@property (nonatomic, strong) UILabel * detail;

@property (nonatomic, strong) UILabel * price;


@property (nonatomic, strong) UIButton * btn_Subtract;
@property (nonatomic, strong) UIButton * btn_Add;
@property (nonatomic, strong) UILabel * number;


@end

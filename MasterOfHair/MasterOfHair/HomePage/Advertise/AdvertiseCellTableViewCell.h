//
//  AdvertiseCellTableViewCell.h
//  MasterOfHair
//
//  Created by 于金祥 on 16/1/31.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertiseCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_logo;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Detial;
@property (weak, nonatomic) IBOutlet UILabel *lbl_betweenPrice;

@end

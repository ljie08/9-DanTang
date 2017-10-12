//
//  PruductDetailCell.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/27.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PruductDetailCell : UITableViewCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview;

- (void)setDataWithModel:(DanpinXiangxi *)model;

+ (CGFloat)cellHeightWithString:(NSString *)string;

@end

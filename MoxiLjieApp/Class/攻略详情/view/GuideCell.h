//
//  GuideCell.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/29.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideCell : UITableViewCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview;
- (void)setDataWithModel:(Guide *)model;
+ (CGFloat)cellHeightWithString:(NSString *)string;

@end

//
//  HomeCell.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/25.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview;

- (void)setDataWithModel:(Home *)model;

@end

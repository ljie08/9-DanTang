//
//  ProductWebCell.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/27.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductWebCell : UITableViewCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview;

//@property (weak, nonatomic) IBOutlet UIWebView *webview;

@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, assign) CGFloat webviewHeight;

- (void)setProductWithModel:(DanpinXiangxi *)model;

- (void)setGuideWithModel:(Guide *)model;

@end

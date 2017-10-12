//
//  ProductWebCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/27.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "ProductWebCell.h"

@interface ProductWebCell ()<UIWebViewDelegate>


@end

@implementation ProductWebCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"ProductWebCell";
    ProductWebCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ProductWebCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setProductWithModel:(DanpinXiangxi *)model {
    [self.webview loadHTMLString:model.detail_html baseURL:nil];
}

- (void)setGuideWithModel:(Guide *)model {
    [self.webview loadHTMLString:model.content_html baseURL:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //加载本地html
//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    NSURL *baseurl = [NSURL fileURLWithPath:path];
//    NSString *html = [[NSBundle mainBundle] pathForResource:@"text" ofType:@"html"];
//    NSString *htmlc = [NSString stringWithContentsOfFile:html encoding:NSUTF8StringEncoding error:nil];
//    [self.webview loadHTMLString:htmlc baseURL:baseurl];
    
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, CGFLOAT_MIN)];
    self.webview.userInteractionEnabled = NO;
    [self addSubview:self.webview];
    
    [self.webview.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize size = [self.webview sizeThatFits:CGSizeZero];
        self.webview.frame = CGRectMake(0, 0, size.width, size.height);
        
        self.webviewHeight = size.height;
        
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:size.height] forKey:@"webheight"];
        // 用通知发送加载完成后的高度
        [[NSNotificationCenter defaultCenter] postNotificationName:@"webview_height" object:self userInfo:dic];
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [self.webview.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

@end

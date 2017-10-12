//
//  WebViewController.m
//  WKWebViewDemo
//
//  Created by lee on 2017/5/17.
//  Copyright © 2017年 仿佛若有光. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate> {
    UIWebView *_webview;
    UIProgressView *_progressView;
    NSTimer *_timer;
    BOOL _isEnd;//是否加载完成
}

@end

@implementation WebViewController

#pragma mark - life circle
- (void)viewWillDisappear:(BOOL)animated {
    // 移除 progress view
    [_progressView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)initUIView {
    [self initProgressview];
    [self initWebview];
    [self setBackButton:YES];
}

- (void)loadWebview {
    if (_isEnd) {
        if (_progressView.progress >= 1) {
            _progressView.hidden = YES;
            [_timer invalidate];
        } else {
            _progressView.progress += 0.1;
        }
    } else {
        _progressView.progress += 0.05;
        if (_progressView.progress >= 0.95) {
            _progressView.progress = 0.95;
        }
    }
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    _progressView.progress = 0;
    _isEnd = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01667 target:self selector:@selector(loadWebview) userInfo:nil repeats:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //禁止webview的长按选择框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';" ];
    //获取当前网页页面的title
//    NSString *theTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    self.title = theTitle;
    
    _isEnd = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%@",error);
}

#pragma mark - UI
//初始化进度条
- (void)initProgressview {
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[UIProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
//    _progressView.progressTintColor = [UIColor colorWithRed:43.0/255.0 green:186.0/255.0  blue:0.0/255.0  alpha:1.0];
    _progressView.progressTintColor = [UIColor blackColor];
    [self.navigationController.navigationBar addSubview:_progressView];
    
}

//初始化webview
- (void)initWebview {
    [self initTitleViewWithTitle:@"攻略详情"];
    
    _webview = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _webview.delegate = self;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]];
    [_webview loadRequest:request];
    [self.view addSubview:_webview];
}

#pragma mark - 缓存
- (void)removeCache {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

#pragma mark --
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

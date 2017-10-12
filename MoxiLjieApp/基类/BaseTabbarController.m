//
//  BaseTabbarController.m
//  IOSFrame
//
//  Created by lijie on 2017/7/17.
//  Copyright © 2017年 lijie. All rights reserved.
//

#import "BaseTabbarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "ProductViewController.h"
#import "TypeViewController.h"
#import "HomePageViewController.h"

@interface BaseTabbarController ()

@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UITabBar appearance].translucent = NO;
    
    HomePageViewController *home = [[HomePageViewController alloc] init];
    [self setChildVCWithViewController:home title:@"首页" image:[UIImage imageNamed:@"home_normal"] selectedImg:nil];
    
    ProductViewController *product = [[ProductViewController alloc] init];
    [self setChildVCWithViewController:product title:@"单品" image:[UIImage imageNamed:@"gift_normal"] selectedImg:nil];
    
    TypeViewController *type = [[TypeViewController alloc] init];
    [self setChildVCWithViewController:type title:@"分类" image:[UIImage imageNamed:@"search_normal"] selectedImg:nil];
}

- (void)setChildVCWithViewController:(UIViewController *)controller title:(NSString *)title image:(UIImage *)image selectedImg:(UIImage *)selectedImg {
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
    self.tabBar.tintColor = MyColor;

    nav.title = title;
    nav.tabBarItem.image = image;
    nav.tabBarItem.selectedImage = [selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

#pragma mark - tabbar
- (void)presentPlayVC {
    
}



@end

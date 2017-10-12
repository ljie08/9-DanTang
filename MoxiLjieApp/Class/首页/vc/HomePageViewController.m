//
//  HomePageViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/26.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "HomePageViewController.h"
#import "SliderNavBar.h"
#import "HomeViewController.h"
#import "BannerScrollView.h"
#import "HomeViewModel.h"

@interface HomePageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource> {
    SliderNavBar *_navbar;//类型滑动控件
}

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray *pageArr;//子VC数组
@property (nonatomic, assign) NSInteger currentIndex;//当前页面index

@property (nonatomic, strong) BannerScrollView *bannerView;
@property (nonatomic, strong) UIImageView *bannerDefaultImg;//banner默认图片

@property (nonatomic, strong) HomeViewModel *viewmodel;

@property (nonatomic, assign) BOOL hasData;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.hasData = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.hasData) {
        [self loadData];
    }
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[HomeViewModel alloc] init];
}

- (void)loadData {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getHomeNavbarListWithSuccess:^(BOOL result) {
        [weakSelf hideWaiting];
        weakSelf.hasData = YES;
        [weakSelf setupSlider];
        [weakSelf initPage];
        
    } failture:^(NSString *error) {
        [weakSelf hideWaiting];
        weakSelf.hasData = NO;
        [weakSelf showMassage:error];
    }];
}

#pragma mark - 方法
//- (void)setSliderNarbar {
//    NSLog(@"-------");
//}

#pragma mark - UIPageViewControllerDelegate & UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.pageArr indexOfObject:viewController];
    index --;
    if ((index < 0) || (index == NSNotFound)) {
        return nil;
    }
    return self.pageArr[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.pageArr indexOfObject:viewController];
    index ++;
    if (index >= self.pageArr.count) {
        return nil;
    }
    return self.pageArr[index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        HomeViewController *vc = pageViewController.viewControllers.firstObject;
        NSInteger index = [self.pageArr indexOfObject:vc];
        [_navbar moveToIndex:index];
        
        self.currentIndex = index;
    }
}

#pragma mark - UI
- (void)initUIView {
//    self.navigationItem.title = NSLocalizedString(@"分类", nil);
    [self initTitleViewWithTitle:@"首页"];
}

- (void)setupSlider {
    _navbar = [[SliderNavBar alloc] initWithFrame:CGRectMake(0, 0*Heigt_Scale, Screen_Width, 44)];
    _navbar.buttonTitleArr = self.viewmodel.navTitleList;
    _navbar.mode = BottomLineModeEqualBtn;
    _navbar.fontSize = 14;
    _navbar.backgroundColor = MyColor;
    _navbar.selectedColor = MyFontColor;
    _navbar.unSelectedColor = LightGrayFontColor;
    _navbar.bottomLineColor = MyFontColor;
    _navbar.canScrollOrTap = YES;
    [self.view addSubview:_navbar];
}

- (void)initPage {
    // 设置UIPageViewController的配置项
    NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)};
    
    // 根据给定的属性实例化UIPageViewController
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    
    _pageArr = [NSMutableArray array];
    
    for (NSString *homeid in self.viewmodel.navIDList) {
        HomeViewController *homevc = [[HomeViewController alloc] init];
        homevc.homeId = homeid;
        [_pageArr addObject:homevc];
    }
    
    [_pageViewController setViewControllers:[NSArray arrayWithObject:_pageArr[self.currentIndex]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    _pageViewController.view.frame = CGRectMake(0, 44, Screen_Width, Screen_Height - 44 - 69 - 49);
    
    __weak typeof (_pageViewController)weakPageViewController = _pageViewController;
    __weak typeof (_pageArr)weakPageArr = _pageArr;
    @weakSelf(self);
    [_navbar setNavBarTapBlock:^(NSInteger index, UIPageViewControllerNavigationDirection direction) {
        [weakPageViewController setViewControllers:[NSArray arrayWithObject:weakPageArr[index]] direction:direction animated:YES completion:nil];
        weakSelf.currentIndex = index;
    }];
    
    // 在页面上，显示UIPageViewController对象的View
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [_navbar moveToIndex:self.currentIndex];
}

- (void)setUpBannerView {
    self.bannerView = [[BannerScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 180*Heigt_Scale)];
    self.bannerView.bannerHeight = 180*Heigt_Scale;
    //    self.bannerView.delegate = self;
//    self.homeTable.tableHeaderView = self.bannerView;
    
    self.bannerDefaultImg = [[UIImageView alloc] init];
    self.bannerDefaultImg.frame = self.bannerView.bounds;
    self.bannerDefaultImg.image = [UIImage imageNamed:@"zhanwei"];
    self.bannerDefaultImg.contentMode = UIViewContentModeScaleAspectFill;
    self.bannerDefaultImg.clipsToBounds = YES;
    //    [self.bannerView addSubview:self.bannerDefaultImg];
    
    self.bannerView.imageUrls = @[@"http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150806/kzp5acor6.jpg-w720", @"http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150717/9q1g2knxa.jpg-w720", @"http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150809/3uoh780w5.jpg-w720"];
    [self.view addSubview:self.bannerView];
}

#pragma mark - dealloc
- (void)dealloc {
    [self.viewmodel cancelAllHTTPRequest];
}


@end

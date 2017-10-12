//
//  HomeViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/25.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "HomeViewController.h"
#import "BannerScrollView.h"
#import "SliderNavBar.h"
#import "HomeCell.h"
#import "HomeViewModel.h"
#import "GuideDetailViewController.h"
#import "WKViewController.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource, RefreshTableViewDelegate> {
    SliderNavBar *_navbar;//类型滑动控件
}

@property (weak, nonatomic) IBOutlet JJRefreshTabView *homeTable;

@property (nonatomic, strong) BannerScrollView *bannerView;
@property (nonatomic, strong) UIImageView *bannerDefaultImg;//banner默认图片
@property (nonatomic, strong) HomeViewModel *viewmodel;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[HomeViewModel alloc] init];
    [self loadDataRefresh:YES];
}

- (void)loadDataRefresh:(BOOL)isRefresh {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getHomeListWithHomeID:self.homeId refresh:isRefresh success:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf.homeTable reloadData];
        if (weakSelf.viewmodel.homeList.count) {
            weakSelf.homeTable.isShowMore = YES;
        }
        
    } failture:^(NSString *error) {
        [weakSelf hideWaiting];
        [weakSelf showMassage:error];
    }];
}

#pragma mark - refresh
- (void)refreshTableViewHeader {
    [self loadDataRefresh:YES];
}

- (void)refreshTableViewFooter {
    [self loadDataRefresh:NO];
}

#pragma mark - table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewmodel.homeList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 185;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 44;
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [HomeCell myCellWithTableview:tableView];
    [cell setDataWithModel:self.viewmodel.homeList[indexPath.section]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Home *model = self.viewmodel.homeList[indexPath.section];
    
//    GuideDetailViewController *guide = [[GuideDetailViewController alloc] init];
//    guide.hidesBottomBarWhenPushed = YES;
//    guide.guideId = model.newid;
    
    WKViewController *wk = [[WKViewController alloc] init];
    wk.wkurl = model.content_url;
    wk.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:wk animated:YES];
}

#pragma mark - ui
- (void)initUIView {
    
    [self setupTable];
}

- (void)setupTable {
    self.homeTable.refreshDelegate = self;
    self.homeTable.CanRefresh = YES;
    self.homeTable.lastUpdateKey = NSStringFromClass([self class]);
    self.homeTable.isShowMore = NO;
}

- (void)setUpBannerView {
    self.bannerView = [[BannerScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 180*Heigt_Scale)];
    self.bannerView.bannerHeight = 180*Heigt_Scale;
//    self.bannerView.delegate = self;
    self.homeTable.tableHeaderView = self.bannerView;
    
    self.bannerDefaultImg = [[UIImageView alloc] init];
    self.bannerDefaultImg.frame = self.bannerView.bounds;
    self.bannerDefaultImg.image = [UIImage imageNamed:@"zhanwei"];
    self.bannerDefaultImg.contentMode = UIViewContentModeScaleAspectFill;
    self.bannerDefaultImg.clipsToBounds = YES;
//    [self.bannerView addSubview:self.bannerDefaultImg];
    
    self.bannerView.imageUrls = @[@"http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150806/kzp5acor6.jpg-w720", @"http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150717/9q1g2knxa.jpg-w720", @"http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150809/3uoh780w5.jpg-w720"];
}
//    http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150806/kzp5acor6.jpg-w720

#pragma mark - dealloc
- (void)dealloc {
    [self.viewmodel cancelAllHTTPRequest];
}

@end

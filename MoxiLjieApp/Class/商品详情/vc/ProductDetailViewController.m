//
//  ProductDetailViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/26.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "PruductDetailCell.h"
#import "ProductWebCell.h"
#import "BannerScrollView.h"
#import "ProductDetailViewModel.h"
#import "WKViewController.h"

@interface ProductDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *detailTable;

@property (nonatomic, assign) CGFloat webviewHeight;

@property (nonatomic, strong) BannerScrollView *bannerView;
@property (nonatomic, strong) UIImageView *bannerDefaultImg;//banner默认图片

@property (nonatomic, strong) ProductDetailViewModel *viewmodel;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateHeight:) name:@"webview_height" object:nil];
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[ProductDetailViewModel alloc] init];
    [self loadData];
}

- (void)loadData {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getProductDetailWithID:self.productId success:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf setBannerData];
        [weakSelf.detailTable reloadData];
        
    } failture:^(NSString *error) {
        [weakSelf hideWaiting];
        [weakSelf showMassage:error];
    }];
}

- (void)updateHeight:(NSNotification *)notification {
    [self.detailTable beginUpdates];
    
    NSDictionary *dic = notification.userInfo;
    self.webviewHeight = [[dic objectForKey:@"webheight"] floatValue];
    
    NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:1];
    [self.detailTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    [self.detailTable endUpdates];
}

#pragma mark - 方法
- (IBAction)goWebview:(UIButton *)sender {
    WKViewController *wk = [[WKViewController alloc] init];
    wk.wkurl = self.viewmodel.product.purchase_url;
    [self.navigationController pushViewController:wk animated:YES];
}

#pragma mark - table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        CGFloat height = [PruductDetailCell cellHeightWithString:self.viewmodel.product.newdescription];
        return height;
    } else {
        return self.webviewHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section) return 40;
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section) {        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, Screen_Width, 40)];
        label.text = @"   商品详情";
        label.backgroundColor = [UIColor groupTableViewBackgroundColor];
        label.textColor = FontColor;
        return label;
    } else {
        return [UIView new];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        PruductDetailCell *cell = [PruductDetailCell myCellWithTableview:tableView];
        [cell setDataWithModel:self.viewmodel.product];
        return cell;
        
    } else {
        ProductWebCell *cell = [ProductWebCell myCellWithTableview:tableView];
        [cell setProductWithModel:self.viewmodel.product];
        self.webviewHeight = cell.webviewHeight;
        return cell;
    }
}

#pragma mark - ui
- (void)initUIView {
    [self setBackButton:YES];
    [self initTitleViewWithTitle:@"商品详情"];
    [self setupHeader];
//    [self setBuyButton];
}

- (void)setupHeader {
    self.bannerView = [[BannerScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width)];
    self.bannerView.bannerHeight = Screen_Width;
    //    self.bannerView.delegate = self;
    self.detailTable.tableHeaderView = self.bannerView;
    
    self.bannerDefaultImg = [[UIImageView alloc] init];
    self.bannerDefaultImg.frame = CGRectMake(0, 0, Screen_Width, Screen_Width);
    self.bannerDefaultImg.image = PlaceholderImage;
    self.bannerDefaultImg.contentMode = UIViewContentModeScaleAspectFill;
    self.bannerDefaultImg.clipsToBounds = YES;
    [self.bannerView addSubview:self.bannerDefaultImg];
}

- (void)setBannerData {
    if (self.viewmodel.product.image_urls.count > 0) {
        //把图片地址数组赋值给banner的地址数组
        self.bannerView.imageUrls = self.viewmodel.product.image_urls;
        if (self.bannerDefaultImg) {
            [self.bannerDefaultImg removeFromSuperview];
            self.bannerDefaultImg = nil;
        }
    }
}

#pragma mark - dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"webview_height" object:nil];
}

@end

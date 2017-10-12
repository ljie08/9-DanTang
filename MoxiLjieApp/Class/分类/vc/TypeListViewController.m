//
//  TypeListViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/29.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "TypeListViewController.h"
#import "HomeCell.h"
#import "TypeListViewModel.h"
#import "GuideDetailViewController.h"
#import "WKViewController.h"

@interface TypeListViewController ()<UITableViewDelegate, UITableViewDataSource, RefreshTableViewDelegate>

@property (weak, nonatomic) IBOutlet JJRefreshTabView *typeTable;
@property (nonatomic, strong) TypeListViewModel *viewmodel;

@end

@implementation TypeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[TypeListViewModel alloc] init];
    [self loadDataRefresh:YES];
}

- (void)loadDataRefresh:(BOOL)isRefresh {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getTypeListWithRefresh:isRefresh typeID:self.type.newid success:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf.typeTable reloadData];
        if (weakSelf.viewmodel.typeList.count) {
            weakSelf.typeTable.isShowMore = YES;
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
    return self.viewmodel.typeList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 185;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [HomeCell myCellWithTableview:tableView];
    [cell setDataWithModel:self.viewmodel.typeList[indexPath.section]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Home *model = self.viewmodel.typeList[indexPath.section];
    
//    GuideDetailViewController *guide = [[GuideDetailViewController alloc] init];
//    guide.guideId = model.newid;
    
    WKViewController *wk = [[WKViewController alloc] init];
    wk.wkurl = model.content_url;
    wk.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:wk animated:YES];
}

#pragma mark - ui
- (void)initUIView {
    [self initTitleViewWithTitle:self.type.name];
    [self setBackButton:YES];
    [self setupTable];
}

- (void)setupTable {
    self.typeTable.refreshDelegate = self;
    self.typeTable.CanRefresh = YES;
    self.typeTable.lastUpdateKey = NSStringFromClass([self class]);
    self.typeTable.isShowMore = NO;
}

#pragma mark - dealloc
- (void)dealloc {
    [self.viewmodel cancelAllHTTPRequest];
}

@end

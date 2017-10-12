//
//  GuideDetailViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/26.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "GuideDetailViewController.h"
#import "GuideViewModel.h"
#import "GuideCell.h"
#import "ProductWebCell.h"

@interface GuideDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *guideTable;
@property (nonatomic, strong) GuideViewModel *viewmodel;

@property (nonatomic, assign) CGFloat webviewHeight;

@end

@implementation GuideDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateHeight:) name:@"webview_height" object:nil];
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[GuideViewModel alloc] init];
    [self loadData];
}

- (void)loadData {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getGuideDetailWithID:self.guideId success:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf.guideTable reloadData];
        
    } failture:^(NSString *error) {
        [weakSelf hideWaiting];
        [weakSelf showMassage:error];
    }];
}

- (void)updateHeight:(NSNotification *)notification {
    [self.guideTable beginUpdates];
    
    NSDictionary *dic = notification.userInfo;
    self.webviewHeight = [[dic objectForKey:@"webheight"] floatValue];
    
//    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.guideTable reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    [self.guideTable reloadData];
    [self.guideTable endUpdates];
}

#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.webviewHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductWebCell *cell = [ProductWebCell myCellWithTableview:tableView];
    [cell setGuideWithModel:self.viewmodel.guide];
    self.webviewHeight = cell.webviewHeight;
    return cell;
}

#pragma mark - ui
- (void)initUIView {
    [self initTitleViewWithTitle:@"攻略详情"];
    [self setBackButton:YES];
}

#pragma mark - dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"webview_height" object:nil];
}

@end

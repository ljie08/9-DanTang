//
//  ProductViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/25.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductCell.h"
#import "ProductDetailViewController.h"
#import "ProductViewModel.h"

@interface ProductViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, RefreshCollectionViewDelegate>

@property (nonatomic, strong) LLRefreshCollectionView *productCollection;
@property (nonatomic, strong) NSArray *treeList;

@property (nonatomic, strong) ProductViewModel *viewmodel;

@property (nonatomic, assign) BOOL hasData;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hasData = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.hasData) {
        
        [self loadDataRefresh:YES];
    }
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[ProductViewModel alloc] init];
}

- (void)loadDataRefresh:(BOOL)isRefresh {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getProductListWithRefresh:isRefresh success:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf.productCollection reloadData];
        weakSelf.hasData = YES;
        if (weakSelf.viewmodel.productList.count) {
            weakSelf.productCollection.isShowMore = YES;
        }
        
    } failture:^(NSString *error) {
        [weakSelf hideWaiting];
        weakSelf.hasData = NO;
        [weakSelf showMassage:error];
    }];
}

#pragma mark - refresh
- (void)refreshCollectionViewHeader {
    [self loadDataRefresh:YES];
}

- (void)refreshCollectionViewFooter {
    [self loadDataRefresh:NO];
}

#pragma mark - collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.treeList.count;
    return self.viewmodel.productList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(Screen_Width, 20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(Screen_Width, 20);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCell" forIndexPath:indexPath];
    [cell setDataWithModel:self.viewmodel.productList[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailViewController *detail = [[ProductDetailViewController alloc] init];
    detail.hidesBottomBarWhenPushed = YES;
    Danpin *model = self.viewmodel.productList[indexPath.row];
    detail.productId = model.newid;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - ui
- (void)initUIView {
    [self setCollectionviewLayout];
    [self initTitleViewWithTitle:@"单品"];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

//collectionview相关
- (void)setCollectionviewLayout {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    flow.minimumLineSpacing = 10;
    flow.minimumInteritemSpacing = 10;
    
    flow.itemSize = CGSizeMake((Screen_Width-40-10)/2, 165);
    
    self.productCollection = [[LLRefreshCollectionView alloc] initWithFrame:CGRectMake(20, 0, Screen_Width-40, Screen_Height-49-64) collectionViewLayout:flow];
    self.productCollection.backgroundColor = [UIColor clearColor];
    self.productCollection.delegate = self;
    self.productCollection.dataSource = self;
    
    self.productCollection.refreshCDelegate = self;
    self.productCollection.CanRefresh = YES;
    self.productCollection.isShowMore = NO;
    self.productCollection.lastUpdateKey = NSStringFromClass([self class]);
    
    self.productCollection.showsHorizontalScrollIndicator = NO;
    self.productCollection.showsVerticalScrollIndicator = NO;
    [self.productCollection registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellWithReuseIdentifier:@"ProductCell"];
    [self.view addSubview:self.productCollection];
}

#pragma mark - dealloc
- (void)dealloc {
    [self.viewmodel cancelAllHTTPRequest];
}

@end

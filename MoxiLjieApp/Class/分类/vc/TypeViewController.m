//
//  TypeViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/25.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "TypeViewController.h"
#import "TypeCell.h"
#import "TypeViewModel.h"
#import "TypeListViewController.h"
#import "ProductViewController.h"

@interface TypeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *typeCollection;
@property (nonatomic, strong) TypeViewModel *viewmodel;

@property (nonatomic, assign) BOOL hasData;

@end

@implementation TypeViewController

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
    self.viewmodel = [[TypeViewModel alloc] init];
}

- (void)loadData {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getTypeListWithSuccess:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf.typeCollection reloadData];
        weakSelf.hasData = YES;
        
    } failture:^(NSString *error) {
        [weakSelf hideWaiting];
        weakSelf.hasData = NO;
        [weakSelf showMassage:error];
    }];
}

#pragma mark - 方法
- (void)searchVC {
    
}

#pragma mark - collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.viewmodel.channels_groups.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    Channels_Groups *group = self.viewmodel.channels_groups[section];
    return group.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeCell" forIndexPath:indexPath];
    
    Channels_Groups *group = self.viewmodel.channels_groups[indexPath.section];
    [cell setDataWithModel:group.channels[indexPath.row]];
    
    return cell;
}

//header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    Channels_Groups *group = self.viewmodel.channels_groups[indexPath.section];
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, Screen_Width, 30)];
    label.backgroundColor = [UIColor whiteColor];
    label.text = group.name;
    label.textColor = FontColor;
    
    //避免每次刷新界面的时候，头视图都会加一次label
    if (view.subviews.count) {
        for (UIView *sub in view.subviews) {
            [sub removeFromSuperview];
        }
    }
    
    [view addSubview:label];
    
    return view;
}

//header的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(Screen_Width, 40);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Channels_Groups *group = self.viewmodel.channels_groups[indexPath.section];
    TypeListViewController *list = [[TypeListViewController alloc] init];
    list.type = group.channels[indexPath.row];
    list.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:list animated:YES];
}

#pragma mark - ui
- (void)initUIView {
    [self initTitleViewWithTitle:@"分类"];
    
    [self setCollectionviewLayout];
}

//collectionview相关
- (void)setCollectionviewLayout {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    
//    flow.minimumLineSpacing = 0;
//    flow.minimumInteritemSpacing = 0;
    
    flow.itemSize = CGSizeMake(75, 100);
    
    self.typeCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 0, Screen_Width-30, Screen_Height-49-64) collectionViewLayout:flow];
    self.typeCollection.backgroundColor = [UIColor clearColor];
    self.typeCollection.delegate = self;
    self.typeCollection.dataSource = self;
    self.typeCollection.showsHorizontalScrollIndicator = NO;
    self.typeCollection.showsVerticalScrollIndicator = NO;
    [self.typeCollection registerNib:[UINib nibWithNibName:@"TypeCell" bundle:nil] forCellWithReuseIdentifier:@"TypeCell"];
    [self.view addSubview:self.typeCollection];
    
    [self.typeCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}

- (void)setNav {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn setImage:[UIImage imageNamed:@"flower"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(searchVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self addNavigationWithTitle:nil leftItem:nil rightItem:rightItem titleView:nil];
}

#pragma mark - dealloc
- (void)dealloc {
    [self.viewmodel cancelAllHTTPRequest];
}


@end

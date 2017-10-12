//
//  HomeViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/28.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

- (instancetype)init {
    if (self = [super init]) {
        _homeList = [NSMutableArray array];
        _navTitleList = [NSMutableArray array];
        _navIDList = [NSMutableArray array];
        _pageSize = 10;
    }
    return self;
}

/**
 获取首页列表
 
 @param homeID 导航栏按钮id
 @param isRefresh 刷新
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getHomeListWithHomeID:(NSString *)homeID refresh:(BOOL)isRefresh success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture {
    if (isRefresh) {
        self.pageSize = 10;
    } else {
        self.pageSize += 10;
    }
    @weakSelf(self);
    [[WebManager sharedManager] getHomeWithID:homeID pageSize:self.pageSize success:^(NSArray *homeArr) {
        if (weakSelf.homeList.count) {
            [weakSelf.homeList removeAllObjects];
        }
        [weakSelf.homeList addObjectsFromArray:homeArr];

        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

/**
 获取导航栏按钮标题
 
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getHomeNavbarListWithSuccess:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture {
    @weakSelf(self);
    [[WebManager sharedManager] getHomeNavBarSuccess:^(NSArray *navbarArr) {
        if (weakSelf.navTitleList.count) {
            [weakSelf.navTitleList removeAllObjects];
        }
        if (weakSelf.navIDList.count) {
            [weakSelf.navIDList removeAllObjects];
        }
        
        for (TypeBtn *type in navbarArr) {
            [weakSelf.navTitleList addObject:type.name];
            [weakSelf.navIDList addObject:type.newid];
        }
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

@end

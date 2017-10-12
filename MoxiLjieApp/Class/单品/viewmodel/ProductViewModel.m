//
//  ProductViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/28.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "ProductViewModel.h"

@implementation ProductViewModel

- (instancetype)init {
    if (self = [super init]) {
        _productList = [NSMutableArray array];
        _pageSize = 10;
    }
    return self;
}

/**
 获取单品
 
 @param isRefresh 刷新
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getProductListWithRefresh:(BOOL)isRefresh success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture {
    if (isRefresh) {
        self.pageSize = 10;
    } else {
        self.pageSize += 10;
    }
    @weakSelf(self);
    [[WebManager sharedManager] getProductPageSize:self.pageSize success:^(NSArray *productArr) {
        if (weakSelf.productList.count) {
            [weakSelf.productList removeAllObjects];
        }
        [weakSelf.productList addObjectsFromArray:productArr];
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

@end

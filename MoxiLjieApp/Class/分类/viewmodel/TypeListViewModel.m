//
//  TypeListViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/29.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "TypeListViewModel.h"

@implementation TypeListViewModel

- (instancetype)init {
    if (self = [super init]) {
        _typeList = [NSMutableArray array];
        _pageSize = 10;
    }
    return self;
}

/**
 获取分类列表
 
 @param isRefresh 刷新
 @param typeID 分类id
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getTypeListWithRefresh:(BOOL)isRefresh typeID:(NSString *)typeID success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture {
    if (isRefresh) {
        self.pageSize = 10;
    } else {
        self.pageSize += 10;
    }
    @weakSelf(self);
    [[WebManager sharedManager] getTypeWithID:typeID pageSize:self.pageSize success:^(NSArray *typeArr) {
        if (weakSelf.typeList.count) {
            [weakSelf.typeList removeAllObjects];
        }
        [weakSelf.typeList addObjectsFromArray:typeArr];
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

@end

//
//  TypeViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/28.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "TypeViewModel.h"

@implementation TypeViewModel

- (instancetype)init {
    if (self = [super init]) {
        _channels_groups = [NSMutableArray array];
        _typeList1 = [NSMutableArray array];
        _typeList2 = [NSMutableArray array];
    }
    return self;
}

/**
 获取分类
 
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getTypeListWithSuccess:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture {
    @weakSelf(self);
    [[WebManager sharedManager] getTypeSuccess:^(NSArray *typeBtnArr) {
        if (weakSelf.typeList1.count) {
            [weakSelf.typeList1 removeAllObjects];
        }
        if (weakSelf.typeList2.count) {
            [weakSelf.typeList2 removeAllObjects];
        }
        if (weakSelf.channels_groups.count) {
            [weakSelf.channels_groups removeAllObjects];
        }
        
        [weakSelf.channels_groups addObjectsFromArray:typeBtnArr];
        
        Channels_Groups *group = typeBtnArr[0];
        [weakSelf.typeList1 addObjectsFromArray:group.channels];
        
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

@end

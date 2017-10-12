//
//  ProductDetailViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/29.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "ProductDetailViewModel.h"

@implementation ProductDetailViewModel

- (instancetype)init {
    if (self = [super init]) {
        _product = [[DanpinXiangxi alloc] init];
    }
    return self;
}

/**
 获取商品详情
 
 @param productID 商品id
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getProductDetailWithID:(NSString *)productID success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture {
    @weakSelf(self);
    [[WebManager sharedManager] getProductDetailWithID:productID success:^(DanpinXiangxi *product) {
        
        weakSelf.product = product;
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

@end

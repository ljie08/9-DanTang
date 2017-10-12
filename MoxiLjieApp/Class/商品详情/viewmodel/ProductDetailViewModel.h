//
//  ProductDetailViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/29.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface ProductDetailViewModel : BaseViewModel

@property (nonatomic, strong) DanpinXiangxi *product;

/**
 获取商品详情

 @param productID 商品id
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getProductDetailWithID:(NSString *)productID success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

@end

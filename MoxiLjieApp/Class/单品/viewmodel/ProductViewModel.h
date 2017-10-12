//
//  ProductViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/28.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface ProductViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *productList;
@property (nonatomic, assign) int pageSize;


/**
 获取单品

 @param isRefresh 刷新
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getProductListWithRefresh:(BOOL)isRefresh success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

@end

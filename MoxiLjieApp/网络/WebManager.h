//
//  WebManager.h
//  MyWeather
//
//  Created by lijie on 2017/7/27.
//  Copyright © 2017年 lijie. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

//请求成功回调block
typedef void (^requestSuccessBlock)(NSDictionary *dic);

//请求失败回调block
typedef void (^requestFailureBlock)(NSError *error);

//请求方法define
typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
} HTTPMethod;


@interface WebManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

#pragma mark - Data
/**
 获取首页列表

 @param homeID 导航栏选中的按钮
 @param pageSize 数据数量
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getHomeWithID:(NSString *)homeID pageSize:(int)pageSize success:(void(^)(NSArray *homeArr))success failure:(void(^)(NSString *errorStr))failure;


/**
 获取首页滑动导航栏按钮标题

 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getHomeNavBarSuccess:(void(^)(NSArray *navbarArr))success failure:(void(^)(NSString *errorStr))failure;

/**
 获取单品列表

 @param pageSize 数据数量
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getProductPageSize:(int)pageSize success:(void(^)(NSArray *productArr))success failure:(void(^)(NSString *errorStr))failure;

/**
 获取分类按钮

 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getTypeSuccess:(void(^)(NSArray *typeBtnArr))success failure:(void(^)(NSString *errorStr))failure;

/**
 获取分类列表

 @param typeID 分类id
 @param pageSize 数据数量
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getTypeWithID:(NSString *)typeID pageSize:(int)pageSize success:(void(^)(NSArray *typeArr))success failure:(void(^)(NSString *errorStr))failure;

/**
 获取攻略详情

 @param guideID 攻略id
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getGuideWithID:(NSString *)guideID success:(void(^)(Guide *guide))success failure:(void(^)(NSString *errorStr))failure;

/**
 获取商品详情

 @param productID 商品id
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getProductDetailWithID:(NSString *)productID success:(void(^)(DanpinXiangxi *product))success failure:(void(^)(NSString *errorStr))failure;

#pragma mark - request
- (void)requestWithMethod:(HTTPMethod)method
                 WithUrl:(NSString *)url
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailureBlock:(requestFailureBlock)failure;

@end

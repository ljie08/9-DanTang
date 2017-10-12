//
//  WebManager.m
//  MyWeather
//
//  Created by lijie on 2017/7/27.
//  Copyright © 2017年 lijie. All rights reserved.
//

#import "WebManager.h"

@implementation WebManager

+ (instancetype)sharedManager {
    static WebManager *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://httpbin.org/"]];
    });
    return manager;
}

-(instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 5;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

#pragma mark - Data
/**
 获取首页列表
 
 @param homeID 导航栏选中的按钮
 @param pageSize 数据数量
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getHomeWithID:(NSString *)homeID pageSize:(int)pageSize success:(void(^)(NSArray *homeArr))success failure:(void(^)(NSString *errorStr))failure {
    NSString *url = [NSString stringWithFormat:Home_URL, homeID, pageSize];
    
    [self requestWithMethod:GET WithUrl:url WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        NSDictionary *data = [dic objectForKey:@"data"];
        NSArray *items = [Home mj_objectArrayWithKeyValuesArray:[data objectForKey:@"items"]];
        
        success(items);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}


/**
 获取首页滑动导航栏按钮标题
 
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getHomeNavBarSuccess:(void(^)(NSArray *navbarArr))success failure:(void(^)(NSString *errorStr))failure {
    NSString *url = [NSString stringWithFormat:HomeTop_URL];
    
    [self requestWithMethod:GET WithUrl:url WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        NSDictionary *data = [dic objectForKey:@"data"];
        NSArray *channels = [TypeBtn mj_objectArrayWithKeyValuesArray:[data objectForKey:@"channels"]];
        
        success(channels);
        
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

/**
 获取单品列表
 
 @param pageSize 数据数量
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getProductPageSize:(int)pageSize success:(void(^)(NSArray *productArr))success failure:(void(^)(NSString *errorStr))failure {
    NSString *url = [NSString stringWithFormat:Product_URL, pageSize];
    
    [self requestWithMethod:GET WithUrl:url WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        NSDictionary *data = [dic objectForKey:@"data"];
        NSArray *items = [data objectForKey:@"items"];
        NSMutableArray *itemsArr = [NSMutableArray array];
        for (NSDictionary *dataDic in items) {
            Danpin *model = [Danpin mj_objectWithKeyValues:[dataDic objectForKey:@"data"]];
            [itemsArr addObject:model];
        }
        
        success(itemsArr);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

/**
 获取分类按钮
 
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getTypeSuccess:(void(^)(NSArray *typeBtnArr))success failure:(void(^)(NSString *errorStr))failure {
    NSString *url = [NSString stringWithFormat:Type_URL];
    
    [self requestWithMethod:GET WithUrl:url WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        NSDictionary *data = [dic objectForKey:@"data"];
        NSArray *groupsArr = [Channels_Groups mj_objectArrayWithKeyValuesArray:[data objectForKey:@"channel_groups"]];
        for (Channels_Groups *group in groupsArr) {
            group.channels = [TypeBtn mj_objectArrayWithKeyValuesArray:group.channels];
        }
        
        success(groupsArr);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

/**
 获取分类列表
 
 @param typeID 分类id
 @param pageSize 数据数量
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getTypeWithID:(NSString *)typeID pageSize:(int)pageSize success:(void(^)(NSArray *typeArr))success failure:(void(^)(NSString *errorStr))failure {
    NSString *url = [NSString stringWithFormat:TypeDetail_URL, typeID, pageSize];
    
    [self requestWithMethod:GET WithUrl:url WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        NSDictionary *data = [dic objectForKey:@"data"];
        NSArray *items = [Home mj_objectArrayWithKeyValuesArray:[data objectForKey:@"items"]];
        
        success(items);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

/**
 获取攻略详情
 
 @param guideID 攻略id
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getGuideWithID:(NSString *)guideID success:(void(^)(Guide *guide))success failure:(void(^)(NSString *errorStr))failure {
    NSString *url = [NSString stringWithFormat:Guide_URL, guideID];
    
    [self requestWithMethod:GET WithUrl:url WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        
        Guide *model = [Guide mj_objectWithKeyValues:[dic objectForKey:@"data"]];
        success(model);
        
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

/**
 获取商品详情
 
 @param productID 商品id
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getProductDetailWithID:(NSString *)productID success:(void(^)(DanpinXiangxi *product))success failure:(void(^)(NSString *errorStr))failure {
    NSString *url = [NSString stringWithFormat:ProductDetail_URL, productID];
    
    [self requestWithMethod:GET WithUrl:url WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {

        DanpinXiangxi *model = [DanpinXiangxi mj_objectWithKeyValues:[dic objectForKey:@"data"]];
        success(model);
        
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

#pragma mark - request
- (void)requestWithMethod:(HTTPMethod)method
                  WithUrl:(NSString *)url
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
         WithFailureBlock:(requestFailureBlock)failure {
    
    NSLog(@"url --> %@", url);
    
    switch (method) {
        case GET:{
            [self GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"JSON: %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);

                failure(error);
            }];
            break;
        }
        case POST:{
            [self POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"JSON: %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);

                failure(error);
            }];
            break;
        }
        default:
            break;
    }
}

@end

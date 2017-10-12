//
//  HomeViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/28.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface HomeViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *homeList;
@property (nonatomic, assign) int pageSize;

@property (nonatomic, strong) NSMutableArray *navTitleList;
@property (nonatomic, strong) NSMutableArray *navIDList;


/**
 获取首页列表

 @param homeID 导航栏按钮id
 @param isRefresh 刷新
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getHomeListWithHomeID:(NSString *)homeID refresh:(BOOL)isRefresh success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;


/**
 获取导航栏按钮标题

 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getHomeNavbarListWithSuccess:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

@end

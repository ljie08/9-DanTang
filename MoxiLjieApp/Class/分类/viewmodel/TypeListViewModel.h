//
//  TypeListViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/29.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface TypeListViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *typeList;
@property (nonatomic, assign) int pageSize;


/**
 获取分类列表

 @param isRefresh 刷新
 @param typeID 分类id
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getTypeListWithRefresh:(BOOL)isRefresh typeID:(NSString *)typeID success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

@end

//
//  TypeViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/28.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface TypeViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *channels_groups;
@property (nonatomic, strong) NSMutableArray *typeList1;
@property (nonatomic, strong) NSMutableArray *typeList2;

/**
 获取分类

 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getTypeListWithSuccess:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

@end

//
//  GuideViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/29.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "GuideViewModel.h"

@implementation GuideViewModel

- (instancetype)init {
    if (self = [super init]) {
        _guide = [[Guide alloc] init];
    }
    return self;
}

/**
 获取攻略详情
 
 @param guideID 攻略id
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getGuideDetailWithID:(NSString *)guideID success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture {
    @weakSelf(self);
    [[WebManager sharedManager] getGuideWithID:guideID success:^(Guide *guide) {
        
        NSLog(@"shujv = = = %@",guide);
        
        weakSelf.guide = guide;
        success(YES);
        
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

@end

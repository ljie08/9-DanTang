//
//  GuideViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/29.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface GuideViewModel : BaseViewModel

@property (nonatomic, strong) Guide *guide;

/**
 获取攻略详情

 @param guideID 攻略id
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getGuideDetailWithID:(NSString *)guideID success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

@end

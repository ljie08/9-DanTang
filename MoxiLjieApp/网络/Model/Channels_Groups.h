//
//  Channels_Groups.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/29.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channels_Groups : NSObject

@property (nonatomic, copy) NSString *newid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray<TypeBtn*> *channels;

@end

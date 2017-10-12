//
//  UrlDefine.h
//  MyWeather
//
//  Created by lijie on 2017/7/27.
//  Copyright © 2017年 lijie. All rights reserved.
//

#ifndef UrlDefine_h
#define UrlDefine_h

//主页 默认id是4，精选
//channels/4/items limit=10
#define Home_URL @"http://api.dantangapp.com/v1/channels/%@/items?gender=1&generation=1&limit=%d&offset=0"

//navBar
#define HomeTop_URL @"http://api.dantangapp.com/v2/channels/preset?gender=1&generation=1"

//单品 limit=10
#define Product_URL @"http://api.dantangapp.com/v2/items?gender=1&generation=1&limit=%d&offset=0"

//分类
#define Type_URL @"http://api.dantangapp.com/v1/channel_groups/all?"

//搜索
//keyword=....&limit...
#define Search_URL @"http://api.dantangapp.com/v1/search/item?keyword=%E6%88%92%E6%8C%87&limit=20&offset=0&sort="

//分类列表
//channels/12/items limit=10
#define TypeDetail_URL @"http://api.dantangapp.com/v1/channels/%@/items?limit=%d&offset=0"

//攻略详情
//posts/2792
#define Guide_URL @"http://api.dantangapp.com/v1/posts/%@?"

//商品详情
//items/1355
#define ProductDetail_URL @"http://api.dantangapp.com/v2/items/%@"

#endif /* UrlDefine_h */

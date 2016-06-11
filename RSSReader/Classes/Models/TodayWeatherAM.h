//
//  TodayWeatherAM.h
//  RSSReader
//
//  Created by JY on 2016/6/11.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <Realm/Realm.h>

@interface TodayWeatherAM : RLMObject
@property (nonatomic, strong) NSString *weatherAM;
@property (nonatomic, strong) NSString *tempMaxAM;
@property (nonatomic, strong) NSString *tempMinAM;
@end

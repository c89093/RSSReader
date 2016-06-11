//
//  TodayWeather.h
//  RSSReader
//
//  Created by JY on 2016/6/11.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <Realm/Realm.h>
#import "TodayWeatherAM.h"
#import "TodayWeatherPM.h"

RLM_ARRAY_TYPE(TodayWeatherAM)
RLM_ARRAY_TYPE(TodayWeatherPM)
@interface TodayWeather : RLMObject
@property RLMArray<TodayWeatherAM *><TodayWeatherAM> *todayWeatherAM;
@property RLMArray<TodayWeatherPM *><TodayWeatherPM> *todayWeatherPM;
@property (nonatomic, strong)  NSString *pubDate;
@end

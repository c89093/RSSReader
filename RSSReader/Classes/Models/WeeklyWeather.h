//
//  WeeklyWeather.h
//  RSSReader
//
//  Created by JY on 2016/6/11.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <Realm/Realm.h>
#import "WeeklyWeatherAM.h"
#import "WeeklyWeatherPM.h"

RLM_ARRAY_TYPE(WeeklyWeatherAM)
RLM_ARRAY_TYPE(WeeklyWeatherPM)
@interface WeeklyWeather : RLMObject
@property RLMArray<WeeklyWeatherAM *><WeeklyWeatherAM> *weeklyWeatherAM;
@property RLMArray<WeeklyWeatherPM *><WeeklyWeatherPM> *weeklyWeatherPM;
@property (nonatomic, strong) NSString *pubDate;
@end

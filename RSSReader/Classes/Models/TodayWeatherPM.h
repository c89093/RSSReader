//
//  TodayWeatherPM.h
//  RSSReader
//
//  Created by JY on 2016/6/11.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <Realm/Realm.h>

@interface TodayWeatherPM : RLMObject
@property (nonatomic, strong) NSString *weatherPM;
@property (nonatomic, strong) NSString *tempMaxPM;
@property (nonatomic, strong) NSString *tempMinPM;
@end

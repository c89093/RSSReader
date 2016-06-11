//
//  MainView.h
//  RSSReader
//
//  Created by JY on 2016/6/6.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherView.h"
#import "SelectView.h"
#import "DailySentenceView.h"
#import "WeeklyWeatherView.h"

@interface MainView : UIView
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) WeatherView *weatherView;
@property (nonatomic, strong) SelectView *selectView;
@property (nonatomic, strong) DailySentenceView *dailySentenceView;
@property (nonatomic, strong) WeeklyWeatherView *weeklyWeatherView;
@end

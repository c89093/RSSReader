//
//  MainView.m
//  RSSReader
//
//  Created by JY on 2016/6/6.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
        self.titleView.backgroundColor = [UIColor blackColor];
        [self addSubview:self.titleView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleView.frame.size.width / 2 - 50, self.titleView.frame.size.height - 34, 100, 24)];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = 1;
        self.titleLabel.text = @"台中市";
        [self.titleView addSubview:self.titleLabel];
        
        self.weatherView = [[WeatherView alloc] initWithFrame:CGRectMake(0, 64, self.frame.size.width, 100)];
        [self addSubview:self.weatherView];
        
        self.selectView = [[SelectView alloc] initWithFrame:CGRectMake(0, self.weatherView.frame.size.height + 64, self.frame.size.width, 40)];
        [self addSubview:self.selectView];
        
        self.dailySentenceView = [[DailySentenceView alloc] initWithFrame:CGRectMake(0, self.weatherView.frame.size.height + self.selectView.frame.size.height + 64, self.frame.size.width, self.frame.size.height - self.weatherView.frame.size.height - self.selectView.frame.size.height - 64)];
        self.dailySentenceView.hidden = NO;
        [self addSubview:self.dailySentenceView];
        
        self.weeklyWeatherView = [[WeeklyWeatherView alloc] initWithFrame:CGRectMake(0, self.weatherView.frame.size.height + self.selectView.frame.size.height + 64, self.frame.size.width, self.frame.size.height - self.weatherView.frame.size.height - self.selectView.frame.size.height - 64)];
        self.weeklyWeatherView.hidden = YES;
        [self addSubview:self.weeklyWeatherView];
    }
    return self;
}


@end

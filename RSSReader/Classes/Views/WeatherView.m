//
//  WeatherView.m
//  RSSReader
//
//  Created by JY on 2016/6/11.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "WeatherView.h"

@implementation WeatherView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //changeTimeButton
        self.changeTimeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.changeTimeButton.frame = CGRectMake(self.frame.size.width / 4 - 65, self.frame.size.height /2 - 40, 130, 80);
        self.changeTimeButton.showsTouchWhenHighlighted = YES;
        self.changeTimeButton.tag = 0;
        [self.changeTimeButton setTitle:@"白天" forState:UIControlStateNormal];
        [self.changeTimeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.changeTimeButton.titleLabel.font = [UIFont systemFontOfSize:50];
        [self addSubview:self.changeTimeButton];
        
        //tempLabel
        self.tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 4 * 3 - 50, self.frame.size.height /2 - 30, 100, 40)];
        self.tempLabel.text = @"??-??℃";
        self.tempLabel.font = [UIFont systemFontOfSize:25];
        self.tempLabel.textAlignment = NSTextAlignmentCenter;
        self.tempLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.tempLabel];
        
        //weatherLabel
        self.weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 4 * 3 - 60, self.frame.size.height /2, 120, 30)];
        self.weatherLabel.text = @"???????????";
        self.weatherLabel.font = [UIFont systemFontOfSize:30];
        self.weatherLabel.textAlignment = NSTextAlignmentCenter;
        self.weatherLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.weatherLabel];

        //lineView
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 1, 0, 2, self.frame.size.height)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
    }
    return self;
}

@end

//
//  DailySentenceView.m
//  RSSReader
//
//  Created by JY on 2016/6/11.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "DailySentenceView.h"

@implementation DailySentenceView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //dailySentenceLabel
        self.dailySentenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 140, self.frame.size.height /2 - 150, 280, 200)];
        self.dailySentenceLabel.font = [UIFont systemFontOfSize:20];
        self.dailySentenceLabel.text = @"已經完成的小事勝過計劃完成的大事。Small deeds done are better than great deeds planned.";
        self.dailySentenceLabel.numberOfLines = 0;
        [self.dailySentenceLabel sizeToFit];
        [self addSubview:self.dailySentenceLabel];
        
        //dailyDateLabel
        self.dailyDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 100, self.frame.size.height - 40, 80, 30)];
        self.dailyDateLabel.font = [UIFont systemFontOfSize:15];
        self.dailyDateLabel.text = @"20160611";
        self.dailyDateLabel.textAlignment = 2;
        self.dailyDateLabel.numberOfLines = 0;
        [self addSubview:self.dailyDateLabel];

        //dailyAuthorLabel
        self.dailyAuthorLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 290, self.frame.size.height - 60, 300, 50)];
        self.dailyAuthorLabel.font = [UIFont systemFontOfSize:15];
        self.dailyAuthorLabel.text = @"美國電視主持人 馬歇爾  Peter Marshall";
        self.dailyAuthorLabel.textAlignment = 2;
        self.dailyAuthorLabel.numberOfLines = 0;
        [self.dailyAuthorLabel sizeToFit];
        [self addSubview:self.dailyAuthorLabel];
    }
    return self;
}

@end

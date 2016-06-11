//
//  SelectView.m
//  RSSReader
//
//  Created by JY on 2016/6/11.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "SelectView.h"
#import "UIColor+Helper.h"

@implementation SelectView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        //toplineView
        UIView *toplineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 2)];
        toplineView.backgroundColor = [UIColor grayColor];
        [self addSubview:toplineView];
        
        //BottomlineView
        UIView *bottomlineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 2, self.frame.size.width, 2)];
        bottomlineView.backgroundColor = [UIColor grayColor];
        [self addSubview:bottomlineView];
        
        //todayButton
        self.todayButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.todayButton.frame = CGRectMake(self.frame.size.width / 4 - 75, self.frame.size.height /2 - 15, 150, 30);
        self.todayButton.showsTouchWhenHighlighted = YES;
        [self.todayButton setTitle:@"今日" forState:UIControlStateNormal];
        [self.todayButton setTitleColor:[UIColor colorFromHexString:@"#2DD895"] forState:UIControlStateNormal];
        self.todayButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.todayButton];
        
        //weeklyButton
        self.weeklyButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.weeklyButton.frame = CGRectMake(self.frame.size.width / 4 * 3 - 75, self.frame.size.height /2 - 15, 150, 30);
        self.weeklyButton.showsTouchWhenHighlighted = YES;
        [self.weeklyButton setTitle:@"未來一週" forState:UIControlStateNormal];
        [self.weeklyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.weeklyButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.weeklyButton];
    }
    return self;
}

@end

//
//  MainController.m
//  RSSReader
//
//  Created by JY on 2016/6/6.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "MainController.h"
#import "MainView.h"
#import <Realm/Realm.h>
#import "TodayWeather.h"
#import "WeeklyWeather.h"

@interface MainController ()
@property (nonatomic, strong) MainView *mainView;
@property (nonatomic, strong) MWFeedParser *feedParser;
@property (nonatomic, strong) RLMRealm *realm;
@property (nonatomic, strong) TodayWeather *todayWeather;
@property (nonatomic, strong) TodayWeatherAM *todayWeatherAM;
@property (nonatomic, strong) TodayWeatherPM *todayWeatherPM;
@property (nonatomic, strong) WeeklyWeather *weeklyWeather;
@property (nonatomic, strong) WeeklyWeatherAM *weeklyWeatherAM;
@property (nonatomic, strong) WeeklyWeatherPM *weeklyWeatherPM;
@property (nonatomic, strong) NSString *updateDate;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainView = [[UINib nibWithNibName:@"MainView" bundle:nil] instantiateWithOwner:nil options:nil][0];
    self.mainView.frame = self.view.frame;
    self.view = self.mainView;
    
    self.parsedItems = [[NSMutableArray alloc] init];

    NSURL *feedURL = [NSURL URLWithString:@"http://www.cwb.gov.tw/rss/forecast/36_08.xml"];
    self.feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
    self.feedParser.delegate = self;
    self.feedParser.feedParseType = ParseTypeFull;
    self.feedParser.connectionType = ConnectionTypeSynchronously;
    [self.feedParser parse];
}

- (void)feedParserDidStart:(MWFeedParser *)parser {
    NSLog(@"parsering");
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    if (item.title) {
        [self.parsedItems addObject:item.title];
    }

    if (item.summary) {
        [self.parsedItems addObject:item.summary];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *updateDate = [dateFormatter stringFromDate:item.date];
    self.updateDate = updateDate;
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
    NSLog(@"finish");
    //建立資料庫
    self.realm = [RLMRealm defaultRealm];
    self.todayWeather = [[TodayWeather alloc] init];
    self.todayWeatherAM = [[TodayWeatherAM alloc] init];
    self.todayWeatherPM = [[TodayWeatherPM alloc] init];
    self.todayWeather.pubDate = self.updateDate;
    
    self.weeklyWeather = [[WeeklyWeather alloc] init];
    self.weeklyWeatherAM = [[WeeklyWeatherAM alloc] init];
    self.weeklyWeatherPM = [[WeeklyWeatherPM alloc] init];
    self.weeklyWeather.pubDate = self.updateDate;

    //TodayWeatherAM 2:天氣 4:最低溫 6:最高溫 8:降雨機率
    NSLog(@"Today : %@",  [self.parsedItems objectAtIndex:0]);
    NSArray *todayWeatherAM;
    todayWeatherAM =  [[self.parsedItems objectAtIndex:0] componentsSeparatedByString:@" "];
    [self.todayWeatherAM setValue:todayWeatherAM[2]  forKey:@"weatherAM"];
    [self.todayWeatherAM setValue:todayWeatherAM[4] forKey:@"tempMinAM"];
    [self.todayWeatherAM setValue:todayWeatherAM[6] forKey:@"tempMaxAM"];
    [self.todayWeather.todayWeatherAM addObject:self.todayWeatherAM];

    //TodayWeatherPM 1:天氣 3:最低溫 5:最高溫 7:降雨機率
    NSArray *todayAndTomorrow;
    todayAndTomorrow = [[self.parsedItems objectAtIndex:1] componentsSeparatedByString:@"<br> "];
    NSArray *todayWeatherPM;
    todayWeatherPM = [[todayAndTomorrow objectAtIndex:0] componentsSeparatedByString:@" "];
    [self.todayWeatherPM setValue:todayWeatherPM[1]  forKey:@"weatherPM"];
    [self.todayWeatherPM setValue:todayWeatherPM[3] forKey:@"tempMinPM"];
    [self.todayWeatherPM setValue:todayWeatherPM[5] forKey:@"tempMaxPM"];
    [self.todayWeather.todayWeatherPM addObject:self.todayWeatherPM];

    //Weekly weather
    NSArray *weeklyWeather;
    weeklyWeather = [[self.parsedItems objectAtIndex:3] componentsSeparatedByString:@"<BR>"];
    
    //Weekly weatherAM

    for (int i = 0; i < 14; i++) {
        WeeklyWeatherAM *am = [[WeeklyWeatherAM alloc] init];
        [am setValue:[weeklyWeather objectAtIndex:i] forKey:@"weeklyWeatherAMinfo"];
        [self.weeklyWeather.weeklyWeatherAM addObject:am];
        i++;
    }
    
    //Weekly weatherPM
    for (int i = 1; i < 14; i++) {
        WeeklyWeatherPM *pm = [[WeeklyWeatherPM alloc] init];
        [pm setValue:[weeklyWeather objectAtIndex:i] forKey:@"weeklyWeatherPMinfo"];
        [self.weeklyWeather.weeklyWeatherPM addObject:pm];
        i++;
    }
    
    //寫入資料庫
    [self.realm beginWriteTransaction];
    [TodayWeather createOrUpdateInRealm:self.realm withValue:self.todayWeather];
    [WeeklyWeather createOrUpdateInRealm:self.realm withValue:self.weeklyWeather];
    [self.realm commitWriteTransaction];
    
    NSLog(@"primaryKey : %@", self.updateDate);
    NSLog(@"today : %@", [TodayWeather allObjects]);
    NSLog(@"week : %@", [WeeklyWeather allObjects]);
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    
}

@end

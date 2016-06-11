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
#import "UIColor+Helper.h"

@interface MainController ()
@property (nonatomic, strong) MainView *mainView;
@property (nonatomic, strong) MWFeedParser *feedParser;
@property (nonatomic, strong) NSMutableArray *parsedItems;
@property (nonatomic, strong) RLMRealm *realm;
@property (nonatomic, strong) TodayWeather *todayWeather;
@property (nonatomic, strong) TodayWeatherAM *todayWeatherAM;
@property (nonatomic, strong) TodayWeatherPM *todayWeatherPM;
@property (nonatomic, strong) WeeklyWeather *weeklyWeather;
@property (nonatomic, strong) WeeklyWeatherAM *weeklyWeatherAM;
@property (nonatomic, strong) WeeklyWeatherPM *weeklyWeatherPM;
@property (nonatomic, strong) NSString *updateDate;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) NSMutableArray *week;
@property (nonatomic, strong) NSMutableArray *weekAM;
@property (nonatomic, strong) NSMutableArray *weekPM;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainView = [[MainView alloc] initWithFrame:self.view.frame];
    self.view = self.mainView;
    
    //default set
    self.mainView.weatherView.tempLabel.text = [NSString stringWithFormat:@"%@-%@℃", [[[TodayWeather allObjects][0] valueForKey:@"todayWeatherAM"][0] valueForKey:@"tempMinAM"], [[[TodayWeather allObjects][0] valueForKey:@"todayWeatherAM"][0] valueForKey:@"tempMaxAM"]];
    self.mainView.weatherView.weatherLabel.text = [NSString stringWithFormat:@"%@", [[[TodayWeather allObjects][0] valueForKey:@"todayWeatherAM"][0] valueForKey:@"weatherAM"]];

    self.week = [[NSMutableArray alloc] init];
    self.weekAM = [[NSMutableArray alloc] init];
    self.weekPM = [[NSMutableArray alloc] init];
    
    self.mainView.weeklyWeatherView.delegate = self;
    self.mainView.weeklyWeatherView.dataSource = self;
    
    self.parsedItems = [[NSMutableArray alloc] init];
    NSURL *feedURL = [NSURL URLWithString:@"http://www.cwb.gov.tw/rss/forecast/36_08.xml"];
    self.feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
    self.feedParser.delegate = self;
    self.feedParser.feedParseType = ParseTypeFull;
    self.feedParser.connectionType = ConnectionTypeSynchronously;
    [self.feedParser parse];
    
    [self.mainView.weatherView.changeTimeButton addTarget:self action:@selector(changeTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.selectView.todayButton addTarget:self action:@selector(todayButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.selectView.weeklyButton addTarget:self action:@selector(weeklyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)todayButtonAction:(UIButton *)sender {
    [self.mainView.selectView.todayButton setTitleColor:[UIColor colorFromHexString:@"#2DD895"] forState:UIControlStateNormal];
    [self.mainView.selectView.weeklyButton setTitleColor:[UIColor colorFromHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    self.mainView.dailySentenceView.hidden = NO;
    self.mainView.weeklyWeatherView.hidden = YES;
}

- (void)weeklyButtonAction:(UIButton *)sender {
    [self.mainView.selectView.weeklyButton setTitleColor:[UIColor colorFromHexString:@"#2DD895"] forState:UIControlStateNormal];
    [self.mainView.selectView.todayButton setTitleColor:[UIColor colorFromHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    self.mainView.dailySentenceView.hidden = YES;
    self.mainView.weeklyWeatherView.hidden = NO;
}

- (void)changeTimeAction:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            //白天 -> 晚上
            [sender setTitle:@"晚上" forState:UIControlStateNormal];
            self.mainView.weatherView.tempLabel.text = [NSString stringWithFormat:@"%@-%@℃", [[[TodayWeather allObjects][0] valueForKey:@"todayWeatherPM"][0] valueForKey:@"tempMinPM"], [[[TodayWeather allObjects][0] valueForKey:@"todayWeatherPM"][0] valueForKey:@"tempMaxPM"]];
            self.mainView.weatherView.weatherLabel.text = [NSString stringWithFormat:@"%@", [[[TodayWeather allObjects][0] valueForKey:@"todayWeatherPM"][0] valueForKey:@"weatherPM"]];
            self.week = self.weekPM;
            [self.mainView.weeklyWeatherView reloadData];
            sender.tag = 1;
            break;
        case 1:
             //晚上 -> 白天
            [sender setTitle:@"白天" forState:UIControlStateNormal];
            self.mainView.weatherView.tempLabel.text = [NSString stringWithFormat:@"%@-%@℃", [[[TodayWeather allObjects][0] valueForKey:@"todayWeatherAM"][0] valueForKey:@"tempMinAM"], [[[TodayWeather allObjects][0] valueForKey:@"todayWeatherAM"][0] valueForKey:@"tempMaxAM"]];
            self.mainView.weatherView.weatherLabel.text = [NSString stringWithFormat:@"%@", [[[TodayWeather allObjects][0] valueForKey:@"todayWeatherAM"][0] valueForKey:@"weatherAM"]];
            self.week = self.weekAM;
            [self.mainView.weeklyWeatherView reloadData];
            sender.tag = 0;
            break;
    }
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
    
    self.weekAM = [[[WeeklyWeather allObjects][0] valueForKey:@"weeklyWeatherAM"] valueForKey:@"weeklyWeatherAMinfo"];
    self.weekPM = [[[WeeklyWeather allObjects][0] valueForKey:@"weeklyWeatherPM"] valueForKey:@"weeklyWeatherPMinfo"];
    self.week = self.weekAM;
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.week count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.text = [self.week objectAtIndex:row];

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.week removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end

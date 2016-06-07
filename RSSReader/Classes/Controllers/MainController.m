//
//  MainController.m
//  RSSReader
//
//  Created by JY on 2016/6/6.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "MainController.h"
#import "MainView.h"

@interface MainController ()
@property (nonatomic, strong) MainView *mainView;
@property (nonatomic, strong) MWFeedParser *feedParser;

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
    NSLog(@"item.title: %@", item.title);
    NSLog(@"item.summary: %@", item.summary);
    
    if (item.title) {
        [self.parsedItems addObject:item.title];
    }

    if (item.summary) {
        [self.parsedItems addObject:item.summary];
    }
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
    NSLog(@"finish");
    NSLog(@"%@",  [self.parsedItems objectAtIndex:0]);
    NSLog(@"%@",  [self.parsedItems objectAtIndex:1]);
    NSLog(@"%@",  [self.parsedItems objectAtIndex:2]);
    NSLog(@"%@",  [self.parsedItems objectAtIndex:3]);
    
    NSArray *array;
    
    array = [[self.parsedItems objectAtIndex:3] componentsSeparatedByString:@"<BR>"];
    
    for (NSString *string in array) {
        NSLog(@"%@", string);
    }
    
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    
}

@end

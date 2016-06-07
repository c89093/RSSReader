//
//  MainController.h
//  RSSReader
//
//  Created by JY on 2016/6/6.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"

@interface MainController : UIViewController<MWFeedParserDelegate>

@property (nonatomic, strong) NSMutableArray *parsedItems;

@end

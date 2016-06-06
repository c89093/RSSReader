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
@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainView = [[UINib nibWithNibName:@"MainView" bundle:nil] instantiateWithOwner:nil options:nil][0];
    self.mainView.frame = self.view.frame;
    self.view = self.mainView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

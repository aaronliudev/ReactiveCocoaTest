//
//  ALHomePageViewModel.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/19.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALHomePageViewModel.h"

@interface ALHomePageViewModel ()

@property (nonatomic, strong, readwrite) ALNormalViewModel *normalViewModel;
@property (nonatomic, strong, readwrite) ALSickViewModel *sickViewModel;
@property (nonatomic, strong, readwrite) ALTopicViewModel *topicViewModel;
@property (nonatomic, strong, readwrite) ALMessageViewModel *messageViewModel;
@property (nonatomic, strong, readwrite) ALMainViewModel *mainViewModel;

@end

@implementation ALHomePageViewModel

- (void)configViewModelHook
{
    _normalViewModel = [[ALNormalViewModel alloc] initWithServices:self.services];
    _sickViewModel = [[ALSickViewModel alloc] initWithServices:self.services];
    _topicViewModel = [[ALTopicViewModel alloc] initWithServices:self.services];
    _messageViewModel = [[ALMessageViewModel alloc] initWithServices:self.services];
    _mainViewModel = [[ALMainViewModel alloc] initWithServices:self.services];
}

@end

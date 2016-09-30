//
//  ALHomePageViewModel.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/19.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALBaseModel.h"
#import "ALNormalViewModel.h"
#import "ALSickViewModel.h"
#import "ALTopicViewModel.h"
#import "ALMessageViewModel.h"
#import "ALMainViewModel.h"

@interface ALHomePageViewModel : ALBaseModel

@property (nonatomic, strong, readonly) ALNormalViewModel *normalViewModel;
@property (nonatomic, strong, readonly) ALSickViewModel *sickViewModel;
@property (nonatomic, strong, readonly) ALTopicViewModel *topicViewModel;
@property (nonatomic, strong, readonly) ALMessageViewModel *messageViewModel;
@property (nonatomic, strong, readonly) ALMainViewModel *mainViewModel;

@end

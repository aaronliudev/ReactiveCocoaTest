//
//  ALTopicViewModel.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/22.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALTopicViewModel.h"

@interface ALTopicViewModel ()

@property (nonatomic, copy) NSArray *arrays;

@end

@implementation ALTopicViewModel


- (void)configViewModelHook
{
    [super configViewModelHook];
    
    NSArray *newarray = @[ @"1", @"2", @"3", @"4", @"5"];

    
    
//     RAC(self, arrays)= [newarray.rac_sequence takeUntilBlock:^BOOL(id x) {
//        
//        return [x integerValue] > 3;
//        
//    }].array;
    
}

@end

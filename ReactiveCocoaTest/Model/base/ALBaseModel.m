//
//  ALBaseModel.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/9.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALBaseModel.h"

@interface ALBaseModel ()

@property (nonatomic, strong) id<ALModelServices> services;
@property (nonatomic, strong) RACSubject *willAppearSignal;
@property (nonatomic, strong) RACSubject *willDidDisappearSignal;

@end

@implementation ALBaseModel

- (instancetype)initWithServices:(id<ALModelServices>)services
{
    self = [super init];
    if (self) {
        _services = services;
        [self configViewModelHook];
    }
    return self;
}

- (RACSubject *)willAppearSignal
{
    if (!_willAppearSignal) {
        _willAppearSignal = [[RACSubject alloc] init];
    }
    return _willAppearSignal;
}

- (RACSubject *)willDidDisappearSignal
{
    if (!_willDidDisappearSignal) _willDidDisappearSignal = [[RACSubject alloc] init];
    return _willDidDisappearSignal;
}

- (void)configViewModelHook
{
    
}

@end

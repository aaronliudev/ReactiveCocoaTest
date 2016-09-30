//
//  ALBaseModel.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/9.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ALModelServices.h"

@protocol ALModelServices;

@interface ALBaseModel : NSObject

- (instancetype)initWithServices:(id<ALModelServices>)services;

@property (nonatomic, strong, readonly) id<ALModelServices> services;

@property (nonatomic, strong, readonly) RACSubject *willAppearSignal;
@property (nonatomic, strong, readonly) RACSubject *willDidDisappearSignal;

- (void)configViewModelHook;

@end

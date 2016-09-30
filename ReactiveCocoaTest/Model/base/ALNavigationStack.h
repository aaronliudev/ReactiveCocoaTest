//
//  ALNavigationStack.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/18.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALModelProtrocl.h"

@protocol ALModelServices;

@interface ALNavigationStack : NSObject

- (instancetype)initWith:(id<ALModelServices>)services;

- (void)pushNavigationController:(UINavigationController *)navc;
- (UINavigationController *)popNavigationController;
- (UINavigationController *)topNavigationController;

@end

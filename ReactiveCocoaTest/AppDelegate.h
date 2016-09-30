//
//  AppDelegate.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/8/31.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALNavigationStack.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong, readonly) ALNavigationStack *navigationStack;

@end


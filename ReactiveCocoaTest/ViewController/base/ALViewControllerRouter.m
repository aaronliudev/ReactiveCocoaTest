//
//  ALViewControllerRouter.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/18.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALViewControllerRouter.h"

@interface ALViewControllerRouter ()

/// viewModel 到 ViewController的映射
@property (nonatomic, strong) NSDictionary *viewControllersDict;

@end

@implementation ALViewControllerRouter

+ (instancetype)shareRouter
{
    static ALViewControllerRouter *router = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[ALViewControllerRouter alloc] init];
    });
    return router;
}

- (ALBaseViewController *)viewControllerForModel:(ALBaseModel *)viewModel
{
    NSString *modelStr = NSStringFromClass([viewModel class]);
    NSString *controllerStr = [self.viewControllersDict objectForKey:modelStr];
    return [[NSClassFromString(controllerStr) alloc] initWithModel:viewModel];
}

- (NSDictionary *)viewControllersDict
{
    return @{ @"ALLoginViewModel" : @"ALLoginViewController",
              @"ALHomePageViewModel" : @"ALHomePageViewController" };
}

@end

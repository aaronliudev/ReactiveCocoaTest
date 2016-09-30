//
//  ALNavigationStack.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/18.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALNavigationStack.h"

@interface ALNavigationStack ()

@property (nonatomic, strong) id<ALModelServices> services;
@property (nonatomic, strong) NSMutableArray *navigationControllers;

@end

@implementation ALNavigationStack

- (instancetype)initWith:(id<ALModelServices>)services
{
    self = [super init];
    if (self) {
        _services = services;
        _navigationControllers = [NSMutableArray array];
        [self regiterNavigationControllerHook];
    }
    return self;
}

- (void)pushNavigationController:(UINavigationController *)navc
{
    if ([_navigationControllers containsObject:navc]) {
        return;
    }
    if (![navc isKindOfClass:[UINavigationController class]]) {
        return;
    }
    [_navigationControllers addObject:navc];
}

- (UINavigationController *)popNavigationController
{
    UINavigationController *popvc = [self topNavigationController];
    [_navigationControllers removeLastObject];
    return popvc;
}
- (UINavigationController *)topNavigationController
{
    return _navigationControllers.lastObject;
}

- (void)clearNavigationControllers
{
    [_navigationControllers removeAllObjects];
}

- (void)regiterNavigationControllerHook
{
    @weakify(self);
    [[(NSObject *)self.services rac_signalForSelector:@selector(pushViewModel:animated:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        ALBaseViewController *vc = [[ALViewControllerRouter shareRouter] viewControllerForModel:tuple.first];
        [[self topNavigationController] pushViewController:vc animated:[tuple.second boolValue]];
    }];
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(popViewModelAnimated:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [[self topNavigationController] popViewControllerAnimated:[tuple.second boolValue]];
    }];
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(popToRootViewModelAnimated:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [[self topNavigationController] popToRootViewControllerAnimated:[tuple.first boolValue]];
    }];
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(presentViewModel:animated:completion:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        ALBaseViewController *vc = [[ALViewControllerRouter shareRouter] viewControllerForModel:tuple.first];
        if (![vc isKindOfClass:[UINavigationController class]]) {
            vc = [[UINavigationController alloc] initWithRootViewController:vc];
        }
        
        [self pushNavigationController:vc];
        [[self topNavigationController] presentViewController:vc animated:[tuple.second boolValue] completion:tuple.third];
    }];
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(dismissViewModelAnimated:completion:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [self popNavigationController];
        [[self topNavigationController] dismissViewControllerAnimated:[tuple.first boolValue] completion:tuple.second];
    }];
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(resetRootViewModel:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [self clearNavigationControllers];
        ALBaseViewController *vc = [[ALViewControllerRouter shareRouter] viewControllerForModel:tuple.first];
        if (![vc isKindOfClass:[UINavigationController class]] &&
            ![vc isKindOfClass:[UITabBarController class]]) {
            vc = [[UINavigationController alloc] initWithRootViewController:vc];
            [self pushNavigationController:(UINavigationController *)vc];
        }
        ALMainWindow.rootViewController = vc;
    }];
}

@end

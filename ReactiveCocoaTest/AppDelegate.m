//
//  AppDelegate.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/8/31.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "AppDelegate.h"
#import "ALModelServiceImpl.h"
#import "ALLoginViewModel.h"
#import "ALLoginViewController.h"
#import "ALHomePageViewModel.h"

@interface AppDelegate ()

@property (nonatomic, strong) ALNavigationStack *navigationStack;
@property (nonatomic, strong) id<ALModelServices> service;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    
    self.service = [[ALModelServiceImpl alloc] init];
    self.navigationStack = [[ALNavigationStack alloc] initWith:self.service];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [(ALModelServiceImpl *)self.service resetRootViewModel:[self configKeyWindowModel]];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (ALBaseModel *)configKeyWindowModel
{
    if ([SSKeychain rawLogin].length && [SSKeychain accessToken].length) {
        self.service.account.account = [SSKeychain rawLogin];
        self.service.account.accessToken = [SSKeychain accessToken];
        return [[ALHomePageViewModel alloc] initWithServices:self.service];
    }
    return [[ALLoginViewModel alloc] initWithServices:self.service];
}

@end

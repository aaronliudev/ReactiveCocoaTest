//
//  ALUserManager.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/26.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALUserManager.h"

@implementation ALUserManager

+ (instancetype)shareManager
{
    static ALUserManager *userManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManager = [[ALUserManager alloc] init];
    });
    return userManager;
}

- (void)login
{
    
}

- (void)logout
{
    
}

- (BOOL)isLogin
{
    return NO;
}

- (NSString *)userid
{
    return @"4";
}

- (NSString *)userName
{
    return nil;
}

- (NSString *)iconUrl
{
    return nil;
}

- (NSString *)accessToken
{
    return nil;
}



@end

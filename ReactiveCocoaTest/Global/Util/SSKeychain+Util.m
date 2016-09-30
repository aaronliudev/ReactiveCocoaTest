//
//  SSKeychain+Util.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/18.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "SSKeychain+Util.h"


@implementation SSKeychain (Util)

+ (NSString *)rawLogin
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:AL_RAW_LOGIN];
}

+ (NSString *)password
{
    return [SFHFKeychainUtils getPasswordForUsername:AL_PASSWORD andServiceName:AL_SERVICE_NAME error:nil];
}

+ (NSString *)accessToken
{
#ifdef DEBUG
//    return [[NSUserDefaults standardUserDefaults] objectForKey:AL_ACCESS_TOKEN];
    return nil;
#else
    return [SFHFKeychainUtils getPasswordForUsername:AL_ACCESS_TOKEN andServiceName:AL_SERVICE_NAME error:nil];
#endif
}

+ (void)setRawLogin:(NSString *)rawLogin
{
    if (rawLogin && rawLogin.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:rawLogin forKey:AL_RAW_LOGIN];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)setPassword:(NSString *)password
{
    BOOL isSuccess = [SFHFKeychainUtils storeUsername:AL_PASSWORD andPassword:password forServiceName:AL_SERVICE_NAME updateExisting:YES error:nil];
    if (isSuccess) {
        NSLog(@"密码保存成功");
    }
    else {
        NSLog(@"密码保存失败");
    }
}

+ (void)setAccessToken:(NSString *)accessToken
{
#ifdef DEBUG
    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:AL_ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
#else
    [SFHFKeychainUtils storeUsername:AL_ACCESS_TOKEN andPassword:accessToken forServiceName:AL_SERVICE_NAME updateExisting:YES error:nil];
#endif
}

@end

//
//  ALRequestConfig.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/24.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALRequestConfig.h"
#import <AdSupport/AdSupport.h>
#import "ALUserManager.h"
#import "ALNetWorkUrl.h"

@interface ALRequestConfig ()

@property (nonatomic, copy) NSArray *portNumbers;
@property (nonatomic, assign) NSInteger selectNum;

@end

@implementation ALRequestConfig

+ (instancetype)shareConfig
{
    static ALRequestConfig *requestConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestConfig = [[ALRequestConfig alloc] init];
    });
    return requestConfig;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _portNumbers = @[@"8084", @"28086", @"28080", @"28084", @"28888"];
    }
    return self;
}

- (NSString *)hostName
{
    return ALBaseUrl;
}

- (NSString *)portNumber
{
    return _portNumbers[0];
}

- (NSMutableDictionary *)defaultDictionary
{
    NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
    userDict[ @"uid" ] = [[ALUserManager shareManager] userid] ?: @"0";
    userDict[ @"nickname" ] = [[ALUserManager shareManager] userName ] ?: @"0";
    userDict[ @"access_token" ] = [[ALUserManager shareManager] accessToken] ?: @"";

    NSMutableDictionary *deviceDict = [NSMutableDictionary dictionary];
    deviceDict[ @"imei" ] = @"0000";
    deviceDict[ @"idfa" ] = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] ?: @"0000";
    deviceDict[ @"macAddress" ] = @"0000";
    deviceDict[ @"platform" ] = @"ios";
    deviceDict[ @"systemVersion" ] = [NSString stringWithFormat:@"%.1f", [UIDevice systemVersion]];
    deviceDict[ @"machineName" ] = [UIDevice currentDevice].machineModelName;
    
    NSMutableDictionary *softDict = [NSMutableDictionary dictionary];
    softDict[ @"productId" ] = AL_APP_PRODUCTID;
    softDict[ @"version" ] = AL_APP_VERSION;
    softDict[ @"coopId" ] = AL_APP_COOPID;

    NSMutableDictionary *baseDict = [NSMutableDictionary dictionary];
    baseDict[ @"user" ] = userDict;
    baseDict[ @"device" ] = deviceDict;
    baseDict[ @"soft" ] = softDict;
    
    return baseDict;
}


@end

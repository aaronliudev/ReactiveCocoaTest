//
//  ALUserManager.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/26.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALUserManager : NSObject

+ (instancetype)shareManager;

- (void)login;
- (void)logout;
- (BOOL)isLogin;

- (NSString *)userid;
- (NSString *)userName;
- (NSString *)iconUrl;
- (NSString *)accessToken;


@end

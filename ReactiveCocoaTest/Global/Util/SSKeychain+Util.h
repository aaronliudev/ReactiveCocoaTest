//
//  SSKeychain+Util.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/18.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <SSKeychain/SSKeychain.h>

@interface SSKeychain (Util)

+ (NSString *)rawLogin;
+ (NSString *)password;
+ (NSString *)accessToken;

+ (void)setRawLogin:(NSString *)rawLogin;
+ (void)setPassword:(NSString *)password;
+ (void)setAccessToken:(NSString *)accessToken;



@end

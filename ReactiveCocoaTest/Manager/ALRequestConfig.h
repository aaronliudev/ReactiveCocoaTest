//
//  ALRequestConfig.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/24.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALRequestConfig : NSObject

@property (nonatomic, copy) NSString *hostName;

+ (instancetype)shareConfig;

- (NSString *)hostName;
- (NSString *)portNumber;
- (NSMutableDictionary *)defaultDictionary;

@end

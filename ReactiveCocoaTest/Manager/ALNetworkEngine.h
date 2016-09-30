//
//  ALNetworkEngine.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/24.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALNetworkEngine : NSObject

+ (instancetype)shareEngine;

- (void)requestData;

@end

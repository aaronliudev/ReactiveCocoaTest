//
//  ALModelServices.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/18.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALModelProtrocl.h"

@protocol ALModelServices <NSObject, ALModelProtrocl>

@property (nonatomic, strong) Account *account;
@property (nonatomic, copy) NSString *strTest;

@end

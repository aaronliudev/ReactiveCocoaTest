//
//  Account.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/18.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *pswd;
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *admin_level;

@end

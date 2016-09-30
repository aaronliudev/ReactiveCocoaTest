//
//  ALLoginViewModel.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/18.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALLoginViewModel : ALBaseModel

@property (nonatomic, strong) Account *account;
@property (nonatomic, strong, readonly) RACCommand *loginCommand;
@property (nonatomic, strong, readonly) RACSignal *loginBtnEnableSignal;

@end
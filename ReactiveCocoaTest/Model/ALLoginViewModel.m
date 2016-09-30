//
//  ALLoginViewModel.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/18.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALLoginViewModel.h"
#import "ALHomePageViewModel.h"
#import "ALModelServices.h"

#import "ALNetworkEngine.h"

@interface ALLoginViewModel ()

@property (nonatomic, strong) RACCommand *loginCommand;
@property (nonatomic, strong) RACSignal *loginBtnEnableSignal;


@end

@implementation ALLoginViewModel

- (Account *)account
{
    if (!_account) _account = [[Account alloc] init];
    return _account;
}

- (void)configViewModelHook
{
    _loginBtnEnableSignal = [[RACSignal combineLatest:@[RACObserve(self.account, account),
                                                       RACObserve(self.account, pswd)]
                                              reduce:^id(NSString *account, NSString *pswd){
                                                  return @(account.length > 0 && pswd.length > 0);
                                              }] distinctUntilChanged];
    @weakify(self);
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return  [[self requestLogin] doNext:^(id x) {
            
            SSKeychain.rawLogin = self.account.account;
            SSKeychain.password = self.account.pswd;
            SSKeychain.accessToken = @"ajkfal123jhjhh14ae45";
            NSLog(@"登录成功");
            
            ALHomePageViewModel *homePage = [[ALHomePageViewModel alloc] initWithServices:self.services];
            [self.services resetRootViewModel:homePage];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"密码是：－－－－－%@－－－－－－",[SSKeychain password]);
                
            });
        }];
    }];
    
}

- (RACSignal *)requestLogin
{
//    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        
//        static int i = 0;
//        if (i == 5) {
//            [subscriber sendNext:@"123"];
//            [subscriber sendCompleted];
//        }
//        else {
//            [subscriber sendError:nil];
//            NSLog(@"xxxxxx");
//            i ++;
//        }
//        
//        return [RACDisposable disposableWithBlock:^{
//            
//        }];
//        
//    }] retry];
    
    [[ALNetworkEngine shareEngine] requestData];
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (1) {
                [subscriber sendNext:@"123"];
                [subscriber sendCompleted];
            }
            else {
                [subscriber sendError:nil];
            }
        });
        
        return nil;
    }];
}

@end

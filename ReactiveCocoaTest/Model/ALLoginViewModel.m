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


- (void)configViewModelHook
{
    _loginBtnEnableSignal = [[RACSignal combineLatest:@[RACObserve(self, username),
                                                       RACObserve(self, password)]
                                              reduce:^id(NSString *account, NSString *pswd){
                                                  return @(account.length > 0 && pswd.length > 0);
                                              }] distinctUntilChanged];
    @weakify(self);
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id x) {
        @strongify(self);
        return  [[self requestLogin] doNext:^(OCTClient *client) {
            
            SSKeychain.rawLogin = client.user.rawLogin;
            SSKeychain.password = self.password;
            SSKeychain.accessToken = client.token;
            NSLog(@"登录成功");
            
            ALHomePageViewModel *homePage = [[ALHomePageViewModel alloc] initWithServices:self.services];
            [self.services resetRootViewModel:homePage];
            
        }];
    }];
    
}

- (RACSignal *)requestLogin
{
    OCTUser *user = [OCTUser userWithRawLogin:self.username server:OCTServer.dotComServer];
    
    return [OCTClient signInAsUser:user password:self.password oneTimePassword:nil scopes:OCTClientAuthorizationScopesUser | OCTClientAuthorizationScopesRepository];
    
}

@end

//
//  ALNetworkEngine.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/24.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALNetworkEngine.h"
#import <MKNetworkKit/MKNetworkKit.h>
#import "ALRequestConfig.h"
#import "ALNetWorkUrl.h"

@interface ALNetworkEngine ()

@property (nonatomic, strong) MKNetworkEngine *networkEngine;
@property (nonatomic, strong) ALRequestConfig *requestConfig;


@end

@implementation ALNetworkEngine

+ (instancetype)shareEngine
{
    static ALNetworkEngine *engine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        engine = [[ALNetworkEngine alloc] init];
    });
    return engine;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _requestConfig = [ALRequestConfig shareConfig];
//        _networkEngine = [[MKNetworkEngine alloc] init];
        _networkEngine = [[MKNetworkEngine alloc] initWithHostName:[_requestConfig hostName]];
        _networkEngine.portNumber = [[_requestConfig portNumber] intValue];
    }
    return self;
}

- (void)requestData
{
//    NSDictionary *dict = [self buildRequest:GetUserinfoPath andParameters:@{@"author_id" : @"4"}];
//    
//    NSString *urlstr = @"http://imagetest.medical-lighter.com/public/uploads/partcard_thumb/57442d6408521.jpg";
//    //    NSString *url = @"http://proimg.medical-lighter.com/public/discuz/post/2016-08-31/695pih0q92U.jpg@!water"
//
//    urlstr = @"http://image72.360doc.com/DownloadImg/2014/05/2605/42035151_1.jpg";
////    NSURL *url = [NSURL URLWithString:urlstr];
//
//    
//    MKNetworkOperation *operation = [_networkEngine operationWithPath:GetUserinfoPath params:dict httpMethod:@"POST" ssl:NO];
//    
//    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//        NSLog(@"success");
//        NSDictionary *dict = [completedOperation responseJSON];
//        
//        NSDictionary *reDict = [NSJSONSerialization JSONObjectWithData:[completedOperation responseData] options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",dict);
//        
//    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//        NSLog(@"faild");
//    }];
//    
//    [_networkEngine enqueueOperation:operation];
    
    MKNetworkOperation *operation = [_networkEngine operationWithURLString:@"https://api.douban.com/v2/book/search" params:@{@"q":@"iOS"} httpMethod:@"GET"];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
    }];
    
    [_networkEngine enqueueOperation:operation];
    
}


- (NSDictionary *)buildRequest:(NSString *)command andParameters:(NSDictionary *)params
{
    NSMutableDictionary *baseDict = [[ALRequestConfig shareConfig] defaultDictionary];
    baseDict[ @"command" ] = command;
    if (params)
    {
        baseDict[ @"request" ] = params;
    }
    return baseDict;
}

@end

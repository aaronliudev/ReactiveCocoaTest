//
//  ALModelServiceImpl.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/18.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALModelServiceImpl.h"

@implementation ALModelServiceImpl

@synthesize client = _client;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)pushViewModel:(ALBaseModel *)viewModel animated:(BOOL)animated {}
- (void)popViewModelAnimated:(BOOL)animated {}
- (void)popToRootViewModelAnimated:(BOOL)animated{}
- (void)presentViewModel:(ALBaseModel *)viewModel animated:(BOOL)animated completion:(VoidBlock)completion {}
- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion {}
- (void)resetRootViewModel:(ALBaseModel *)viewModel {

}


@end

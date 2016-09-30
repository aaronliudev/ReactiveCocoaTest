//
//  ALViewControllerRouter.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/18.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALViewControllerRouter : NSObject

+ (instancetype)shareRouter;

- (ALBaseViewController *)viewControllerForModel:(ALBaseModel *)viewModel;

@end

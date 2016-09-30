//
//  ALBaseViewController.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/9.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALBaseViewController : UIViewController

@property(nonatomic, strong, readonly) ALBaseModel *viewModel;

- (instancetype)initWithModel:(ALBaseModel *)model;

- (void)configViewModelHook;

@end

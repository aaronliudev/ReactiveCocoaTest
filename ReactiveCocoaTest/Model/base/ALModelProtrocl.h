//
//  ALModelProtrocl.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/12.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALBaseModel.h"
#ifndef ALModelProtrocl_h
#define ALModelProtrocl_h

@protocol ALModelProtrocl <NSObject>

/// Pushes the corresponding view controller.
///
/// Uses a horizontal slide transition.
/// Has no effect if the corresponding view controller is already in the stack.
///
/// viewModel - the view model
/// animated  - use animation or not
- (void)pushViewModel:(ALBaseModel *)viewModel animated:(BOOL)animated;

/// Pops the top view controller in the stack.
///
/// animated - use animation or not
- (void)popViewModelAnimated:(BOOL)animated;

/// Pops until there's only a single view controller left on the stack.
///
/// animated - use animation or not
- (void)popToRootViewModelAnimated:(BOOL)animated;

/// Present the corresponding view controller.
///
/// viewModel  - the view model
/// animated   - use animation or not
/// completion - the completion handler
- (void)presentViewModel:(ALBaseModel *)viewModel animated:(BOOL)animated completion:(VoidBlock)completion;

/// Dismiss the presented view controller.
///
/// animated   - use animation or not
/// completion - the completion handler
- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion;

/// Reset the corresponding view controller as the root view controller of the application's window.
///
/// viewModel - the view model
- (void)resetRootViewModel:(ALBaseModel *)viewModel;

@end


#endif /* ALModelProtrocl_h */

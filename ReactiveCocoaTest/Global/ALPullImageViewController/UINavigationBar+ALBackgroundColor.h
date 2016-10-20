//
//  UINavigationBar+ALBackgroundColor.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/10/11.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, ALNavigationBarMoveStyle) {
    ALNavigationBarDefault  = 1,     // 在顶部隐藏和显示
    ALNavigationBarMoveAnimate,      // 根据偏移量直接显示隐藏，使用[UIView animate]
    ALNavigationBarScrolling,        // 根据偏移量上下移动
};

@interface UINavigationBar (ALBackgroundColor)

/// navigationBar background color, default is nil, and color is navigation Bar barTintColor.
@property (nonatomic, strong) UIColor *navigationBar_backgroundColor;

/// show status bar or not
@property (nonatomic, assign) BOOL al_isShowStatusBar;

/**
 *  if true, navigation Bar will be hidden when swipe gesture direction down, otherwise, show again.
 *  default NO, offsetY <= navigationBarHeight will hidden or show.
 */
@property (nonatomic, assign) ALNavigationBarMoveStyle al_navigationBarStyle;
/// if use moveHiddenShow property, the actionTime can be used. default 0.5
@property (nonatomic, assign) NSTimeInterval al_actionTime;
/// when moved the scrollView, the navigation bar's alpha is changed, default is YES
@property (nonatomic, assign) BOOL al_alphaChangedWhenMove;

/// hfahfakjh
- (void)al_setBarBackgroundColor:(UIColor *)bgColor;

/**
 * if the offsetY changed, the navigation bar will move up or down
 */
- (void)al_setBarTranslationWithOffsetY:(CGFloat)offsetY;


/**
 @discussion reset navigationBar
 */
- (void)al_resetNavigationBar;

@end

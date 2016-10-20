//
//  UINavigationBar+ALBackgroundColor.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/10/11.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "UINavigationBar+ALBackgroundColor.h"
#import <objc/Object.h>

#define ALNavigationBarHeight 64
#define ALNavigationBarWithoutStatusBarHeight 64


typedef NS_ENUM(NSUInteger, ALNavigationBarScrollingDirection) {
    ALNavigationBarScrollingDirectionUp = 0,
    ALNavigationBarScrollingDirectionDown,
};

@interface UINavigationBar ()

///
@property (nonatomic, strong) UIView *al_overView;

/// last offset，user this to check to show or hide the navigation bar
@property (nonatomic, assign) CGFloat al_lastDownY;
@property (nonatomic, assign) CGFloat al_lastUpY;
@property (nonatomic, assign) CGFloat al_lastOffsetY;
/// use lastOffsetY to check the value. if is true, the navigation bar will show. default is NO
@property (nonatomic, assign) BOOL al_isScrolling;
/// scrolling up turn to down, vice versa. Default is NO
@property (nonatomic, assign) ALNavigationBarScrollingDirection al_scrollingDirection;

@end

static char KNvaigationBarBgColorKey;
static char KOverViewKey;
static char KIsShowStatusBarKey;
static char KActionTimeKey;
static char KLastUpYKey;
static char KLastDownYKey;
static char KLastOffsetYKey;
static char KWillShowKey;
static char KNavigationBarStyleKey;
static char KScrollingDirectionKey;

@implementation UINavigationBar (ALBackgroundColor)

- (void)al_setBarBackgroundColor:(UIColor *)bgColor
{
    if (!self.al_overView) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.al_overView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.al_overView.userInteractionEnabled = NO;
        self.al_overView.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight`
        [[self.subviews firstObject] insertSubview:self.al_overView atIndex:0];
    }
    self.al_overView.backgroundColor = bgColor;
}

- (void)al_setBarTranslationWithOffsetY:(CGFloat)offsetY
{
    CGFloat tempOffsetY = [self al_navigationBarHeight];
    CGFloat progress = 0;
    
    
    switch (self.al_navigationBarStyle) {
        case ALNavigationBarDefault:
        {
            [self al_navigationBarMoveDefault:offsetY];
        }
            break;
        case ALNavigationBarScrolling:
        {
            [self al_navigationBarScrolling:offsetY];
        }
            break;
        case ALNavigationBarMoveAnimate:
        {
            [self al_navigationBarMoveAnimate:offsetY];
        }
            break;
        default:
            break;
    }
    
//    if (offsetY > 0) {
//        
//        if (self.moveHiddenShow) {
//            [self al_setBarTranslationAnimate:offsetY];
//            self.lastOffsetY = offsetY;
//            return;
//        }
//        
//        if (offsetY >= tempOffsetY) {
//            progress = 1;
//        }
//        else {
//            progress = (offsetY / tempOffsetY);
//        }
//    }
//    else {
//        progress = 0;
//    }
//    [self al_setNavigationBartranslationProgress:progress];
//    self.lastOffsetY = offsetY;
    
}

- (void)al_navigationBarMoveDefault:(CGFloat)offsetY
{
    CGFloat tempOffsetY = [self al_navigationBarHeight];
    CGFloat progress = 0;
    if (offsetY > 0) {
        
        if (offsetY >= tempOffsetY) {
            progress = 1;
        }
        else {
            progress = (offsetY / tempOffsetY);
        }
    }
    else {
        progress = 0;
    }
    [self al_setNavigationBartranslationProgress:progress];
}

// animate
- (void)al_navigationBarMoveAnimate:(CGFloat)offsetY
{
    if (offsetY < [self al_navigationBarHeight]) {
        [self al_setNavigationBartranslationProgress:0];
        self.al_lastOffsetY = offsetY;
        return;
    }
    NSTimeInterval duration = self.al_actionTime ? self.al_actionTime : 0.3;
    BOOL isScrolling = [self al_checkShowNavigationOrHide:offsetY];
    self.al_lastOffsetY = offsetY;
    if (self.al_isScrolling == isScrolling) {
        return;
    }
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        if (self.al_isScrolling) {
            [self al_setNavigationBartranslationProgress:1];
        }
        else {
            [self al_setNavigationBartranslationProgress:0];
        }
        self.al_isScrolling = isScrolling;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)al_navigationBarScrolling:(CGFloat)offsetY
{
    CGFloat barheight = [self al_navigationBarHeight];
    CGFloat progress = 0;
    
//    self.al_changedScrollDirection = offsetY - self.al_lastOffsetY;
    if (offsetY > 0) {
        
        if (offsetY > self.al_lastOffsetY) {
            self.al_scrollingDirection = ALNavigationBarScrollingDirectionUp;
        }
        else {
            self.al_scrollingDirection = ALNavigationBarScrollingDirectionDown;
        }
        
        self.al_lastOffsetY = offsetY;
        
        if (self.al_scrollingDirection == ALNavigationBarScrollingDirectionUp) {
            
            if (self.al_lastUpY > 0) {
                
                if (offsetY - self.al_lastUpY >= barheight) {
                    progress = 1;
                    self.al_lastDownY = 0;
                }
                else {
                    if (self.al_lastDownY) {
                        progress = 1 - fabs(offsetY - self.al_lastUpY) / barheight;
                    }
                    else
                        progress = fabs(offsetY - self.al_lastUpY) / barheight;
                }
            }
            else {
                if (fabs(offsetY - self.al_lastDownY) >= barheight || self.al_lastDownY == 0) {
                    self.al_lastUpY = offsetY;
                    self.al_lastDownY = 0;
                }
                else {
                    if (self.al_lastDownY) {
                        progress = 1 - fabs(offsetY - self.al_lastDownY) / barheight;
                        self.al_lastUpY = self.al_lastDownY;
                    }
                    else {
                        progress = fabs(offsetY - self.al_lastUpY) / barheight;
                        
                    }
                }
                return;
            }
            
        }
        else {
            
            if (self.al_lastDownY > 0) {
                
                if (self.al_lastDownY - offsetY >= barheight) {
                    progress = 0;
                    self.al_lastUpY = 0;
                }
                else {
                    if (self.al_lastUpY) {
                        progress = fabs(self.al_lastDownY - offsetY) / barheight;
                    }
                    else {
                        progress = 1 - fabs(offsetY - self.al_lastDownY) / barheight;
                    }
                }
            }
            else {
                if (fabs(offsetY - self.al_lastUpY) > barheight || self.al_lastUpY == 0) {
                    
                    self.al_lastDownY = offsetY;
                    self.al_lastUpY = 0;
                }
                else {
                    if (self.al_lastUpY) {
                        progress = fabs(self.al_lastDownY - offsetY) / barheight;
                        self.al_lastDownY = self.al_lastUpY;
                    }
                    else
                        progress = 1 - fabs(self.al_lastDownY - offsetY) / barheight;
                }
                
                
                
                return;
            }
            
        }
    }
    else
        progress = 0;
    
    [self al_setNavigationBartranslationProgress:progress];
}


- (BOOL)chekoutScrolling:(CGFloat)offsetY
{
    if (offsetY > 0) {
        
        
        
        return offsetY > self.al_lastOffsetY;
    }
    else {
        return YES;
    }
}

- (void)al_resetNavigationBar
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.al_overView removeFromSuperview];
    self.al_overView = nil;
}


// MARK: - Private Method
- (void)al_setBarTranslationAnimate:(CGFloat)offsetY
{
    
    
//    if (1) {
//        if (offsetY >= [self al_navigationBarHeight]) {
//            [self al_setNavigationBartranslationProgress:((offsetY - self.al_lastOffsetY)) / [self al_navigationBarHeight]];
//        }
//        
//        
//    }
//    else {
//        NSTimeInterval duration = self.al_actionTime ? self.al_actionTime : 0.3;
//        BOOL willShow = [self al_checkShowNavigationOrHide:offsetY];
//        if (self.willShow == willShow) {
//            return;
//        }
//        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//            if (self.willShow) {
//                [self al_setNavigationBartranslationProgress:1];
//            }
//            else {
//                [self al_setNavigationBartranslationProgress:0];
//            }
//            self.willShow = willShow;
//        } completion:^(BOOL finished) {
//            
//        }];
//    }
}

/// 根据progress移动
- (void)al_setNavigationBartranslationProgress:(CGFloat)progress
{
    CGFloat navigationBarHeight = [self al_navigationBarHeight];
    CGFloat offsetY = -navigationBarHeight * progress;
    [self al_setBarTranslationY: offsetY];
    [self al_setBarTranslationBackgroundAlpha:(1 - progress)];
}

- (void)al_setBarTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)al_setBarTranslationBackgroundAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.alpha = alpha;
    }];
    
    ((UIView *)[self valueForKey:@"_titleView"]).alpha = alpha;
    
    [[self subviews] objectAtIndex:0].alpha = alpha;
}

// navigation bar height
- (CGFloat)al_navigationBarHeight
{
    return self.al_isShowStatusBar ? ALNavigationBarWithoutStatusBarHeight : ALNavigationBarHeight;
}

- (BOOL)al_checkShowNavigationOrHide:(CGFloat)offsetY
{
    BOOL isShow = NO;
    if (offsetY <= [self al_navigationBarHeight]) {
        isShow = YES;
    }
    else if (offsetY > self.al_lastOffsetY) {
        isShow = NO;
    }
    else {
        isShow = YES;
    }
    
    return isShow;
}



// MARK: - Set & Get Method
// MARK: Private Property
- (void)setAl_lastUpY:(CGFloat)al_lastUpY
{
    objc_setAssociatedObject(self, &KLastUpYKey, @(al_lastUpY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)al_lastUpY
{
    return [objc_getAssociatedObject(self, &KLastUpYKey) floatValue];
}

- (void)setAl_lastDownY:(CGFloat)al_lastDownY
{
    objc_setAssociatedObject(self, &KLastDownYKey, @(al_lastDownY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)al_lastDownY
{
    return [objc_getAssociatedObject(self, &KLastDownYKey) floatValue];
}

- (void)setAl_lastOffsetY:(CGFloat)al_lastOffsetY
{
    objc_setAssociatedObject(self, &KLastOffsetYKey, @(al_lastOffsetY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)al_lastOffsetY
{
    return [objc_getAssociatedObject(self, &KLastOffsetYKey) floatValue];
}

- (void)setAl_isScrolling:(BOOL)al_isScrolling
{
    objc_setAssociatedObject(self, &KWillShowKey, @(al_isScrolling), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)al_isScrolling
{
    return [objc_getAssociatedObject(self, &KWillShowKey) boolValue];
}

- (UIView *)al_overView
{
    return objc_getAssociatedObject(self, &KOverViewKey);
}

- (void)setAl_overView:(UIView *)al_overView
{
    objc_setAssociatedObject(self, &KOverViewKey, al_overView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setAl_scrollingDirection:(ALNavigationBarScrollingDirection)al_scrollingDirection
{
    objc_setAssociatedObject(self, &KScrollingDirectionKey, @(al_scrollingDirection), OBJC_ASSOCIATION_ASSIGN);
}

- (ALNavigationBarScrollingDirection)al_scrollingDirection
{
    return [objc_getAssociatedObject(self, &KScrollingDirectionKey) boolValue];
}

// MARK: Public Property
- (UIColor *)navigationBar_backgroundColor
{
    return objc_getAssociatedObject(self, &KNvaigationBarBgColorKey);
}

- (void)setNavigationBar_backgroundColor:(UIColor *)navigationBar_backgroundColor
{
    objc_setAssociatedObject(self, &KNvaigationBarBgColorKey, navigationBar_backgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)al_isShowStatusBar
{
    return [objc_getAssociatedObject(self, &KIsShowStatusBarKey) boolValue];
}

- (void)setAl_isShowStatusBar:(BOOL)al_isShowStatusBar
{
    objc_setAssociatedObject(self, &KIsShowStatusBarKey, @(al_isShowStatusBar), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setAl_actionTime:(NSTimeInterval)al_actionTime
{
    objc_setAssociatedObject(self, &KActionTimeKey, @(al_actionTime), OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)al_actionTime
{
    return [objc_getAssociatedObject(self, &KActionTimeKey) floatValue];
}

- (void)setAl_navigationBarStyle:(ALNavigationBarMoveStyle)al_navigationBarStyle
{
    objc_setAssociatedObject(self, &KNavigationBarStyleKey, @(al_navigationBarStyle), OBJC_ASSOCIATION_ASSIGN);
}

- (ALNavigationBarMoveStyle)al_navigationBarStyle
{
    return [objc_getAssociatedObject(self, &KNavigationBarStyleKey) integerValue];
}

@end

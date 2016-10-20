//
//  ALBaseViewController+ALPullHeaderView.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/10/11.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALBaseViewController+ALPullHeaderView.h"
#import "ALPullHeaderView.h"
#import "UINavigationBar+ALBackgroundColor.h"

@interface ALBaseViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) ALPullHeaderView *headerView;

@end

@implementation ALBaseViewController (ALPullHeaderView)

- (void)configHeaderViewWith:(UITableView *)tableView
{
    tableView.tableHeaderView = self.headerView;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)configHeaderImageUrl:(NSString *)imageurl
{
    self.headerView.imageUrl = imageurl;
}

- (void)configHeaderImage:(UIImage *)image
{
    self.headerView.image = image;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    [self.navigationController.navigationBar al_setBarBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar al_resetNavigationBar];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    self.headerView.contentOffset = offset;
    
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    
    [self.navigationController.navigationBar al_setBarTranslationWithOffsetY:offsetY];
//    if (offsetY > 50) {
//        CGFloat alpha = MIN(1, 1 - ((50 + 64 - offsetY) / 64));
//        [self.navigationController.navigationBar al_setBarBackgroundColor:[color colorWithAlphaComponent:alpha]];
////        [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = alpha;
//    } else {
//        [self.navigationController.navigationBar al_setBarBackgroundColor:[color colorWithAlphaComponent:0]];
////        [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 0;
//    }
}

#pragma mark - Get Method
- (ALPullHeaderView *)headerView
{
    ALPullHeaderView *headerView = objc_getAssociatedObject(self, _cmd);
    if (!headerView) {
        headerView = [[ALPullHeaderView alloc] init];
        objc_setAssociatedObject(self, _cmd, headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return headerView;
}

@end

//
//  UITableView+ALPullHeaderView.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/10/11.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <objc/objc.h>
#import "UITableView+ALPullHeaderView.h"
#import "ALPullHeaderView.h"

@interface UITableView ()<UIScrollViewDelegate>

@property (nonatomic, strong) ALPullHeaderView *headerView;

@end

@implementation UITableView (ALPullHeaderView)

- (void)configHeaderView
{
    self.tableHeaderView = self.headerView;
}

- (void)configHeaderImageUrl:(NSString *)imageurl
{
    self.headerView.imageUrl = imageurl;
}

- (void)configHeaderImage:(UIImage *)image
{
//    self.headerView.imageUrl
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    self.headerView.contentOffset = offset;
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

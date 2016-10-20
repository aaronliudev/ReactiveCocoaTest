//
//  UITableView+ALPullHeaderView.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/10/11.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (ALPullHeaderView)


- (void)configHeaderViewWith:(UITableView *)tableView;
- (void)configHeaderImageUrl:(NSString *)imageurl;
- (void)configHeaderImage:(UIImage *)image;

@end

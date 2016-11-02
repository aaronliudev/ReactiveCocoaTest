//
//  ALBaseViewController+ALPullHeaderView.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/10/11.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALBaseViewController.h"

@interface ALBaseViewController (ALPullHeaderView)

///
- (void)configHeaderView:(UITableView *)tableView;

/// set headerView image url.
- (void)configHeaderImageUrl:(NSString *)imageurl;

/// set headerView image.
- (void)configHeaderImage:(UIImage *)image;

@end

//
//  ALBaseViewController+ALPullHeaderView.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/10/11.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALBaseViewController.h"

@interface ALBaseViewController (ALPullHeaderView)

- (void)configHeaderViewWith:(UITableView *)tableView;
- (void)configHeaderImageUrl:(NSString *)imageurl;
- (void)configHeaderImage:(UIImage *)image;

@end

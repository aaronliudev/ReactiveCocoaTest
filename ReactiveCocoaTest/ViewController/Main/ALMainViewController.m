//
//  ALMainViewController.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/22.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALMainViewController.h"
//#import "UITableView+ALPullHeaderView.h"
#import "ALBaseViewController+ALPullHeaderView.h"
#import "UINavigationBar+ALBackgroundColor.h"

@interface ALMainViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentView;

@end

@implementation ALMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    
    
    
    [self.view addSubview:self.contentView];
    [self configHeaderViewWith:self.contentView];
//    [self configHeaderImageUrl:@"https://avatars.githubusercontent.com/u/17328307?v=3"];
    [self configHeaderImage:[UIImage imageNamed:@"123"]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.navigationController.navigationBar.al_navigationBarStyle = ALNavigationBarScrolling;
    
    // Do any additional setup after loading the view.
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    UIColor *color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if (offsetY > 50) {
//        CGFloat alpha = MIN(1, 1 - ((50 + 64 - offsetY) / 64));
//        [self.navigationController.navigationBar al_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
//    } else {
//        [self.navigationController.navigationBar al_setBackgroundColor:[color colorWithAlphaComponent:0]];
//        NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~");
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%lu个", indexPath.row + 1];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 200;
}


- (UITableView *)contentView
{
    if (!_contentView) {
        _contentView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _contentView.delegate = self;
        _contentView.dataSource = self;
    }
    return _contentView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

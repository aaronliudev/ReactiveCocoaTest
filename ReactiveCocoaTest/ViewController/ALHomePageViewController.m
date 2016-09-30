//
//  ALHomePageViewController.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/9.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALHomePageViewController.h"
#import "ALNoramlViewController.h"
#import "ALSickViewController.h"
#import "ALTopicViewController.h"
#import "ALMessageViewController.h"
#import "ALMainViewController.h"

#import "ALHomePageViewModel.h"

@interface ALHomePageViewController ()<UITabBarControllerDelegate>

@property (nonatomic, copy) NSDictionary *viewControllerDatas;
@property (nonatomic, copy) NSArray *receiveDatas;

@property (nonatomic, copy) ALHomePageViewModel *viewModel;

@end

@implementation ALHomePageViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configLocalData];
    [self setupSubviews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configLocalData
{
    _viewControllerDatas = @{  @"工具" : @[ @"tab_home_gray", @"tab_home_red"] ,
                               @"疾病" : @[ @"tab_sick_gray", @"tab_sick_red"] ,
                               @"社区" : @[ @"tab_feed_gray", @"tab_feed_red"] ,
                               @"聊天" : @[ @"tab_chat_gray", @"tab_chat_red"] ,
                               @"我的" : @[ @"tab_profile_gray", @"tab_profile_red"]  };
}

- (void)setupSubviews
{
    ALNoramlViewController *normalVc = [[ALNoramlViewController alloc] initWithModel:self.viewModel.normalViewModel];
    ALSickViewController *sickVc = [[ALSickViewController alloc] initWithModel:self.viewModel.sickViewModel];
    ALTopicViewController *topicVc = [[ALTopicViewController alloc] initWithModel:self.viewModel.topicViewModel];
    ALMessageViewController *messageVc = [[ALMessageViewController alloc] initWithModel:self.viewModel.messageViewModel];
    ALMainViewController *mainVc = [[ALMainViewController alloc] initWithModel:self.viewModel.mainViewModel];
    
    NSArray *vcs = @[normalVc, sickVc, topicVc, messageVc, mainVc];
    NSArray *titles = [_viewControllerDatas allKeys];
    
    NSMutableArray *allControllers = [NSMutableArray array];
    for (int i = 0; i < vcs.count; i ++) {
        NSString *titleKey = titles[i];
        NSArray *images = [_viewControllerDatas objectForKey:titleKey];
        ALNavigationController *navc = [self addChildVc:vcs[i] title:titleKey imageName:images[0] selectImageName:images[1]];
        
        [allControllers addObject:navc];
    }
    
    self.tabBarController.viewControllers = allControllers;
    self.tabBarController.selectedIndex = 2;
    
    [[self rac_signalForSelector:@selector(tabBarController:didSelectViewController:)] subscribeNext:^(RACTuple *tuple) {
        [ALSharedAppDelegate.navigationStack popNavigationController];
        [ALSharedAppDelegate.navigationStack pushNavigationController:tuple.second];
    }];
}

- (ALNavigationController *)addChildVc:(ALBaseViewController *)vc title:(NSString *)title imageName:(NSString *)imgName selectImageName:(NSString *)selectImgName
{
    ALNavigationController *navc = [[ALNavigationController alloc] initWithRootViewController:vc];
    
    UIImage *image = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectImage = [[UIImage imageNamed:selectImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectImage];
    
    [navc.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : HexRGB(0xda372a)} forState:UIControlStateSelected];
    [navc.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : HexRGB(0x696969) } forState:UIControlStateNormal];
    
    return navc;
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

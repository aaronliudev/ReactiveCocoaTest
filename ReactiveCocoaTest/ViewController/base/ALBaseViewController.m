//
//  ALBaseViewController.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/9.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALBaseViewController.h"

@interface ALBaseViewController ()

@property(nonatomic, strong) ALBaseModel *viewModel;

@end

@implementation ALBaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    ALBaseViewController *baseVc = [super allocWithZone:zone];
    
//    @weakify(baseVc);
//    [[(NSObject *)baseVc rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
//        @strongify(baseVc);
//        [baseVc configViewModelHook];
//    }];
    return baseVc;
}

- (instancetype)initWithModel:(ALBaseModel *)model
{
    self = [super init];
    if (self) {
        _viewModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configViewModelHook];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.viewModel.willAppearSignal sendNext:@"willAppear"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.viewModel.willDidDisappearSignal sendNext:@"willDisapper"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configViewModelHook
{
    
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

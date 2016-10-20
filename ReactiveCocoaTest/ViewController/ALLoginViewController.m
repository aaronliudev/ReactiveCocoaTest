//
//  ALLoginViewController.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/9.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALLoginViewController.h"
#import "ALLoginViewModel.h"

#import <IQKeyboardReturnKeyHandler.h>

@interface ALLoginViewController ()<UITextFieldDelegate, YYTextKeyboardObserver>

@property (weak, nonatomic) IBOutlet UITextField *nameTextF;
@property (weak, nonatomic) IBOutlet UITextField *pswdTextF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic, strong, readonly) ALLoginViewModel *viewModel;

@property (nonatomic, strong) IQKeyboardReturnKeyHandler *keyboardHandler;
@property (nonatomic, strong) UIView *toolView;

@end

@implementation ALLoginViewController

@dynamic viewModel;

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configPassword];
    
    if ([SSKeychain rawLogin]) {
        self.nameTextF.text = [SSKeychain rawLogin];
        self.pswdTextF.text = [SSKeychain password];
    }
    
    [[YYTextKeyboardManager defaultManager] addObserver:self];
    
    [self.view addSubview:self.toolView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc
{
    [[YYTextKeyboardManager defaultManager] removeObserver:self];
}

- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition
{
    CGRect frame = transition.toFrame;
    CGFloat bottom = CGRectGetMinY(frame);
    if (transition.animationDuration) {
        [UIView animateWithDuration:transition.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.toolView.bottom = bottom;
        } completion:^(BOOL finished) {
            
        }];
    }
    else {
        self.toolView.top = bottom;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configPassword
{
    _keyboardHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    _keyboardHandler.lastTextFieldReturnKeyType = UIReturnKeyGo;
    
    @weakify(self);
    [[self rac_signalForSelector:@selector(textFieldShouldReturn:) fromProtocol:@protocol(UITextFieldDelegate)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self);
         if (tuple.last == self.pswdTextF) {
             [self.viewModel.loginCommand execute:nil];
         }
    }];
    
    self.pswdTextF.delegate = self;
}

- (void)configViewModelHook
{
    RAC(self.viewModel, username) = self.nameTextF.rac_textSignal;
    RAC(self.viewModel, password) = self.pswdTextF.rac_textSignal;
    RAC(self.loginBtn, enabled) = self.viewModel.loginBtnEnableSignal;
    
//    [[self.nameTextF.rac_textSignal bind:^RACStreamBindBlock{
//        return ^RACStream *(id value, BOOL *stop) {
//            return [RACReturnSignal return:[NSString stringWithFormat:@"输出%@", value]];
//        };
//    }]
//    subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    
//    [[self.nameTextF.rac_textSignal flattenMap:^RACStream *(id value) {
//        return [RACReturnSignal return:[NSString stringWithFormat:@"输出%@", value]];
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
//    
//    [[self.nameTextF.rac_textSignal map:^id(id value) {
//        return [NSString stringWithFormat:@"---输出%@", value];
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    
//    [[_nameTextF.rac_textSignal merge:_pswdTextF.rac_textSignal] subscribeNext:^(NSString *x) {
//        if (x.length > 0) {
//            NSLog(@"length > 0");
//        }
//        else
//            NSLog(@"length < 0");
//    }];

//    [[RACSignal merge:@[_nameTextF.rac_textSignal, _pswdTextF.rac_textSignal]] subscribeNext:^(NSString *x) {
//        if (x.length > 0) {
//            NSLog(@"length > 0");
//        }
//        else
//            NSLog(@"length < 0");
//    }];
    
    
    @weakify(self);
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel.loginCommand execute:nil];
    }];
    
    [self.viewModel.loginCommand.errors subscribeNext:^(id x) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"登录失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
    [[self.viewModel.loginCommand.executing doNext:^(id x) {
        @strongify(self);
        self.editing = NO;
    }] subscribeNext:^(NSNumber *num) {
        if ([num boolValue]) {
            [MBProgressHUD showHUDAddedTo:self.view animated:0.5].label.text = @"登录中...";
        }
        else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}

- (UIView *)toolView
{
    if (!_toolView) {
        _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 50)];
        _toolView.backgroundColor = [UIColor greenColor];
    }
    return _toolView;
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

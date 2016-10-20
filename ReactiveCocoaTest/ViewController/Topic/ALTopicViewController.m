//
//  ALTopicViewController.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/22.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALTopicViewController.h"
#import <IQKeyboardReturnKeyHandler.h>

@interface ALTopicViewController ()

@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) UITextField *textField2;
@property (nonatomic, strong) UITextField *textField3;
@property (nonatomic, strong) IQKeyboardReturnKeyHandler *handler;

@end

@implementation ALTopicViewController

//- (void)loadView
//{
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
////    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.view = scrollView;
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(100, 300, 200, 40)];
    _textField1.backgroundColor = [UIColor lightGrayColor];
    _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(100, 400, 200, 40)];
    _textField2.backgroundColor = [UIColor lightGrayColor];
    _textField3 = [[UITextField alloc] initWithFrame:CGRectMake(100, 500, 200, 40)];
    _textField3.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:_textField1];
    [self.view addSubview:_textField2];
    [self.view addSubview:_textField3];
    _handler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    _handler.lastTextFieldReturnKeyType = UIReturnKeyDone;
//    [_textField1 becomeFirstResponder];
    
    
//    [self resignFirstResponder];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//
//  ALPullHeaderView.m
//  ReactiveCocoaTest
//
//  Created by Alan on 16/10/11.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ALPullHeaderView.h"

#define ALPullHeaderViewHeight 265

@interface ALPullHeaderView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ALPullHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, ALPullHeaderViewHeight);
    [self addSubview:self.imageView];
    self.imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ALPullHeaderViewHeight);
    [[RACObserve(self, contentOffset) filter:^BOOL(id x) {
        return [x CGPointValue].y <= 0;
    }]
     subscribeNext:^(id x) {
        CGPoint contentOffset = [x CGPointValue];
        self.imageView.frame = CGRectMake(0, 0 + contentOffset.y, SCREEN_WIDTH, ALPullHeaderViewHeight + ABS(contentOffset.y));
    }] ;
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [self configData];
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self configData];
}

- (void)configData
{
    if (self.image)
    {
        self.imageView.image = self.image;
    }
    else
    {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]];
        
    }
    
//    UIImage *image = self.imageView.image;
//    CGFloat scale = [UIScreen mainScreen].scale;
//    
//    CGSize size = CGSizeMake(image.size.width / scale, image.size.height / scale);
//    self.frame = CGRectMake(0, 0, size.width, size.height);
    
}

#pragma mark - Get Method
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

@end

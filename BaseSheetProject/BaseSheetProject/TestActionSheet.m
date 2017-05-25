//
//  TestActionSheet.m
//  ceshiaaaa
//
//  Created by Linyoung on 2017/5/24.
//  Copyright © 2017年 Linyoung. All rights reserved.
//

#import "TestActionSheet.h"

@interface TestActionSheet ()

@property (strong, nonatomic) UILabel *titleLab;

@end

@implementation TestActionSheet

#pragma mark - life cycle

- (id)init {
    if (self = [super init]) {
        [self createSubView];
    }
    return self;
}

#pragma mark - private methords

- (void)createSubView {
    self.titleLab.translatesAutoresizingMaskIntoConstraints = NO;
    [self.baseSheet addSubview:self.titleLab];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.baseSheet attribute:NSLayoutAttributeTop multiplier:1.0 constant:140.0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.baseSheet attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-140.0];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.baseSheet attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    //父视图 baseSheet的底部约束需要子视图来确定
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.baseSheet attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];

    NSArray *constraints = @[topConstraint,bottomConstraint,leftConstraint,rightConstraint];
    [self.baseSheet addConstraints:constraints];
}

#pragma mark - set and get

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"测试数据";
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:15];
    }
    return _titleLab;
}


@end

//
//  TestActionSheet.m
//  ceshiaaaa
//
//  Created by Linyoung on 2017/5/24.
//  Copyright © 2017年 Linyoung. All rights reserved.
//

#import "TestActionSheet.h"

@interface TestActionSheet ()<UITextFieldDelegate>

@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UITextField *textField;

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
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.baseSheet addSubview:self.titleLab];
    [self.baseSheet addSubview:self.textField];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.baseSheet attribute:NSLayoutAttributeTop multiplier:1.0 constant:140.0];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.baseSheet attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    //父视图 baseSheet的底部约束需要子视图来确定
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.baseSheet attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLab attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.0];
     //父视图 baseSheet的底部约束需要子视图来确定
    NSLayoutConstraint *tfBottomConstraint = [NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.baseSheet attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-140.0];
    NSLayoutConstraint *tfLeftConstraint = [NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.baseSheet attribute:NSLayoutAttributeLeft multiplier:1.0 constant:3.0];
   
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.baseSheet attribute:NSLayoutAttributeRight multiplier:1.0 constant:30.0];
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.0];

    NSArray *constraints = @[topConstraint,leftConstraint,rightConstraint,tfTopConstraint,tfBottomConstraint,tfLeftConstraint,tfRightConstraint,tfHeightConstraint];
    [self.baseSheet addConstraints:constraints];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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

- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        _textField.font = [UIFont systemFontOfSize:13];
        _textField.layer.borderWidth = 1;
        _textField.layer.borderColor = [UIColor blackColor].CGColor;
        _textField.layer.cornerRadius = 3;
        _textField.layer.masksToBounds = YES;
    }
    return _textField;
}


@end

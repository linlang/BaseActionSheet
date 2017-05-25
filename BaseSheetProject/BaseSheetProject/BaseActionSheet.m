//
//  BaseActionSheet.m
//  AddPetroleum
//
//  Created by Linyoung on 16/1/22.
//  Copyright © 2016年 Linyoung. All rights reserved.
//

#import "BaseActionSheet.h"

@interface BaseActionSheet ()

@property (strong, nonatomic) UIView * blureView;
@property (strong, nonatomic) UITapGestureRecognizer * tapGesture;
@property (strong, nonatomic) NSLayoutConstraint *baseSheetTop;

@end

@implementation BaseActionSheet

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if(self) {
        NSAssert(![self isMemberOfClass:[BaseActionSheet class]], @"BaseActionSheet是个虚基类，请子类化后使用");
        [self commonInit];
        [self createBaseActionSheetBaseView];
    }
    return self;
}

- (id)init {
    self = [self initWithFrame:CGRectZero];
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - private methords

- (void)commonInit {
    _blurAlpha = 0.4;
}

- (void)createBaseActionSheetBaseView
{
    self.blureView.translatesAutoresizingMaskIntoConstraints = NO;
    self.baseSheet.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.blureView];
    [self addSubview:self.baseSheet];
    NSLayoutConstraint *blureTop = [NSLayoutConstraint constraintWithItem:self.blureView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *blureBottom = [NSLayoutConstraint constraintWithItem:self.blureView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *blureLeft = [NSLayoutConstraint constraintWithItem:self.blureView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *blureRight = [NSLayoutConstraint constraintWithItem:self.blureView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];

    NSArray *blureConstraints = @[blureTop,blureLeft,blureRight,blureBottom];
    [self addConstraints:blureConstraints];

    NSLayoutConstraint *baseSheetLeft = [NSLayoutConstraint constraintWithItem:self.baseSheet attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *baseSheetRight = [NSLayoutConstraint constraintWithItem:self.baseSheet attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    NSLayoutConstraint *baseSheetTop = [NSLayoutConstraint constraintWithItem:self.baseSheet attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    self.baseSheetTop = baseSheetTop;
    NSArray *baseSheetConstraints = @[baseSheetTop,baseSheetLeft,baseSheetRight];
    [self addConstraints:baseSheetConstraints];
    
    //masonry 第三方布局
//    __weak __typeof(&*self)weakSelf = self;
//    [self.blureView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(weakSelf);
//    }];
//    [self.baseSheet mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(weakSelf);
//        make.top.equalTo(weakSelf.mas_bottom);
//    }];
}


- (void)show
{
    [self layoutIfNeeded];
    float height = CGRectGetHeight(self.baseSheet.frame);
    self.baseSheetTop.constant = - height;
    
//    __weak __typeof(&*self)weakSelf = self;
//    [self.baseSheet mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(weakSelf);
//        make.top.equalTo(weakSelf.mas_bottom).offset(-height);
//    }];
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^() {
                         self.blureView.alpha = self.blurAlpha;
                         [self layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         
                     }];
    
}


- (void)hidden
{
    self.baseSheetTop.constant = 0;
//    __weak __typeof(&*self)weakSelf = self;
//    [self.baseSheet mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(weakSelf);
//        make.top.equalTo(weakSelf.mas_bottom);
//    }];
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^() {
                         self.blureView.alpha = 0.0;
                         [self layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (void)addGestrue {
    [self.blureView addGestureRecognizer:self.tapGesture];
}

- (void)addKeyboardNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - event response

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    CGRect rect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIView *firstResponderView = [self getFirstResponderView];
    CGRect frFrame = [firstResponderView.superview convertRect:firstResponderView.frame toView:self];
    float offsetY = -(CGRectGetMaxY(frFrame)+CGRectGetHeight(rect)-[UIScreen mainScreen].bounds.size.height);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.baseSheet.transform = CGAffineTransformMakeTranslation(0, offsetY);
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.baseSheet.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}


- (UIView *)getFirstResponderView {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
#pragma clang diagnostic pop
    return firstResponder;
}

#pragma mark - set and get

- (UIView *)baseSheet {
    if (_baseSheet == nil) {
        _baseSheet = [[UIView alloc] init];
        _baseSheet.backgroundColor = [UIColor whiteColor];
    }
    return _baseSheet;
}

- (UIView *)blureView {
    if (_blureView == nil) {
        _blureView = [[UIView alloc] init];
        _blureView.backgroundColor = [UIColor grayColor];
        _blureView.alpha = self.blurAlpha;
    }
    return _blureView;
}

- (UITapGestureRecognizer *)tapGesture {
    if (_tapGesture == nil) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
    }
    return _tapGesture;
}

- (void)setBlurAlpha:(float)blurAlpha {
    _blurAlpha = blurAlpha;
    self.blureView.alpha = blurAlpha;
}



@end

//
//  BaseActionSheet.h
//  AddPetroleum
//
//  Created by Linyoung on 16/1/22.
//  Copyright © 2016年 Linyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseActionSheet : UIView

@property (strong, nonatomic) UIView * baseSheet;
@property (assign, nonatomic) float blurAlpha;

- (void)show;
- (void)hidden;
///添加手势
- (void)addGestrue;
//添加监听
- (void)addKeyboardNotificationObserver;

@end

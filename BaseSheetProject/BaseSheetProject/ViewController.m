//
//  ViewController.m
//  BaseSheetProject
//
//  Created by Linyoung on 2017/5/24.
//  Copyright © 2017年 Linyoung. All rights reserved.
//

#import "ViewController.h"
#import "TestActionSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *showBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, 80, 35)];
    [showBtn setTitle:@"显示" forState:UIControlStateNormal];
    [showBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [showBtn addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showAction:(UIButton *)sender {
    TestActionSheet *sheet = [[TestActionSheet alloc] init];
    //添加监听键盘
    [sheet addKeyboardNotificationObserver];
    //添加手势
    [sheet addGestrue];
    [sheet show];
}



@end

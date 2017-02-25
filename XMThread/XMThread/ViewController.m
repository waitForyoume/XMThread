//
//  ViewController.m
//  XMThread
//
//  Created by 街路口等你 on 17/2/25.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "ViewController.h"
#import "NSOperationViewController.h"
#import "GCDViewController.h"
#import "NSThreadViewController.h"
#import "PThreadViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20, 40);
    [btn1 setTitle:@"pThread" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(pThreadAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(10, 150, [UIScreen mainScreen].bounds.size.width - 20, 40);
    [btn2 setTitle:@"NSThread" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(nsThreadAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(10, 200, [UIScreen mainScreen].bounds.size.width - 20, 40);
    [btn3 setTitle:@"GCD" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(gcdAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(10, 250, [UIScreen mainScreen].bounds.size.width - 20, 40);
    [btn4 setTitle:@"NSOperation" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(nsOperationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
}

- (void)pThreadAction {
    PThreadViewController *pThread = [[PThreadViewController alloc] init];
    [self.navigationController pushViewController:pThread animated:YES];
}

- (void)nsThreadAction {
    NSThreadViewController *nsThread = [[NSThreadViewController alloc] init];
    [self.navigationController pushViewController:nsThread animated:YES];
}

- (void)gcdAction {
    GCDViewController *gcd = [[GCDViewController alloc] init];
    [self.navigationController pushViewController:gcd animated:YES];
}

- (void)nsOperationAction {
    NSOperationViewController *oper = [[NSOperationViewController alloc] init];
    [self.navigationController pushViewController:oper animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

@end

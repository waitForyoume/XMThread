//
//  NSThreadViewController.m
//  XMThread
//
//  Created by 街路口等你 on 17/2/25.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "NSThreadViewController.h"
#import "TicketManager.h"

@interface NSThreadViewController ()

@end

@implementation NSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TicketManager *manager = [[TicketManager alloc] init];
    [manager startToSale];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

// 通过alloc init 的方式创建并执行线程
- (void)threadOne {
    NSLog(@"主线程");
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(runThread) object:nil];
    
    thread.name = @"NSThread"; // 给线程起名字, 方便定位Bug
    thread.threadPriority = 1.0; // 设置线程的优先级
    [thread start]; // 线程就绪
}

// 通过detachNewThreadSelector 方式创建并执行线程
- (void)threadTwo {
    NSLog(@"主线程");
    [NSThread detachNewThreadSelector:@selector(runThread) toTarget:self withObject:nil];
}

// 通过performSelectorInBackground 方式创建线程
- (void)threadThree {
    [self performSelectorInBackground:@selector(runThread) withObject:nil];
}

- (void)runThread {
    NSLog(@"子线程 %@", [NSThread currentThread].name);
    for (int i = 0; i <= 5; i++) {
        NSLog(@"i = %d", i);
        sleep(2);
        if (i == 5) {
            [self performSelectorOnMainThread:@selector(runMainThread) withObject:nil waitUntilDone:YES];
        }
    }
}

- (void)runMainThread {
    NSLog(@"回到主线程中执行");
}

@end

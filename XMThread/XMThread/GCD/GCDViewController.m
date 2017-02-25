//
//  GCDViewController.m
//  XMThread
//
//  Created by 街路口等你 on 17/2/25.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self runWithGCDFour];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

- (void)runWithGCDOne {
    NSLog(@"执行GCD");
    
    // DISPATCH_QUEUE_PRIORITY_LOW
    // DISPATCH_QUEUE_PRIORITY_DEFAULT
    // DISPATCH_QUEUE_PRIORITY_HIGH
    // DISPATCH_QUEUE_PRIORITY_BACKGROUND
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 执行耗时操作
        NSLog(@"start task one");
        
        [NSThread sleepForTimeInterval:5]; // 睡眠5s
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 回到主线程刷新UI
            NSLog(@"刷新UI");
        });
    });
}

- (void)runWithGCDTwo {
    NSLog(@"主线程 GCD");
    // DISPATCH_QUEUE_CONCURRENT 并行
    // DISPATCH_QUEUE_SERIAL NULL 串行
    dispatch_queue_t queue = dispatch_queue_create("com.xm.gcd.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"start task one");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end tast one");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"start task two");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end tast one");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"start task three");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end tast three");
    });
}

- (void)runWithGCDThree {
    NSLog(@"主线程 GCD");
    dispatch_queue_t queue = dispatch_queue_create("com.xm.gcd.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"start task one");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end tast one");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"start task two");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end task two");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"start task three");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"start task three");
    });
}

- (void)runWithGCDFour {
    NSLog(@"主线程 GCD");
    dispatch_queue_t queue = dispatch_queue_create("com.xm.gcd.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [self sendRueqestOne:^{
        NSLog(@"request one done");
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self sendRueqestTwo:^{
        NSLog(@"request two done");
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"All tasks over");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程刷新UI");
        });
    });
}

- (void)sendRueqestOne:(void(^)())block {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"start task one");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end tast one");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
    });
}

- (void)sendRueqestTwo:(void(^)())block {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"start task two");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end task two");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
    });
}

#pragma mark - single

- (void)runWithSingle {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"excute only one");
    });
}

#pragma mark - 延迟执行

- (void)runWithTime {
    NSLog(@"---begin---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"delay excute");
    });
}

@end

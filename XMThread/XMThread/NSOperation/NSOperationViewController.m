//
//  NSOperationViewController.m
//  XMThread
//
//  Created by 街路口等你 on 17/2/25.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "NSOperationViewController.h"
#import "CustomOperation.h"

@interface NSOperationViewController ()

@property (nonatomic, strong) NSOperationQueue *operQueue;

@end

@implementation NSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self runWithBlockOper];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

- (void)runWithInvocationOper {
    NSLog(@"主线程");
    NSInvocationOperation *invocationOper = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationAction) object:nil];
    [invocationOper start];
}

- (void)invocationAction {
    for (int i = 0; i < 3; i++) {
        NSLog(@"---%d---", i);
        [NSThread sleepForTimeInterval:2];
    }
}

- (void)runWithBlockOper {
    NSLog(@"主线程: %@", [NSThread currentThread]);
    NSBlockOperation *blockOper = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"当前线程: %@", [NSThread currentThread]);
    }];
    
    [blockOper addExecutionBlock:^{
        NSLog(@"当前线程: %@", [NSThread currentThread]);
    }];
    
    [blockOper addExecutionBlock:^{
        NSLog(@"当前线程: %@", [NSThread currentThread]);
    }];
    
    [blockOper start];
}

- (void)runWithOperQueue {
    if (!self.operQueue) {
        self.operQueue = [[NSOperationQueue alloc] init];
    }
    
    [self.operQueue setMaxConcurrentOperationCount:2]; // 最大线程数
    
    CustomOperation *operationOne = [[CustomOperation alloc] initWithName:@"A"];
    CustomOperation *operationTwo = [[CustomOperation alloc] initWithName:@"B"];
    CustomOperation *operationThree = [[CustomOperation alloc] initWithName:@"C"];
    CustomOperation *operationFour = [[CustomOperation alloc] initWithName:@"D"];
    
    [operationOne setCompletionBlock:^{
        
    }];
    
    [operationFour addDependency:operationOne];
    [operationOne addDependency:operationThree];
    [operationThree addDependency:operationTwo];
    
    [self.operQueue addOperation:operationOne];
    [self.operQueue addOperation:operationTwo];
    [self.operQueue addOperation:operationThree];
    [self.operQueue addOperation:operationFour];
    
    NSLog(@"end");
}

@end

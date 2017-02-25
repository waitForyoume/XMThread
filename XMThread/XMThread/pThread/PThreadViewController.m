//
//  PThreadViewController.m
//  XMThread
//
//  Created by 街路口等你 on 17/2/25.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "PThreadViewController.h"
#include <pthread.h>

@interface PThreadViewController ()

@end

@implementation PThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"我在主线程执行");
    pthread_t pthread;
    pthread_create(&pthread, NULL, run, NULL);
}

void *run(void *data) {
    NSLog(@"我在子线程中执行");
    for (int i = 0; i < 5; i++) {
        NSLog(@"%d", i);
        sleep(2);
    }
    return NULL;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

@end

//
//  CustomOperation.m
//  XMThread
//
//  Created by 街路口等你 on 17/2/25.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "CustomOperation.h"

@interface CustomOperation ()

@property (nonatomic, copy) NSString *operName;
@property BOOL over;

@end

@implementation CustomOperation

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.operName = name;
    }
    return self;
}

- (void)main {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:1];
        if (self.cancelled) {
            return ;
        }
        
        NSLog(@"NSOperation: %@", self.operName);
        self.over = YES;
    });
    
    while (!self.over && !self.cancelled) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

@end

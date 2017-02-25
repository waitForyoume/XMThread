//
//  TicketManager.m
//  XMThread
//
//  Created by 街路口等你 on 17/2/25.
//  Copyright © 2017年 街路口等你. All rights reserved.
//

#import "TicketManager.h"

#define Total 50

@interface TicketManager ()

@property int tickets; // 剩余票数
@property int saleCount; // 卖出票数

@property (nonatomic, strong) NSThread *threadBJ;
@property (nonatomic, strong) NSThread *threadHB;
@property (nonatomic, strong) NSCondition *ticketCondition;

@end


@implementation TicketManager

- (instancetype)init {
    if (self = [super init]) {
        self.tickets = Total;
        self.ticketCondition = [[NSCondition alloc] init];
        self.threadBJ = [[NSThread alloc] initWithTarget:self selector:@selector(sale) object:nil];
        self.threadBJ.name = @"BJThread";
        
        self.threadHB = [[NSThread alloc] initWithTarget:self selector:@selector(sale) object:nil];
        self.threadHB.name = @"HBThread";
    }
    return self;
}

- (void)sale {
    
    // 枷锁
    @synchronized (self) {
        
    }
    
    while (true) {
        [self.ticketCondition lock];
        if (self.tickets > 0) {
            [NSThread sleepForTimeInterval:1];
            self.tickets --;
            self.saleCount = Total - self.tickets;
            
            NSLog(@"%@: 当前余票: %d, 售出: %d", [NSThread currentThread].name, self.tickets, self.saleCount);
        }
        [self.ticketCondition unlock];
    }
    
}

- (void)startToSale {
    [self.threadBJ start];
    [self.threadHB start];
}

@end

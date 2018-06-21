//
//  GroupViewController.m
//  iOS Test
//
//  Created by linkiing on 2018/6/19.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController ()

//总票数
@property (nonatomic, assign) NSInteger ticketCount;
@property (nonatomic) dispatch_semaphore_t semaphoreLock;

@end

@implementation GroupViewController

#pragma mark - GCD练习
- (void)initGCD{
    //[self creatGCD1];
    //[self creatGCD2];
    //[self creatGCD3];
    //[self creatGCD4];
    //[self creatGCD5];
    [self creatGCD6];
}
- (void)creatGCD1{
    /**
     1.同步执行 + 并发队列
     2.异步执行 + 并发队列
     3.同步执行 + 串行队列
     4.异步执行 + 串行队列
     5.同步执行 + 主队列
     6.异步执行 + 主队列
     **/
    //串行队列的创建
    dispatch_queue_t serial_queue = dispatch_queue_create("serial_queue", DISPATCH_QUEUE_SERIAL);
    //并行队列的创建
    dispatch_queue_t concurrent_queue = dispatch_queue_create("concurrent_queue", DISPATCH_QUEUE_CONCURRENT);
    //主队列
    dispatch_queue_t main_queue = dispatch_get_main_queue();
    //全局并行队列
    dispatch_queue_t global_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //同步执行任务
    dispatch_sync(serial_queue, ^{
        
    });
    //异步执行任务
    dispatch_sync(concurrent_queue, ^{
        
    });
    dispatch_async(main_queue, ^{
        
    });
    dispatch_async(global_queue, ^{
        
    });
}
- (void)creatGCD2{
    //GCD线程间的通信
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t main_queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"1---%@",[NSThread currentThread]);
        }
        dispatch_async(main_queue, ^{
            NSLog(@"2---%@",[NSThread currentThread]);
        });
    });
    
    //延时线程
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0*NSEC_PER_SEC)), main_queue, ^{
        NSLog(@"after---%@",[NSThread currentThread]);
    });
    
    //只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"线程只执行一次");
    });
    
    //快速迭代方法，循环遍历队列
    NSLog(@"apply---begin");
    dispatch_apply(6, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        NSLog(@"%zd---%@",index, [NSThread currentThread]);
    });
    NSLog(@"apply---end");
}
- (void)creatGCD3{
    //GCD 栅栏方法：dispatch_barrier_async
    /**
     我们有时需要异步执行两组操作，而且第一组操作执行完之后，才能开始执行第二组操作。这样我们就需要一个相当于 栅栏 一样的一个方法将两组异步执行的操作组给分割起来，当然这里的操作组里可以包含一个或多个任务。这就需要用到dispatch_barrier_async方法在两个操作组间形成栅栏。
     dispatch_barrier_async函数会等待前边追加到并发队列中的任务全部执行完毕之后，再将指定的任务追加到该异步队列中。然后在dispatch_barrier_async函数追加的任务执行完毕之后，异步队列才恢复为一般动作，接着追加任务到该异步队列并开始执行。
     **/
    dispatch_queue_t queue = dispatch_queue_create("concurrent_queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"1---%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    dispatch_barrier_async(queue, ^{
        //会等前面的异步函数执行完毕后再执行
        for (NSInteger i=0; i<2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"barrier---%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"3---%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"4---%@",[NSThread currentThread]);
        }
    });
}
- (void)creatGCD4{
    //组队列
    NSLog(@"group---begin");
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"1---%@",[NSThread currentThread]);
        }
    });
    
    //等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"group---wait");
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //等前面的异步任务1、任务2都执行完毕后，回到主线程执行下边任务
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"3---%@",[NSThread currentThread]);
        }
        NSLog(@"group---end");
    });
}
- (void)creatGCD5{
    //利用 Dispatch Semaphore 实现线程同步，将异步执行任务转换为同步执行任务
    NSLog(@"semaphore---begin");
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建一个新的可计数的信号量0
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block int number = 0;
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"%@",[NSThread currentThread]);
        number = 100;
        //增加信号量为1
        dispatch_semaphore_signal(semaphore);
    });
    //等待异步执行任务结果的信号才会继续执行(如果信号量大于0信号量减1，执行程序。否则等待信号量)
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"semaphore---end,number = %d",number);
}
- (void)creatGCD6{
    /**
     线程安全：使用 semaphore 加锁
     初始化火车票数量(50张)、卖票窗口(线程安全)、并开始卖票
     **/
    //创建信号量为1
    _semaphoreLock = dispatch_semaphore_create(1);
    _ticketCount = 50;
    dispatch_queue_t serial_queue1 = dispatch_queue_create("serial_queue1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t serial_queue2 = dispatch_queue_create("serial_queue2", DISPATCH_QUEUE_SERIAL);
    __weak typeof(self) weakSelf  = self;
    dispatch_async(serial_queue1, ^{
        [weakSelf saleTicketSafe];
    });
    dispatch_async(serial_queue2, ^{
        [weakSelf saleTicketSafe];
    });
}
- (void)saleTicketSafe{
    while (1) {
        //相当于加锁-只有当信号量大于0的时候，线程将信号量减1，程序向下执行
        dispatch_semaphore_wait(_semaphoreLock, DISPATCH_TIME_FOREVER);
        if (_ticketCount>0) {
            _ticketCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", (long)_ticketCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        } else {
            NSLog(@"所有火车票均已售完");
            //相当于解锁
            dispatch_semaphore_signal(_semaphoreLock);
            break;
        }
        //相当于解锁-信号量加1
        dispatch_semaphore_signal(_semaphoreLock);
    }
}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initGCD];//GCD练习
    [[NSNotificationCenter defaultCenter] postNotificationName:GROUPNOTIFICATION object:@"通知传值"];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    _returnBlock(@"Block传值");
    if (_delegate&&[_delegate respondsToSelector:@selector(getGroupResponseFunction:)]) {
        [_delegate getGroupResponseFunction:@"Delegate代理传值"];
    }
}
- (void)request:(NSString *)title andBlock:(void(^)(BOOL isBlock))completion{
    NSLog(@"%@",title);
    completion(YES);
}

@end

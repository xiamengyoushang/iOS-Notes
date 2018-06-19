//
//  ViewController.m
//  iOS Test
//
//  Created by linkiing on 2018/6/19.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "ViewController.h"
#import "GroupViewController.h"
#import "Person.h"

typedef enum{
    TEST_KVO = 0,
    TEST_KVC,
}TEST_FUNCTION;

@interface ViewController ()<GroupResponseDelegate>

@property (nonatomic, strong) Person *person;
@property (nonatomic, assign) TEST_FUNCTION function;

//总票数
@property (nonatomic, assign) NSInteger ticketCount;
@property (nonatomic) dispatch_semaphore_t semaphoreLock;

@end

@implementation ViewController

#pragma mark - Initialize
- (void)Initialize{
    _person = [[Person alloc] init];
    _person.name = @"小明";
    //[self creatKVO];
    //[self creatKVC];
    //[self creatKeyWords];
    [self initGCD];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(groupNotification:) name:GROUPNOTIFICATION object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self Initialize];
}
#pragma mark - KVO观察者
- (void)creatKVO{
    _function = TEST_KVO;
    [_person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
}
#pragma mark - KVC键值对
- (void)creatKVC{
    _function = TEST_KVC;
    [_person setValue:@"KVC_小李" forKey:@"name"];
}
#pragma mark - 关键字区别
- (void)creatKeyWords{
    //assign weak retain strong copy关键字的区别
    /**
     assign：用于对基本数据类型进行赋值操作，不更改引用计数。也可以用来修饰对象，但是，被assign修饰的对象在释放后，指针的地址还是存在的，也就是说指针并没有被置为nil，成为野指针。如果后续在分配对象到堆上的某块内存时，正好分到这块地址，程序就会crash。之所以可以修饰基本数据类型，因为基本数据类型一般分配在栈上，栈的内存会由系统自动处理，不会造成野指针。
     
     weak：修饰Object类型，修饰的对象在释放后，指针地址会被置为nil，是一种弱引用。在ARC环境下，为避免循环引用，往往会把delegate属性用weak修饰；在MRC下使用assign修饰。weak和strong不同的是：当一个对象不再有strong类型的指针指向它的时候，它就会被释放，即使还有weak型指针指向它，那么这些weak型指针也将被清除。
     
     ARC下的strong等同于MRC下的retain都会把对象引用计数加1。
     
     copy：会在内存里拷贝一份对象，两个指针指向不同的内存地址。一般用来修饰NSString等有对应可变类型的对象，因为他们有可能和对应的可变类型（NSMutableString）之间进行赋值操作，为确保对象中的字符串不被修改 ，应该在设置属性是拷贝一份。而若用strong修饰，如果对象在外部被修改了，会影响到属性。
     
     block属性为什么需要用copy来修饰？
     因为在MRC下，block在创建的时候，它的内存是分配在栈(stack)上的，而不是在堆(heap)上，可能被随时回收。他本身的作于域是属于创建时候的作用域，一旦在创建时候的作用域外面调用block将导致程序崩溃。通过copy可以把block拷贝（copy）到堆，保证block的声明域外使用。在ARC下写不写都行，编译器会自动对block进行copy操作。
     
     __block与__weak的区别
     __block：在ARC和MRC下都可用，可修饰对象，也可以修饰基本数据类型。
     __block对象可以在block被重新赋值，__weak不可以。
     __weak：只在ARC中使用，只能修饰对象，不能修饰基本数据类型（int、bool）。
     同时，在ARC下，要避免block出现循环引用，经常会：__weak typedof(self) weakSelf = self;
     **/
    //__weak typeof(self) weakSelf = self;
}
#pragma mark - GCD
- (void)initGCD{
    //[self creatGCD1];
    //[self creatGCD2];
    //[self creatGCD3];
    //[self creatGCD4];
    //[self creatGCD5];
    //[self creatGCD6];
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
#pragma mark - UIButton
- (IBAction)clickFunctionBtn:(UIButton *)sender {
    switch (_function) {
        case TEST_KVO:
            _person.name = @"小李";
            break;
        case TEST_KVC:
            NSLog(@"%@",[_person valueForKey:@"name"]);
            break;
    }
}
- (IBAction)clickEnterNextBtn:(UIButton *)sender {
    GroupViewController *groupctl = [[GroupViewController alloc] init];
    groupctl.returnBlock = ^(NSString *blockString) {
        NSLog(@"%@",blockString);
    };
    groupctl.delegate = self;
    [groupctl request:@"界面传值" andBlock:^(BOOL isBlock) {
        if (isBlock) {
            NSLog(@"Block事件完成");
        }
    }];
    [self.navigationController pushViewController:groupctl animated:YES];
}
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@监听到%@属性的改变为%@",object,keyPath,change);
}
#pragma mark - NSNotification
- (void)groupNotification:(NSNotification *)notification{
    NSString *notifydata=(NSString *)[notification object];
    NSLog(@"%@",notifydata);
}
#pragma mark - GroupResponseDelegate
- (void)getGroupResponseFunction:(NSString *)delegateString{
    NSLog(@"%@",delegateString);
}
- (void)dealloc{
    [_person removeObserver:self forKeyPath:@"name"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GROUPNOTIFICATION object:nil];
}

@end

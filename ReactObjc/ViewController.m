//
//  ViewController.m
//  ReactObjc
//
//  Created by 李刚 on 2018/3/26.
//  Copyright © 2018年 李刚. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "LGView.h"

@interface ViewController ()

//@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self initButton];
//    [self initView];
//    [self RACSignalTest];
//    [self RACSubjectTest];
//    [self RACReplaySubjectTest];
    [self delegateTest];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- 监听事件(按钮点击)

- (void)initButton {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 40)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"按钮点击" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"LG--buttonTaped!");
    }];
}

- (void)initView {
    LGView *view = [[LGView alloc] initWithFrame:CGRectMake(100, 300, 200, 100)];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    
    // 如果调用了testFunc方法，则会执行block
    [[view rac_signalForSelector:@selector(testFunc)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"LG--testFunc-1");
    }];
    
    [view testFunc];
}

// RACSignal的使用
- (void)RACSignalTest {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"执行signal的block");
        [subscriber sendNext:@9];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号被销毁");
        }];
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到数据：%@", x);
    }];
}

// RACSubject的使用
- (void)RACSubjectTest {
    // 1. 创建
    RACSubject *subject = [RACSubject subject];
    
    // 2. 订阅1
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅1--%@", x);
    }];
    
    // 3. 订阅2
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅2--%@", x);
    }];
    
    // 4. 发送信号
    [subject sendNext:@2];
}

// RACReplaySubjectTest的使用
- (void)RACReplaySubjectTest {
    // 1.创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 2.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    // 3.订阅信号
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];
}

// RACSubject替换代理
- (void)delegateTest {
    LGView *view = [[LGView alloc] initWithFrame:self.view.frame];
    view.delegateSignal = [RACSubject subject];
    [view.delegateSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到代理-%@", x);
    }];
    [self.view addSubview:view];
    
}


@end

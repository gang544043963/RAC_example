//
//  LGView.m
//  ReactObjc
//
//  Created by 李刚 on 2018/3/26.
//  Copyright © 2018年 李刚. All rights reserved.
//

#import "LGView.h"

@implementation LGView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 40)];
        btn.backgroundColor = [UIColor purpleColor];
        [btn addTarget:self action:@selector(btnTouched) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

- (void)btnTouched {
    NSLog(@"btnTouched");
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@"6"];
    }
}

- (void)testFunc {
    NSLog(@"LG--testFunc");
}

@end

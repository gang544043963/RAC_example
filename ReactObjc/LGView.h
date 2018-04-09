//
//  LGView.h
//  ReactObjc
//
//  Created by 李刚 on 2018/3/26.
//  Copyright © 2018年 李刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface LGView : UIView

@property (nonatomic,strong) RACSubject *delegateSignal;

- (void)testFunc;

@end

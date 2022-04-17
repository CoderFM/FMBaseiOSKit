//
//  FMProtocolInterceptor.m
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2021/9/11.
//  Copyright © 2021 zhoufaming251@163.com. All rights reserved.
//

#import "FMProtocolInterceptor.h"

@implementation FMProtocolInterceptor {
    id _target;
    id _realTarget;
    FMProtocolInterceptorType type;
    BOOL shouldForward;
}

- (void)dealloc{
    NSLog(@"FMProtocolInterceptor dealloc");
}

- (void)setType:(FMProtocolInterceptorType)type{
    self->type = type;
}

- (FMProtocolInterceptorType)type{
    return self->type;
}

+ (instancetype)initWithTarget:(id)target realTarget:(id)realTarget{
    FMProtocolInterceptor *interceptor = [FMProtocolInterceptor alloc];
    
    interceptor->_target = target;
    interceptor->_realTarget = realTarget;
    interceptor->type = FMProtocolInterceptorTypeAlways;
    interceptor->shouldForward = YES;
    
    return interceptor;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    NSMethodSignature *signature = [_target methodSignatureForSelector:sel];
    if (signature) {
        return signature;
    }
    return [_realTarget methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    SEL selector = invocation.selector;
    if (self->shouldForward && [_target respondsToSelector:selector]) {
        [invocation setTarget:_target];
        if (self->type == FMProtocolInterceptorTypeOnce) {
            self->shouldForward = NO;
        }
    } else {
        [invocation setTarget:_realTarget];
    }
    [invocation invoke];
}

@end

//
//  FMProtocolInterceptor.h
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2021/9/11.
//  Copyright © 2021 zhoufaming251@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FMProtocolInterceptorType) {
    FMProtocolInterceptorTypeAlways,
    FMProtocolInterceptorTypeOnce,
};

@interface FMProtocolInterceptor : NSProxy

@property(nonatomic, assign)FMProtocolInterceptorType type;

+ (instancetype)initWithTarget:(id)target realTarget:(id)realTarget;

@end

NS_ASSUME_NONNULL_END

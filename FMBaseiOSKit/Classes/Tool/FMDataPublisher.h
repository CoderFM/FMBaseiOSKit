//
//  FMDataPublisher.h
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2021/4/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FMDataObserveBlock)(id data);
typedef void(^FMDataObserveDisposeBlock)(id obj);

@interface FMDataPublisher<DataType> : NSObject

@property(nonatomic, copy, readonly)FMDataObserveDisposeBlock lifeCircle;

- (void)publish:(DataType)data;
- (void)addObserve:(FMDataObserveBlock)block;

@end

NS_ASSUME_NONNULL_END

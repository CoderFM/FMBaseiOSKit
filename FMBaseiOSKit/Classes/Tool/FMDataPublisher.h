//
//  FMDataPublisher.h
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2021/4/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMDataPublisher<DataType> : NSObject

- (void)publish:(DataType)data;
- (void)observe:(void(^)(DataType data))block;

@end

NS_ASSUME_NONNULL_END

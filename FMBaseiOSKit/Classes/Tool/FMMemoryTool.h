//
//  FMMemoryTool.h
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/9/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMMemoryTool : NSObject

+ (double)availableMemory;
+ (double)usedMemory;
+ (double)usedMemoryWithObject:(NSObject *)object;

@end

NS_ASSUME_NONNULL_END

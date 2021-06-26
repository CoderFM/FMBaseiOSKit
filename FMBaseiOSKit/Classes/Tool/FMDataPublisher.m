//
//  FMDataPublisher.m
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2021/4/29.
//

#import "FMDataPublisher.h"

@interface FMDataPublisher ()

@property(nonatomic, copy)void(^observeBlock)(id data);

@end

@implementation FMDataPublisher

- (void)publish:(id)data{
    if (self.observeBlock) {
        self.observeBlock(data);
    }
}
- (void)observe:(void(^)(id data))block{
    self.observeBlock = block;
}
- (instancetype)initWithExcute:(void(^)(FMDataPublisher *publish))excute{
    if (self = [super init]) {
        excute(self);
    }
    return self;
}

@end

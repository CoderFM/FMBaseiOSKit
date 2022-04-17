//
//  FMDataPublisher.m
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2021/4/29.
//

#import "FMDataPublisher.h"

NSMapTable *_getFMDataPublisherCache() {
    static NSMapTable *_FMDataPublisherCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _FMDataPublisherCache = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsStrongMemory];
    });
    return _FMDataPublisherCache;
}

static inline void _storePublisher(FMDataPublisher *publisher, id value) {
    NSMutableArray *valueCachesPublishers = [_getFMDataPublisherCache() objectForKey:value];
    if (valueCachesPublishers == nil) {
        valueCachesPublishers = [NSMutableArray array];
        [_getFMDataPublisherCache() setObject:valueCachesPublishers forKey:value];
    }
    [valueCachesPublishers addObject:publisher];
}

@interface FMDataPublisher ()

@property(nonatomic, strong)NSMutableArray<FMDataObserveBlock> *observers;

@end

@implementation FMDataPublisher

- (FMDataObserveDisposeBlock)lifeCircle{
    return ^(id value){
        _storePublisher(self, value);
    };
}

- (void)dealloc{
    NSLog(@"FMDataPublisher dealloc");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.observers = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithExcute:(void(^)(FMDataPublisher *publish))excute{
    if (self = [self init]) {
        excute(self);
    }
    return self;
}


- (void)publish:(id)data{
    for (FMDataObserveBlock block in self.observers) {
        block(data);
    }
}

- (void)addObserve:(FMDataObserveBlock)block{
    if (![self.observers containsObject:block]) {
        [self.observers addObject:block];
    }
}

@end

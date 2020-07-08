//
//  NSDictionary+FMExtension.m
//  ChaZhiJia
//
//  Created by 郑桂华 on 2020/4/22.
//  Copyright © 2020 ZhouFaMing. All rights reserved.
//

#import "NSDictionary+FMExtension.h"

@implementation NSDictionary (FMExtension)

- (NSString *)toString{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingFragmentsAllowed error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end

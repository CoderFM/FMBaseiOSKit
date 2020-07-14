//
//  FMCollectionCustomDecoration.m
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2020/7/14.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMCollectionCustomDecoration.h"
#import <UIColor+FMExtension.h>

@implementation FMCollectionCustomDecoration

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor randomColor];
    }
    return self;
}


@end

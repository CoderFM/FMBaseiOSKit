//
//  FMCollectionViewCell.m
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2020/7/14.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMCollectionViewCell.h"
#import <UIColor+FMExtension.h>

@implementation FMCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor randomColor];
    }
    return self;
}

@end

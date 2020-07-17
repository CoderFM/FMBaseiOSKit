//
//  FMBaseSheetLayoutView.m
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/7/17.
//

#import "FMBaseSheetLayoutView.h"
#import <FMLayoutKit/FMLayoutKit.h>
#import <Masonry/Masonry.h>
#import "UIColor+FMExtension.h"

@implementation FMBaseSheetLayoutView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        FMLayoutView *view = [[FMLayoutView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(56);
        }];
        
        NSMutableArray *sections = [NSMutableArray array];
        {
            FMLayoutFixedSection *section = [FMLayoutFixedSection sectionWithSectionInset:UIEdgeInsetsMake(0, 15, 0, 15) itemSpace:10 lineSpace:10 column:4];
            section.itemSize = CGSizeMake(80, 80);
            section.cellElement = [FMLayoutElement elementWithViewClass:[UICollectionViewCell class]];
            section.itemDatas = [@[@"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1"] mutableCopy];
            [section setConfigureCellData:^(FMLayoutBaseSection * _Nonnull section, UICollectionViewCell * _Nonnull cell, NSInteger item) {
                cell.contentView.backgroundColor = [UIColor randomColor];
            }];
            [sections addObject:section];
        }
        view.sections = sections;
        self.layoutView = view;
    }
    return self;
}

@end

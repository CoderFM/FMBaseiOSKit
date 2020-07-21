//
//  FMTimeLineViewController.m
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2020/7/17.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMTimeLineViewController.h"
#import "FMCollectionCustomCell.h"
#import "FMCollectionCustomDecoration.h"
#import "FMCollectionViewCell.h"

@interface FMLayoutTimeLineSection : FMLayoutDynamicSection


///单张时  最大宽度
@property(nonatomic, assign)CGFloat oneMaxWidth;
///单张时  最大高度
@property(nonatomic, assign)CGFloat oneMaxHeight;

///多张时  大小   默认3列
@property(nonatomic, assign)CGSize size;

///2个和4个的时候  列数 默认为3列
@property(nonatomic, assign)NSInteger twoOrFourCloumn;
///2个和4个的时候  单个大小
@property(nonatomic, assign)CGSize twoOrFourSize;

@end

@implementation FMLayoutTimeLineSection


- (NSInteger)twoOrFourCloumn{
    if (_twoOrFourCloumn == 0) {
        _twoOrFourCloumn = self.column;
    }
    return _twoOrFourCloumn;
}

- (CGSize)twoOrFourSize{
    if (CGSizeEqualToSize(_twoOrFourSize, CGSizeZero)) {
        _twoOrFourSize = self.size;
    }
    return _twoOrFourSize;
}

- (FMCollectionLayoutAttributes *)getItemAttributesWithIndex:(NSInteger)index{
    if (self.itemCount == 1) { //单张
        FMCollectionLayoutAttributes *attrs = [FMCollectionLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:index inSection:self.indexPath.section]];
        attrs.frame = CGRectMake(self.firstItemStartX, self.firstItemStartY, self.oneMaxWidth, self.oneMaxHeight);
        self.columnSizes[@(0)] = @(attrs.frame.size.height);
        return attrs;
    } else  {
        CGSize itemSize;
        if ((self.itemCount == 2 || self.itemCount == 4) &&  (!CGSizeEqualToSize(self.twoOrFourSize, self.size))) {//两张或者4张
            itemSize = self.twoOrFourSize;
        } else { //其他张数
            itemSize = self.size;
        }
        FMCollectionLayoutAttributes *itemAttr = [FMCollectionLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:index inSection:self.indexPath.section]];
        NSInteger column = [self getMinHeightColumn];
        CGFloat x = self.sectionInset.left + column * (self.itemSpace + itemSize.width);
        CGFloat height = [self.columnSizes[@(column)] floatValue];
        CGFloat y = self.firstItemStartY + (height > 0 ? (height + self.lineSpace) : height);
        itemAttr.frame = CGRectMake(x, y, itemSize.width, itemSize.height);
        self.columnSizes[@(column)] = @(height + itemSize.height + (height > 0 ? self.lineSpace : 0));
        return itemAttr;
    }
}

- (void)resetcolumnSizes{
    if ((self.itemCount == 2 || self.itemCount == 4) && self.column != self.twoOrFourCloumn) {
        self.column = self.twoOrFourCloumn;
    }
    [super resetcolumnSizes];
}

@end

@interface FMTimeLineViewController ()

@end

@implementation FMTimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseNavItem.title = @"朋友圈动态布局";
    [self addSections];
//    [self.collectionView reloadData];
}

- (void)addSections{
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *subSections = [NSMutableArray array];
        {
            FMLayoutFixedSection *section = [FMLayoutFixedSection sectionWithSectionInset:UIEdgeInsetsMake(0, 0, 0, 0) itemSpace:10 lineSpace:10 column:2];
            
            section.itemSize = CGSizeMake(150, 100);
            section.itemDatas = [@[@"1", @"2", @"3", @"2", @"3", @"2", @"3", @"2", @"3", @"2", @"3"] mutableCopy];
            section.cellElement = [FMLayoutElement elementWithViewClass:[FMCollectionCustomCell class]];
            [section setConfigureCellData:^(FMLayoutBaseSection * _Nonnull section, UICollectionViewCell * _Nonnull cell, NSInteger item) {
//                [(FMCollectionCustomCell *)cell label].text = [NSString stringWithFormat:@"%ld", (long)item];
            }];
            [section setClickCellBlock:^(FMLayoutBaseSection * _Nonnull section, NSInteger item) {
                
            }];
            [subSections addObject:section];
        }
        
        {
                    FMLayoutFixedSection *section = [FMLayoutFixedSection sectionWithSectionInset:UIEdgeInsetsMake(0, 0, 0, 0) itemSpace:10 lineSpace:10 column:2];
                    
                    section.itemSize = CGSizeMake(150, 100);
                    section.itemDatas = [@[@"1", @"2", @"3", @"2", @"3", @"2", @"3", @"2", @"3", @"2", @"3"] mutableCopy];
                    section.cellElement = [FMLayoutElement elementWithViewClass:[FMCollectionCustomCell class]];
                    [section setConfigureCellData:^(FMLayoutBaseSection * _Nonnull section, UICollectionViewCell * _Nonnull cell, NSInteger item) {
        //                [(FMCollectionCustomCell *)cell label].text = [NSString stringWithFormat:@"%ld", (long)item];
                    }];
                    [section setClickCellBlock:^(FMLayoutBaseSection * _Nonnull section, NSInteger item) {
                        
                    }];
                    [subSections addObject:section];
                }
        
        {
            FMLayoutTimeLineSection *section = [FMLayoutTimeLineSection sectionWithSectionInset:UIEdgeInsetsMake(10, 10, 10, 10) itemSpace:10 lineSpace:10 column:3];
            
            section.oneMaxHeight = 300;
            section.oneMaxWidth = 200;
            section.size = CGSizeMake(([FMConfig config].screenWidth - 40) / 3.0, ([FMConfig config].screenWidth - 40) / 3.0);
            section.twoOrFourCloumn = 2;
            section.twoOrFourSize = CGSizeMake(([FMConfig config].screenWidth - 30) / 2.0, ([FMConfig config].screenWidth - 30) / 2.0);
            
            section.cellElement = [FMLayoutElement elementWithViewClass:[FMCollectionViewCell class]];
            section.itemDatas = [@[@"1", @"1", @"1", @"1"] mutableCopy];
            [section setConfigureCellData:^(FMLayoutBaseSection * _Nonnull section, UICollectionViewCell * _Nonnull cell, NSInteger item) {
//                [(FMCollectionCustomCell *)cell label].text = [NSString stringWithFormat:@"%ld", (long)item];
            }];
            [section setClickCellBlock:^(FMLayoutBaseSection * _Nonnull section, NSInteger item) {
                
            }];
            [subSections addObject:section];
        }
        
        {
            FMLayoutAbsoluteSection *section = [FMLayoutAbsoluteSection sectionWithSectionInset:UIEdgeInsetsMake(0, 0, 0, 0) itemSpace:0 lineSpace:0 column:0];

            section.itemDatas = [@[@"1", @"2", @"3"] mutableCopy];
            section.cellElements = @[[FMLayoutElement elementWithViewClass:[FMCollectionCustomCell class]]];
            [section setDeqCellReturnReuseId:^NSString * _Nonnull(FMLayoutDynamicSection * _Nonnull section, NSInteger index) {
                return [section.cellElements firstObject].reuseIdentifier;
            }];
            [section setFrameBlock:^CGRect(id  _Nonnull section, NSInteger item) {
                switch (item) {
                    case 0:
                        return CGRectMake(0, 0, 100, 100);
                    case 1:
                        return CGRectMake(200, 100, 150, 100);
                    case 2:
                        return CGRectMake(100, 400, 400, 90);
                    default:
                        return CGRectZero;
                        break;
                }
            }];
            [subSections addObject:section];
        }
        
        
        FMLayoutCombineSection *section = [FMLayoutCombineSection combineSections:subSections];
        section.canLongPressExchange = YES;
        section.header = [FMLayoutHeader elementSize:50 viewClass:[FMCollectionCustomDecoration class]];
        section.header.type = FMLayoutHeaderTypeSuspensionAlways;
        section.header.zIndex = FMLayoutZIndexFrontAlways;
        //        section.header.isStickTop = YES;
        //        section.header.inset = UIEdgeInsetsMake(0, -15, 0, -15);
        [section setConfigureHeaderData:^(FMLayoutBaseSection * _Nonnull section, UICollectionReusableView * _Nonnull header) {
            FMCollectionCustomDecoration *custom = (FMCollectionCustomDecoration *)header;
//            custom.textLabel.text = @"第一个悬浮的顶部视图, 黏在顶部";
        }];
        
        section.footer = [FMLayoutFooter elementSize:100 viewClass:[FMCollectionCustomDecoration class]];
        //        section.footer.inset = UIEdgeInsetsMake(10, 0, 10, 0);
        section.footer.topMargin = 10;
        [sections addObject:section];
        
    }
    self.collectionView.sections = sections;
    [self.collectionView reloadData];
}

@end

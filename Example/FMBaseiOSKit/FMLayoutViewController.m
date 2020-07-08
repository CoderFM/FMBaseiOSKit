//
//  FMLayoutViewController.m
//  FMBaseKit_Example
//
//  Created by 郑桂华 on 2020/7/8.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMLayoutViewController.h"

@interface FMCollectionCustomDecoration : UICollectionReusableView

@end

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

@interface FMCollectionCustomCell : UICollectionViewCell

@end

@implementation FMCollectionCustomCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor randomColor];
    }
    return self;
}

@end

@interface FMLayoutViewController ()

@end

@implementation FMLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"横向布局";
    self.baseNavItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStyleDone target:self action:@selector(changeLayoutDirection)];
    self.sections = [NSMutableArray array];
//    FMLayoutCloseLog()
    
    __weak typeof(self) weakSelf = self;
    {
        FMLayoutFixedSection *section = [FMLayoutFixedSection sectionWithSectionInset:UIEdgeInsetsMake(0, 0, 0, 0) itemSpace:10 lineSpace:10 column:2];

        section.header = [FMLayoutHeader elementSize:50 viewClass:[UICollectionReusableView class]];
        section.header.type = FMLayoutHeaderTypeSuspensionAlways;
        section.header.zIndex = FMLayoutZIndexFrontAlways;
        section.header.isStickTop = YES;
//        section.header.inset = UIEdgeInsetsMake(0, -15, 0, -15);
        [section setConfigureHeaderData:^(FMLayoutBaseSection * _Nonnull section, UICollectionReusableView * _Nonnull header) {
            header.backgroundColor = [UIColor randomColor];
        }];


        section.footer = [FMLayoutFooter elementSize:100 viewClass:[FMCollectionCustomDecoration class]];
//        section.footer.inset = UIEdgeInsetsMake(10, 0, 10, 0);
        section.footer.topMargin = 10;

        section.background = [FMLayoutBackground bgWithViewClass:[UICollectionReusableView class]];
        section.background.inset = UIEdgeInsetsMake(10, 10, 10, 10);
        [section setConfigureBg:^(FMLayoutBaseSection * _Nonnull section, UICollectionReusableView * _Nonnull bg) {
            bg.backgroundColor = [UIColor yellowColor];
        }];
        FMLayoutCrossSection *hSection = [FMLayoutCrossSection sectionAutoWithSection:section];
        hSection.autoMaxSize = NO;
        hSection.size = 300;
        [self.sections addObject:hSection];
    }
    
    {
        FMLayoutFixedSection *section = [FMLayoutFixedSection sectionWithSectionInset:UIEdgeInsetsZero itemSpace:10 lineSpace:10 column:3];

        section.header = [FMLayoutHeader elementSize:100 viewClass:[FMCollectionCustomDecoration class]];
        section.header.lastMargin = 10;
        section.header.type = FMLayoutHeaderTypeSuspensionAlways;
        section.header.zIndex = FMLayoutZIndexFrontAlways;
        section.header.isStickTop = NO;
//        section.header.suspensionTopMargin = 50;
//        section.header.inset = UIEdgeInsetsMake(0, -15, 0, -15);
        
        section.footer = [FMLayoutFooter elementSize:50 viewClass:[FMCollectionCustomDecoration class]];
        section.footer.topMargin = 10;

//        section.isHorizontalCanScroll = YES;
        section.itemSize = CGSizeMake(150, 100);
        section.itemDatas = [@[@"1", @"2", @"3", @"2", @"3", @"2", @"3", @"2", @"3", @"2", @"3"] mutableCopy];
        section.cellElement = [FMLayoutElement elementWithViewClass:[UICollectionViewCell class]];
        [section setClickCellBlock:^(FMLayoutBaseSection * _Nonnull section, NSInteger item) {
            
        }];
        
        FMLayoutCrossSection *hSection = [FMLayoutCrossSection sectionAutoWithSection:section];
        hSection.header = [FMLayoutHeader elementSize:100 viewClass:[FMCollectionCustomDecoration class]];
        [hSection setConfigureHeaderData:^(FMLayoutBaseSection * _Nonnull section, UICollectionReusableView * _Nonnull header) {
            header.backgroundColor = [UIColor randomColor];
        }];
//        [self.shareSections addObject:hSection];
    }
//
    {
        FMLayoutLabelSection *section = [FMLayoutLabelSection sectionWithSectionInset:UIEdgeInsetsMake(0, 10, 0, 10) itemSpace:10 lineSpace:10 column:3];

        section.header = [FMLayoutHeader elementSize:30 viewClass:[FMCollectionCustomDecoration class]];
        section.header.zIndex = FMLayoutZIndexFrontOfItem;
        section.header.type = FMLayoutHeaderTypeFixed;
        section.header.lastMargin = 10;

//        section.isSingleLineCanScroll = YES;
        section.maxLine = 1;
        section.cellFixedHeight = 40;
        [section setWidthBlock:^CGFloat(id  _Nonnull section, NSInteger item) {
            return item * 20 + 100;
        }];
        section.itemDatas = [@[@"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3", ] mutableCopy];
        section.cellElement = [FMLayoutElement elementWithViewClass:[FMCollectionCustomCell class]];
        
        FMLayoutCrossSection *hSection = [FMLayoutCrossSection sectionAutoWithSection:section];
        hSection.header = [FMLayoutHeader elementSize:100 viewClass:[FMCollectionCustomDecoration class]];
        [self.sections addObject:hSection];
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
//        FMLayoutCrossSection *hSection = [FMLayoutCrossSection sectionAutoWithSection:section];
//        hSection.header = [FMLayoutHeader elementSize:100 viewClass:[FMCollectionCustomDecoration class]];
        [self.sections addObject:section];
    }
        
    {
        FMLayoutFillSection *section = [[FMLayoutFillSection alloc] init];
        

        section.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

        section.header = [FMLayoutHeader elementSize:50 viewClass:[FMCollectionCustomDecoration class]];
        section.header.suspensionTopMargin = 0;
        section.cellElement = [FMLayoutElement elementWithViewClass:[FMCollectionCustomCell class]];
            section.itemDatas = [@[@"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3", @"3", @"1", @"2", @"3",] mutableCopy];
            [section setSizeBlock:^CGSize(id  _Nonnull section, NSInteger item) {
                switch (item) {
                    case 2:
                        return CGSizeMake(150, 140);
                    case 5:
                        return CGSizeMake((weakSelf.view.frame.size.width-20-150)/2, 70);
                    case 8:
                    case 11:
                        return CGSizeMake(100, 240);
                    case 10:
                        return CGSizeMake(weakSelf.view.frame.size.width-20-200, 140);
                    case 9:
                    case 12:
                        return CGSizeMake(weakSelf.view.frame.size.width-20-100, 100);
                    case 0:
                    case 1:
                    case 3:
                    case 4:
                        return CGSizeMake((weakSelf.view.frame.size.width-20-150)/4, 70);
                    default:
                        return CGSizeMake((weakSelf.view.frame.size.width-20-150)/4, 70);
                }
            }];
    //        [section setConfigureCellLayoutAttributes:^(id  _Nonnull section, UICollectionViewLayoutAttributes * _Nonnull attributes, NSInteger item) {
    //            if (item == 10) {
    //                attributes.transform = CGAffineTransformMakeRotation(M_PI_4);
    //            }
    //        }];
        
//        FMLayoutCrossSection *hSection = [FMLayoutCrossSection sectionAutoWithSection:section];
//        hSection.autoMaxSize = NO;
//        hSection.height = 500;
//        hSection.header = [FMLayoutHeader elementSize:100 viewClass:[FMCollectionCustomDecoration class]];
//        [hSection setConfigureHeaderData:^(FMLayoutBaseSection * _Nonnull section, UICollectionReusableView * _Nonnull header) {
//            FMCollectionCustomDecoration *custom = (FMCollectionCustomDecoration *)header;
//            custom.textLabel.text = @"FMLayoutFillSection";
//        }];
//        [self.shareSections addObject:hSection];
        
            [self.sections addObject:section];
        }
    
    {
        FMLayoutCrossSection *sections = [FMLayoutCrossSection sectionWithSectionInset:UIEdgeInsetsMake(10, 10, 10, 10) itemSpace:0 lineSpace:0 column:1];
        sections.header = [FMLayoutHeader elementSize:100 viewClass:[FMCollectionCustomDecoration class]];
        sections.header.lastMargin = 10;
//        sections.size = 400;
        sections.autoMaxSize = YES;
        
        {
//                {
//                        FMLayoutFillSection *section = [[FMLayoutFillSection alloc] init];
//                        section.itemDatas = [@[@"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3",] mutableCopy];
//
//                        section.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//
//                        section.header = [FMLayoutHeader elementSize:50 viewClass:[FMCollectionCustomDecoration class]];
//                        section.header.suspensionTopMargin = 0;
//                        section.header.zIndex = FMLayoutZIndexFrontAlways;
//                        section.header.type = FMLayoutHeaderTypeSuspensionAlways;
//                        [section setConfigureHeaderData:^(FMLayoutBaseSection * _Nonnull section, UICollectionReusableView * _Nonnull header) {
//                            FMCollectionCustomDecoration *customHeader = (FMCollectionCustomDecoration *)header;
//                            customHeader.textLabel.text = @"填充布局,寻找合适的空档,支持多种cell, header样式一直悬停在顶部";
//                        }];
//
//                        section.cellElements = @[[FMLayoutElement elementWithViewClass:[FMCollectionCustomCell class]]];
//                        [section setDeqCellReturnReuseId:^NSString * _Nonnull(FMLayoutDynamicSection * _Nonnull section, NSInteger index) {
//                            return [section.cellElements firstObject].reuseIdentifier;
//                        }];
//                        [section setSizeBlock:^CGSize(id  _Nonnull section, NSInteger item) {
//                            switch (item) {
//                                case 2:
//                                    return CGSizeMake(150, 140.32);
//                                case 5:
//                                    return CGSizeMake((weakSelf.view.frame.size.width-20-150)/2, 70.19);
//                                case 8:
//                                case 11:
//                                    return CGSizeMake(100, 240);
//                                case 10:
//                                    return CGSizeMake(weakSelf.view.frame.size.width-20-200, 140);
//                                case 9:
//                                case 12:
//                                    return CGSizeMake(weakSelf.view.frame.size.width-20-100, 100);
//                                case 0:
//                                case 1:
//                                case 3:
//                                case 4:
//                                    return CGSizeMake((weakSelf.view.frame.size.width-20-150)/4, 70.13);
//                                default:
//                                    return CGSizeMake((weakSelf.view.frame.size.width-20-150)/4, 70.19);
//                            }
//                        }];
//                //        [section setConfigureCellLayoutAttributes:^(id  _Nonnull section, UICollectionViewLayoutAttributes * _Nonnull attributes, NSInteger item) {
//                //            if (item == 10) {
//                //                attributes.transform = CGAffineTransformMakeRotation(M_PI_4);
//                //            }
//                //        }];
//                        [section setConfigureCellData:^(FMLayoutBaseSection * _Nonnull section, UICollectionViewCell * _Nonnull cell, NSInteger item) {
//                            FMCollectionCustomCell *customCell = (FMCollectionCustomCell *)cell;
//                            customCell.label.text = [NSString stringWithFormat:@"%ld", item];
//                        }];
//                        [sections.sections addObject:section];
//                    }
            
                {
                    FMLayoutFixedSection *section = [FMLayoutFixedSection sectionWithSectionInset:UIEdgeInsetsZero itemSpace:10 lineSpace:10 column:3];

                    section.header = [FMLayoutHeader elementSize:100 viewClass:[FMCollectionCustomDecoration class]];
                    section.header.lastMargin = 10;
                    section.header.type = FMLayoutHeaderTypeSuspensionBigger;
                    section.header.zIndex = FMLayoutZIndexFrontAlways;
                    section.header.minSize = 50;
                    section.header.isStickTop = YES;
            //        section.header.suspensionTopMargin = 50;
            //        section.header.inset = UIEdgeInsetsMake(0, -15, 0, -15);

//                    section.footer = [FMLayoutFooter elementSize:50 viewClass:[FMCollectionCustomDecoration class]];
//                    section.footer.topMargin = 10;

            //        section.isHorizontalCanScroll = YES;
                    section.itemSize = CGSizeMake(150, 100);
                    section.itemDatas = [@[@"1", @"2", @"3", @"2", @"3", @"2", @"3", @"2", @"3", @"2", @"3", @"2", @"3", @"2", @"3", @"2", @"3", @"2", @"3", @"2", @"3"] mutableCopy];
                    section.cellElement = [FMLayoutElement elementWithViewClass:[FMCollectionCustomCell class]];
                    [section setClickCellBlock:^(FMLayoutBaseSection * _Nonnull section, NSInteger item) {

                    }];
//                    [sections.sections addObject:section];
                    [self.sections addObject:section];
                }
//
//            {
//                    FMLayoutLabelSection *section = [FMLayoutLabelSection sectionWithSectionInset:UIEdgeInsetsMake(0, 10, 0, 10) itemSpace:10 lineSpace:10 column:3];
//
//                    section.header = [FMLayoutHeader elementSize:30 viewClass:[FMCollectionCustomDecoration class]];
//                    section.header.zIndex = FMLayoutZIndexFrontOfItem;
//                    section.header.type = FMLayoutHeaderTypeFixed;
//                    section.header.lastMargin = 10;
//
////                    section.maxLine = 1;
//                    section.cellFixedHeight = 40;
//                    [section setWidthBlock:^CGFloat(id  _Nonnull section, NSInteger item) {
//                        return item * 20 + 100;
//                    }];
//                    section.itemDatas = [@[@"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3", ] mutableCopy];
//                    section.cellElement = [FMLayoutElement elementWithViewClass:[FMCollectionCustomCell class]];
//                    [sections.sections addObject:section];
//                }
//                {
//                    FMLayoutAbsoluteSection *section = [FMLayoutAbsoluteSection sectionWithSectionInset:UIEdgeInsetsMake(0, 0, 0, 0) itemSpace:0 lineSpace:0 column:0];
//
//                    section.itemDatas = [@[@"1", @"2", @"3"] mutableCopy];
//                    section.cellElements = @[[FMLayoutElement elementWithViewClass:[FMCollectionCustomCell class]]];
//                    [section setDeqCellReturnReuseId:^NSString * _Nonnull(FMLayoutDynamicSection * _Nonnull section, NSInteger index) {
//                        return [section.cellElements firstObject].reuseIdentifier;
//                    }];
//                    [section setFrameBlock:^CGRect(id  _Nonnull section, NSInteger item) {
//                        switch (item) {
//                            case 0:
//                                return CGRectMake(0, 0, 100, 100);
//                            case 1:
//                                return CGRectMake(200, 100, 150, 100);
//                            case 2:
//                                return CGRectMake(100, 400, 400, 90);
//                            default:
//                                return CGRectZero;
//                                break;
//                        }
//                    }];
//                    [sections.sections addObject:section];
//                }
            
//            {
//                    FMLayoutLabelSection *section = [FMLayoutLabelSection sectionWithSectionInset:UIEdgeInsetsMake(0, 10, 0, 10) itemSpace:10 lineSpace:10 column:3];
//
//                    section.header = [FMLayoutHeader elementSize:30 viewClass:[FMCollectionCustomDecoration class]];
//                    section.header.zIndex = FMLayoutZIndexFrontOfItem;
//                    section.header.type = FMLayoutHeaderTypeFixed;
//                    section.header.lastMargin = 10;
//
//            //        section.isSingleLineCanScroll = YES;
//                    section.maxLine = 1;
//                    section.cellFixedHeight = 40;
//                    [section setWidthBlock:^CGFloat(id  _Nonnull section, NSInteger item) {
//                        return item * 20 + 100;
//                    }];
//                    section.itemDatas = [@[@"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3", ] mutableCopy];
//                    section.cellElement = [FMLayoutElement elementWithViewClass:[FMCollectionCustomCell class]];
//                    [sections.sections addObject:section];
//                }
            
        }
        
//        [self.shareSections addObject:sections];
    }
    self.collectionView.layout.sections = self.sections;
    [self.collectionView reloadData];
}

- (void)changeLayoutDirection{
    self.collectionView.layout.direction = self.collectionView.layout.direction == FMLayoutDirectionVertical ? FMLayoutDirectionHorizontal : FMLayoutDirectionVertical;
    [self.collectionView reloadChangedSectionsData];
    if (self.collectionView.layout.direction == FMLayoutDirectionVertical) {
        self.collectionView.alwaysBounceVertical = YES;
        self.collectionView.alwaysBounceHorizontal = NO;
    } else {
        self.collectionView.alwaysBounceVertical = NO;
        self.collectionView.alwaysBounceHorizontal = YES;
    }
}

@end

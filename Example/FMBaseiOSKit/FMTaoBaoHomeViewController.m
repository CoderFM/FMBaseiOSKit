//
//  FMTaoBaoHomeViewController.m
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2020/7/14.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMTaoBaoHomeViewController.h"
#import "FMCollectionCustomCell.h"
#import "FMCollectionCustomDecoration.h"

@interface FMTaoBaoHomeViewController ()

@end

@implementation FMTaoBaoHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseNavItem.title = @"淘宝首页";
    [self addSections];
    [self.teslaView reLoadSubViews];
}

- (void)addSections{
    self.teslaView.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
    NSMutableArray *sections = [NSMutableArray array];
    {
        FMLayoutFixedSection *section = [FMLayoutFixedSection sectionWithSectionInset:UIEdgeInsetsMake(10, 15, 10, 15) itemSpace:0 lineSpace:0 column:1];
        section.itemSize = CGSizeMake([FMConfig config].screenWidth - 30, 150);
        section.cellElement = [FMLayoutElement elementWithViewClass:[FMCollectionCustomCell class] isNib:NO reuseIdentifier:@"HomeBannerSection"];
        section.itemDatas = [@[@"1"] mutableCopy];
        [section setConfigureCellData:^(FMLayoutBaseSection * _Nonnull section, UICollectionViewCell * _Nonnull cell, NSInteger item) {
            [cell.contentView setCornerRadius:10];
        }];
        [sections addObject:section];
    }
    {
        FMLayoutFixedSection *section = [FMLayoutFixedSection sectionWithSectionInset:UIEdgeInsetsMake(0, 15, 0, 15) itemSpace:10 lineSpace:10 column:2];
        section.itemSize = CGSizeMake(80, 80);
        section.cellElement = [FMLayoutElement elementWithViewClass:[FMCollectionCustomCell class] isNib:NO reuseIdentifier:@"HomeTypeSection"];
        section.itemDatas = [@[@"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1"] mutableCopy];
        [section setConfigureCellData:^(FMLayoutBaseSection * _Nonnull section, UICollectionViewCell * _Nonnull cell, NSInteger item) {
            [cell.contentView setCornerRadius:10];
        }];
        FMLayoutCrossSection *cSection = [FMLayoutCrossSection sectionAutoWithSection:section];
        cSection.autoMaxSize = NO;
        cSection.size = 170;
        [sections addObject:cSection];
    }
    {
        FMLayoutFixedSection *section = [FMLayoutFixedSection sectionWithSectionInset:UIEdgeInsetsMake(20, 15, 20, 15) itemSpace:0 lineSpace:0 column:2];
        section.itemSize = CGSizeMake(([FMConfig config].screenWidth - 30) * 0.5, 150);
        section.cellElement = [FMLayoutElement elementWithViewClass:[FMCollectionCustomCell class] isNib:NO reuseIdentifier:@"HomeaCTIVITYSection"];
        section.itemDatas = [@[@"1", @"1", @"1", @"1", @"1", @"1"] mutableCopy];
        [section setConfigureCellData:^(FMLayoutBaseSection * _Nonnull section, UICollectionViewCell * _Nonnull cell, NSInteger item) {
//            cell.contentView.backgroundColor =
        }];
        
        section.footer = [FMLayoutFooter elementSize:40 viewClass:[FMCollectionCustomDecoration class]];
        [section setConfigureFooterData:^(FMLayoutBaseSection * _Nonnull section, UICollectionReusableView * _Nonnull footer) {
            
        }];
        
        section.background = [FMLayoutBackground bgWithViewClass:[UICollectionReusableView class]];
        section.background.inset = UIEdgeInsetsMake(10, 15, 10, 15);
        [section setConfigureBg:^(FMLayoutBaseSection * _Nonnull section, UICollectionReusableView * _Nonnull bg) {
            [bg setCornerRadius:10];
            bg.backgroundColor = [UIColor whiteColor];
        }];
        
        [sections addObject:section];
    }
    {
        FMLayoutBaseSection *section = [[FMLayoutBaseSection alloc] init];
        section.header = [FMLayoutHeader elementSize:50 viewClass:[UICollectionReusableView class] isNib:NO reuseIdentifier:@"HomeSussSectionHeader"];
        section.header.type = FMLayoutHeaderTypeSuspensionAlways;
        FMWeakSelf;
        [section setConfigureHeaderData:^(FMLayoutBaseSection * _Nonnull section, UICollectionReusableView * _Nonnull header) {
            if (header.subviews.count == 0) {
                FMNavBtnsView *btns = [[FMNavBtnsView alloc] init];
                btns.canScroll = YES;
                btns.itemMargin = 30;
                btns.lineAnimation = FMNavBtnsLineAnimationProgress;
                btns.normalFont = [UIFont boldSystemFontOfSize:20];
                btns.selectFont = [UIFont boldSystemFontOfSize:20];
                btns.titles = @[@"全部标签", @"直播爱仕达历史记录卡机是老大", @"便宜好货", @"买家秀", @"买家秀", @"便宜好货"];
                [header addSubview:btns];
                [btns mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.top.bottom.mas_equalTo(0);
                }];
                weakSelf.pageNavView = btns;
            }
        }];
        [sections addObject:section];
    }
    self.shareSections = sections;
    
    
    NSMutableArray *pageSections = [NSMutableArray array];
    {
        NSMutableArray *page = [NSMutableArray array];
        FMLayoutFixedSection *section = [FMLayoutFixedSection sectionWithSectionInset:UIEdgeInsetsMake(10, 15, 0, 15) itemSpace:10 lineSpace:10 column:2];
        section.itemSize = CGSizeMake(([FMConfig config].screenWidth - 40) * 0.5, 200);
        section.cellElement = [FMLayoutElement elementWithViewClass:[FMCollectionCustomCell class] isNib:NO reuseIdentifier:@"HomeTypeSection"];
        section.itemDatas = [@[@"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1"] mutableCopy];
        [section setConfigureCellData:^(FMLayoutBaseSection * _Nonnull section, UICollectionViewCell * _Nonnull cell, NSInteger item) {
            [cell.contentView setCornerRadius:10];
        }];
        [page addObject:section];
//        [pageSections addObject:[page copy]];
//        [pageSections addObject:[page copy]];
//        [pageSections addObject:[page copy]];
//        [pageSections addObject:[page copy]];
//        [pageSections addObject:[page copy]];
//        [pageSections addObject:[page copy]];
    }
    self.pageSections = pageSections;
}

- (void)tesla:(FMTeslaLayoutView *)tesla currentScrollViewScrollDidScroll:(FMLayoutView *)currentLayoutView contentOffset:(CGPoint)contentOffset{
    CGFloat shareHeight = [[tesla valueForKey:@"shareHeight"] floatValue];
    if (shareHeight > 0 && contentOffset.y >= (shareHeight - 50)) {
        self.pageNavView.backgroundColor = [UIColor whiteColor];
    } else {
        self.pageNavView.backgroundColor = [UIColor clearColor];
    }
}

@end

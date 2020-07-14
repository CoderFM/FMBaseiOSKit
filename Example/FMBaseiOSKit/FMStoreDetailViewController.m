//
//  FMStoreDetailViewController.m
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2020/7/14.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMStoreDetailViewController.h"
#import "FMCollectionCustomCell.h"
#import "FMCollectionCustomDecoration.h"

@interface FMStoreDetailViewController ()
@property(nonatomic, weak)FMNavBtnsView *btnsView;
@end

@implementation FMStoreDetailViewController

- (void)setBtnsView:(FMNavBtnsView *)btnsView{
    _btnsView = btnsView;
    FMWeakSelf;
    [btnsView setClickBlock:^(NSInteger tag) {
        [weakSelf.teslaView scrollToIndex:tag animated:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseNavItem.title = @"店铺详情";
    [self addSections];
    [self.teslaView reLoadSubViews];
}

- (void)addSections{
    NSMutableArray *sections = [NSMutableArray array];
    {
        FMLayoutFixedSection *section = [FMLayoutFixedSection sectionWithSectionInset:UIEdgeInsetsMake(0, 0, 0, 0) itemSpace:0 lineSpace:0 column:1];
        section.itemSize = CGSizeMake([FMConfig config].screenWidth, 400);
        section.cellElement = [FMLayoutElement elementWithViewClass:[FMCollectionCustomCell class] isNib:NO reuseIdentifier:@"HomeBannerSection"];
        section.itemDatas = [@[@"1"] mutableCopy];
        [section setConfigureCellData:^(FMLayoutBaseSection * _Nonnull section, UICollectionViewCell * _Nonnull cell, NSInteger item) {
            cell.contentView.backgroundColor = [UIColor whiteColor];
            if (cell.contentView.subviews.count == 0) {
                UIView *view = [UIView viewWithBackgroundColor:[UIColor randomColor]];
                [view setCornerRadius:10];
                [cell.contentView addSubview:view];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.mas_equalTo(20);
                    make.bottom.right.mas_equalTo(-20);
                }];
                [view setShadowColor:[UIColor darkGrayColor] offset:CGSizeZero];
                view.layer.masksToBounds = NO;
            }
        }];
        [sections addObject:section];
    }
    {
        FMLayoutBaseSection *section = [[FMLayoutBaseSection alloc] init];
        section.header = [FMLayoutHeader elementSize:50 viewClass:[UICollectionReusableView class] isNib:NO reuseIdentifier:@"HomeSussSectionHeader"];
        section.header.type = FMLayoutHeaderTypeSuspensionAlways;
        FMWeakSelf;
        [section setConfigureHeaderData:^(FMLayoutBaseSection * _Nonnull section, UICollectionReusableView * _Nonnull header) {
            header.backgroundColor = [UIColor whiteColor];
            if (header.subviews.count == 0) {
                FMNavBtnsView *btns = [[FMNavBtnsView alloc] init];
                btns.normalFont = [UIFont boldSystemFontOfSize:20];
                btns.selectFont = [UIFont boldSystemFontOfSize:20];
                btns.titles = @[@"商品", @"评价", @"商家"];
                [header addSubview:btns];
                [btns mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.top.bottom.mas_equalTo(0);
                }];
                weakSelf.btnsView = btns;
            }
        }];
        [sections addObject:section];
    }
    self.shareSections = sections;
    
    NSMutableArray *pageSections = [NSMutableArray array];
    {
        
        {
            NSMutableArray *page = [NSMutableArray array];
            {
                FMLayoutBaseSection *section = [[FMLayoutBaseSection alloc] init];
                section.sectionInset = UIEdgeInsetsMake(0, 0, 0, [FMConfig config].screenWidth * 0.75);
                section.header = [FMLayoutHeader elementSize:[FMConfig config].screenHeight - [FMConfig config].navStatusHeight - [FMConfig config].tabBarHeight - 50  viewClass:[FMCollectionCustomDecoration class]];
                section.header.type = FMLayoutHeaderTypeSuspensionAlways;
                section.header.suspensionTopMargin = 50;
                [page addObject:section];
            }
            {
                FMLayoutBaseSection *section = [[FMLayoutBaseSection alloc] init];
                
                section.sectionInset = UIEdgeInsetsMake(-([FMConfig config].screenHeight - [FMConfig config].navStatusHeight - [FMConfig config].tabBarHeight - 50), [FMConfig config].screenWidth * 0.25 + 10, 0, 0);
                
                section.header = [FMLayoutHeader elementSize:50 viewClass:[FMCollectionCustomDecoration class]];
                section.header.type = FMLayoutHeaderTypeSuspensionAlways;
                section.header.zIndex = FMLayoutZIndexFrontAlways;
                section.header.suspensionTopMargin = 50;
                
                [page addObject:section];
            }
            {
                FMLayoutFixedSection *section = [FMLayoutFixedSection sectionWithSectionInset:UIEdgeInsetsMake(10, [FMConfig config].screenWidth * 0.25 + 10, 10, 10) itemSpace:0 lineSpace:10 column:1];
                
                section.header = [FMLayoutHeader elementSize:40 viewClass:[FMCollectionCustomDecoration class]];
                section.header.lastMargin = 10;
                
                section.cellElement = [FMLayoutElement elementWithViewClass:[FMCollectionCustomCell class]];
                section.itemSize = CGSizeMake([FMConfig config].screenWidth * 0.75 - 20, 100);
                section.itemDatas = [@[@"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1"] mutableCopy];
                [page addObject:section];
            }
            [pageSections addObject:page];
        }
        {
            NSMutableArray *page = [NSMutableArray array];
            {
                FMLayoutFixedSection *section = [FMLayoutFixedSection sectionWithSectionInset:UIEdgeInsetsMake(10, 10, 10, 10) itemSpace:0 lineSpace:10 column:1];
                
                section.header = [FMLayoutHeader elementSize:40 viewClass:[FMCollectionCustomDecoration class]];
                section.header.lastMargin = 10;
                
                section.cellElement = [FMLayoutElement elementWithViewClass:[FMCollectionCustomCell class]];
                section.itemSize = CGSizeMake([FMConfig config].screenWidth - 20, 100);
                section.itemDatas = [@[@"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1"] mutableCopy];
                [page addObject:section];
            }
            [pageSections addObject:page];
            [pageSections addObject:page];
        }
    }
    self.pageSections = pageSections;
}

- (void)tesla:(FMTeslaLayoutView *)tesla didScrollEnd:(NSInteger)index currentLayoutView:(FMLayoutView *)layoutView{
    self.btnsView.selected = index;
}

@end

//
//  FMCollectionLayoutController.m
//  LiangXinApp
//
//  Created by 郑桂华 on 2020/3/20.
//  Copyright © 2020 ZhouFaMing. All rights reserved.
//

#import "FMCollectionLayoutController.h"
#import "FMConfig.h"
#import <Masonry/Masonry.h>
#import "UIColor+FMExtension.h"

@interface FMCollectionLayoutController ()

@end

@implementation FMCollectionLayoutController

- (Class)cellClass{
    return [UICollectionViewCell class];
}

- (UIScrollView *)listView{
    return self.collectionView;
}

- (FMLayoutView *)collectionView{
    if (_collectionView == nil) {
        FMLayoutView *collectionView = [[FMLayoutView alloc] init];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.configuration = self;
        collectionView.bounces = YES;
        collectionView.alwaysBounceVertical = YES;
        [self.mainContainer addSubview:collectionView];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(@(0));
        }];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sections = [NSMutableArray array];
    ![FMConfig config].configurationCollVC?nil:[FMConfig config].configurationCollVC(self);
}

@end

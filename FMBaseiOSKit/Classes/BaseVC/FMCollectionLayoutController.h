//
//  FMCollectionLayoutController.h
//  LiangXinApp
//
//  Created by 郑桂华 on 2020/3/20.
//  Copyright © 2020 ZhouFaMing. All rights reserved.
//

#import "FMBaseListController.h"
#import <FMLayoutKit/FMLayoutKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface FMCollectionLayoutController : FMBaseListController<UICollectionViewDelegate, FMCollectionLayoutViewConfigurationDelegate>

@property(nonatomic, strong)NSMutableArray<FMLayoutBaseSection *> *sections;
@property(nonatomic, weak)FMLayoutView *collectionView;

@end

NS_ASSUME_NONNULL_END

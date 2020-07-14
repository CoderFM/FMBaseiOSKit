//
//  FMTeslaViewController.h
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/7/14.
//

#import "FMBaseViewController.h"
#import <FMLayoutKit/FMLayoutKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMTeslaViewController : FMBaseViewController<FMTeslaLayoutViewDelegate, FMTeslaLayoutViewDataSource>

@property(nonatomic, weak)FMTeslaLayoutView *teslaView;
@property(nonatomic, strong)NSMutableArray *shareSections;
@property(nonatomic, strong)NSMutableArray<NSMutableArray<FMLayoutBaseSection *> *> *pageSections;

@end

NS_ASSUME_NONNULL_END

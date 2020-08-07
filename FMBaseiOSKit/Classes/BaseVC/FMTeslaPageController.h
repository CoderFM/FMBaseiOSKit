//
//  FMTeslaPageController.h
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/8/7.
//

#import "FMTeslaViewController.h"
#import "FMTeslaPageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMTeslaPageController : FMTeslaViewController

@property(nonatomic, strong)NSMutableArray<FMTeslaPageModel *> *pages;

@end

NS_ASSUME_NONNULL_END

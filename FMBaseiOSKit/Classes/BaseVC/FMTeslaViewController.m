//
//  FMTeslaViewController.m
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/7/14.
//

#import "FMTeslaViewController.h"
#import <Masonry/Masonry.h>

@interface FMTeslaViewController ()

@end

@implementation FMTeslaViewController

- (FMTeslaLayoutView *)teslaView{
    if (_teslaView == nil) {
        FMTeslaLayoutView *tesla = [[FMTeslaLayoutView alloc] init];
        tesla.delegate = self;
        tesla.dataSource = self;
        [self.mainContainer addSubview:tesla];
        _teslaView = tesla;
    }
    return _teslaView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.teslaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}

- (NSArray<FMLayoutBaseSection *> *)shareSectionsInTesla:(FMTeslaLayoutView *)tesla{
    return self.shareSections;
}

- (NSInteger)numberOfScreenInTesla:(FMTeslaLayoutView *)tesla{
    return self.pageSections.count;
}

- (NSMutableArray<FMLayoutBaseSection *> *)tesla:(FMTeslaLayoutView *)tesla sectionsInScreenIndex:(NSInteger)screenIndex{
    return self.pageSections[screenIndex];
}

@end

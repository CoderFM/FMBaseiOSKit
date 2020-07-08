

#import "FMBaseListController.h"
#import "FMConfig.h"

@interface FMBaseListController ()

@end

@implementation FMBaseListController

- (void)setHasFooter:(BOOL)hasFooter{
    _hasFooter = hasFooter;
}

- (void)setHasHeader:(BOOL)hasHeader{
    _hasHeader = hasHeader;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    self.models = [NSMutableArray array];
    ![FMConfig config].configurationListVC?nil:[FMConfig config].configurationListVC(self);
}

- (void)loadListData{
    
}

- (void)headerRefresh{
    self.currentPage = 1;
    [self loadListData];
}

- (void)footerRefresh{
    self.currentPage ++;
    [self loadListData];
}

@end

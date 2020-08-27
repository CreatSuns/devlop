//
//  WYACouresVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/6.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACouresVC.h"
#import "WYACouresNetRequest.h"
#import "WYACouresCategory.h"
#import "WYACouresListTableVC.h"

@interface WYACouresVC ()<VTMagicViewDelegate, VTMagicViewDataSource>

@property (nonatomic, strong) WYACouresNetRequest * courseNetRequest;

@property (nonatomic, strong) NSMutableArray * couresCategorys;

@property (nonatomic, strong) VTMagicController * magicController;

@property (nonatomic, strong) NSMutableArray * nameArray;

@end


@implementation WYACouresVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor WYAJHLightGreyColor];
    
    [self addChildViewController:self.magicController];
    
    [self.view addSubview:self.magicController.view];
    self.magicController.magicView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-WYATopHeight-WYABottomHeight-37.f);
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- Lazy
- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.layoutStyle = VTLayoutStyleDefault;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.navigationHeight = 37.f;
        _magicController.magicView.previewItems = 3;
        _magicController.magicView.sliderHeight = 0;
        _magicController.magicView.itemScale = 1.1;
        _magicController.magicView.separatorHeight = 5;
        _magicController.magicView.separatorColor = [UIColor WYAJHLightGreyColor];
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
    }
    return _magicController;
}

-(WYACouresNetRequest *)courseNetRequest{
    if (!_courseNetRequest) {
        _courseNetRequest = [[WYACouresNetRequest alloc]init];
    }
    return _courseNetRequest;
}

-(NSMutableArray *)couresCategorys{
    if (!_couresCategorys) {
        _couresCategorys = [NSMutableArray arrayWithCapacity:0];
        WYACouresCategory * coures = [[WYACouresCategory alloc]init];
        coures.name = @"全部课程";
        [_couresCategorys addObject:coures];
    }
    return _couresCategorys;
}

- (NSMutableArray *)nameArray{
    if (!_nameArray) {
        _nameArray = [NSMutableArray array];
    }
    return _nameArray;
}

#pragma mark --- VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    return self.nameArray;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:[UIColor WYAJHSegNoSelectColor] forState:UIControlStateNormal];
        [menuItem setTitleColor:[UIColor WYAJHBlackTextColor] forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    static NSString *recomId = @"recom.identifier";
    WYACouresListTableVC * vc = [magicView dequeueReusablePageWithIdentifier:recomId];
    if (!vc) {
        vc = [[WYACouresListTableVC alloc] init];
    }
    WYACouresCategory * couresC = self.couresCategorys[pageIndex];
    vc.category_id = couresC.category_id;
    return vc;
}

#pragma mark --- 数据加载
- (void)loadData{
    [self.courseNetRequest loadCouresCategoryWithParams:nil Success:^(id data) {
        [self.couresCategorys addObjectsFromArray:(NSMutableArray *)data];
        for (WYACouresCategory * model in self.couresCategorys) {
            [self.nameArray addObject:model.name];
        }
        self.magicController.magicView.itemWidth = ScreenWidth/(self.nameArray.count > 5 ? 5:self.nameArray.count);
        [self.magicController.magicView reloadData];
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

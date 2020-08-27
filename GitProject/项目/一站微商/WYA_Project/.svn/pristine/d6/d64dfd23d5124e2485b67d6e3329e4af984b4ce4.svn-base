//
//  WYAArticleVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/6.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAArticleVC.h"
#import "WYAArticleCategory.h"
#import "WYAArticleNetRequest.h"
#import "WYAArticleListVC.h"
@interface WYAArticleVC ()<VTMagicViewDelegate, VTMagicViewDataSource>
@property (nonatomic, strong) NSMutableArray * articleCategorys;
@property (nonatomic, strong) WYAArticleNetRequest * netRequest;
@property (nonatomic, strong) VTMagicController * magicController;
@property (nonatomic, strong) NSMutableArray * nameArray;
@end

@implementation WYAArticleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [self.netRequest loadArticlCategoryWithParams:params Success:^(id data) {
        self.articleCategorys = data;
        for (WYAArticleCategory * model in self.articleCategorys) {
            [self.nameArray addObject:model.name];
        }
        self.magicController.magicView.itemWidth = ScreenWidth/(self.nameArray.count > 5 ? 5:self.nameArray.count);
        [self.magicController.magicView reloadData];
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ====== create dataSources
- (NSMutableArray *)articleCategorys
{
    if (_articleCategorys == nil) {
        _articleCategorys = [NSMutableArray array];
    }
    return _articleCategorys;
}
#pragma mark ====== Create netRequest
- (WYAArticleNetRequest *)netRequest
{
    if (_netRequest == nil) {
        _netRequest = [[WYAArticleNetRequest alloc]init];
    }
    return _netRequest;
}

- (NSMutableArray *)nameArray{
    if (!_nameArray) {
        _nameArray = [NSMutableArray array];
    }
    return _nameArray;
}

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
    WYAArticleListVC * vc = [magicView dequeueReusablePageWithIdentifier:recomId];
    if (!vc) {
        vc = [[WYAArticleListVC alloc] init];
    }
    WYAArticleCategory * catrgoryModel = self.articleCategorys[pageIndex];
    vc.articleCategoryId = catrgoryModel.category_id;
    return vc;
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

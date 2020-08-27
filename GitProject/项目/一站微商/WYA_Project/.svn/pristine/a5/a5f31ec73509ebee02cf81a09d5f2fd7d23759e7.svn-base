//
//  WYATableViewController.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYATableViewController.h"
#import "WYATablePlaceHoldView.h"

@interface WYATableViewController ()<CYLTableViewPlaceHolderDelegate>

@property (nonatomic, strong) WYATablePlaceHoldView * placeHoldView;

@property (nonatomic, assign) BOOL needRefreshFunction;

@property (nonatomic, strong) UIView * replacePlaceholdViewFunction;
@end

@implementation WYATableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

- (UIView *)makePlaceHolderView{
    if (self.replacePlaceholdViewFunction) {
        return self.replacePlaceholdViewFunction;
    }
    self.placeHoldView = [[WYATablePlaceHoldView alloc]init];
    return self.placeHoldView;
}

- (BOOL)enableScrollWhenPlaceHolderViewShowing{
//    if (!self.needRefreshFunction) {
//        return self.needRefreshFunction;
//    }
    
    return YES;
}

//-(void)setNeedRefresh:(BOOL)needRefresh{
//    if (needRefresh) {
//        self.needRefreshFunction = needRefresh;
//    }
//    [self.tableView cyl_reloadData];
//}

-(void)setReplacePlaceholdView:(UIView *)replacePlaceholdView{
    if (replacePlaceholdView) {
        self.replacePlaceholdViewFunction = replacePlaceholdView;
    }
    [self.tableView cyl_reloadData];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  SideMenuViewController.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/13.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "SideMenuViewController.h"
#import "ZYXMyPages.h"
#import "ZYXMovieStreamViewController.h"
#import "ZYXContainerViewController.h"
#import "StoryBoardUtilities.h"

static NSString *const MenuCell = @"MenuCell";
static NSString *const HeaderCell = @"HeaderCell";
@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

#pragma mark - 
#pragma mark Lazy Init

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark Lazy Var

- (void)setSelectedIndex:(int)selectedIndex
{
    if (selectedIndex < 0 || selectedIndex > [self.items count] - 1) {
        return;
    }
    _selectedIndex = selectedIndex;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MenuCell forIndexPath:indexPath];
    
    MenuItems *item = self.items[indexPath.row];
    cell.contentView.backgroundColor = item.color;
    cell.imageView.image = [item sideMenuImage];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [tableView dequeueReusableCellWithIdentifier:HeaderCell];
    return headerView;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZYXContainerViewController *controller = (ZYXContainerViewController *)self.parentViewController;
    if (self.selectedIndex != indexPath.row) {
        self.selectedIndex = indexPath.row;
        self.selectedItem = self.items[self.selectedIndex];
        [controller changeCenterController];
    }
    
    [controller toggleSideMenu];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 64;
}














@end

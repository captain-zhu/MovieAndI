//
//  SideMenuViewController.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/13.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItems.h"

@interface SideMenuViewController : UITableViewController

@property (nonatomic, strong) NSArray *items;
@property (nonatomic) int selectedIndex;
@property (nonatomic, strong) MenuItems *selectedItem;

@end

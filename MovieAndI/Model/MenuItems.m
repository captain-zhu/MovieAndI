//
//  MenuItems.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/14.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "MenuItems.h"
#import "StoryBoardUtilities.h"
#import "ZYXMovieStreamViewController.h"

@interface MenuItems ()

@end

@implementation MenuItems

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name withColor:(UIColor *)color withIndex:(int)index
{
    self = [super init];
    if (self) {
        self.name = name;
        self.color = color;
        self.index = index;
        ZYXMovieStreamViewController *streamViewController = (ZYXMovieStreamViewController *)[StoryBoardUtilities viewControllerForStoryboardName:@"MovieCollection" class:[ZYXMovieStreamViewController class]];
        streamViewController.page = [ZYXMyPages allPages][index];
        streamViewController.title = streamViewController.page.title;
        self.controller = streamViewController;
        NSLog(@"get one controller");
    }
    return self;
}

- (UIImage *)sideMenuImage
{
    return [UIImage imageNamed:self.name];;
}

- (UIImage *)mainImage
{
    return [UIImage imageNamed:[self.name stringByAppendingString:@"_big"]];
}

+ (NSArray *)sharedMenuItems
{
    static NSMutableArray *menuItems;
    
    if (!menuItems) {
        menuItems = [[NSMutableArray alloc] init];
        [menuItems addObject:[[MenuItems alloc] initWithName:@"smile" withColor:[UIColor colorWithRed:249.0f/255 green:84.0f/255.0f blue:7/255.0f alpha:1] withIndex:0]];
        [menuItems addObject:[[MenuItems alloc] initWithName:@"coffee" withColor:[UIColor colorWithRed:69.0f/255 green:59.0f/255.0f blue:55.0/255.0f alpha:1] withIndex:1]];
        [menuItems addObject:[[MenuItems alloc] initWithName:@"drinks" withColor:[UIColor colorWithRed:249.0f/255 green:194.0f/255.0f blue:7/255.0f alpha:1] withIndex:2]];
    }
    return menuItems;
}

@end

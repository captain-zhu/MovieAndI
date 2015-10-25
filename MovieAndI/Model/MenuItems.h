//
//  MenuItems.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/14.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MenuItems : NSObject

@property (nonatomic) int index;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, strong) UIImage *sideMenuImage;
@property (nonatomic, strong) UIImage *mainImage;

- (instancetype)initWithName:(NSString *)name withColor:(UIColor *)color withIndex:(int)index;
- (UIImage *)sideMenuImage;
- (UIImage *)mainImage;

+ (NSArray *)sharedMenuItems;

@end

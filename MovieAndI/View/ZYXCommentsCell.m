//
//  ZYXCommentsCell.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/20.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXCommentsCell.h"

@implementation ZYXCommentsCell

- (void)awakeFromNib {
    // Initialization code
    self.cellImageView.layer.cornerRadius = self.cellImageView.frame.size.width/2;
    self.cellImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

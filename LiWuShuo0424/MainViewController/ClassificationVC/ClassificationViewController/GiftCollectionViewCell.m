//
//  GiftCollectionViewCell.m
//  LiWuShuo0424
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "GiftCollectionViewCell.h"
#import "GiftSubCategory.h"
@implementation GiftCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void) setModel:(GiftSubCategory *)model {
    if (_model!=model) {
        _model=model;
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:_model.icon_url]];
        self.nameLabel.text=_model.name;
      
    }
}
@end

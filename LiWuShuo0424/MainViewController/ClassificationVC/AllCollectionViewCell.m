//
//  AllCollectionViewCell.m
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/29.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "AllCollectionViewCell.h"
#import "StrategyTops.h"
@implementation AllCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void) setModel:(StrategyTops *)model {
    if (_model!=model) {
        _model=model;
        self.titleALabel.text=_model.title;
        self.subTItleLbael.text=_model.subtitle;
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:_model.cover_image_url]];
        
    }
}
@end

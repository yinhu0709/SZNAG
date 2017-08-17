//
//  HotCollectionViewCell.m
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/27.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "HotCollectionViewCell.h"
#import "HotGift.h"

@implementation HotCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void) setModel:(HotGift *)model {
    if (_model!=model) {
        _model=model;
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:_model.cover_image_url]];
        self.privceLabel.text=_model.price;
        self.nameLabel.text=_model.name;
        if (_model.favorites_count>=1000) {
         self.fCountLabel.text=[NSString stringWithFormat:@"%.1fk",_model.favorites_count/1000.0];
        } else {
            self.fCountLabel.text=[NSString stringWithFormat:@"%ld",_model.favorites_count];
        }
       
        
        
        
        
    }
}
@end

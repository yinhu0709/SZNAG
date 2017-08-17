//
//  ContentTableViewCell.m
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/26.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "ContentTableViewCell.h"
#import "BottomTable.h"
@implementation ContentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.contentLabel.layer.backgroundColor=kRGBColor(0.3, 0.3, 0.3, 0.3).CGColor;
}

-(void)setModel:(BottomTable *)model {
    if (_model !=model) {
        _model = model;
        if ([_model.type isEqualToString:@"ad"]) {
            [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:_model.image_url]];
            self.contentLabel.hidden=YES;
            self.rightView.hidden=YES;
        }else {
            self.contentLabel.hidden=NO;
            self.rightView.hidden=NO;
            [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
            self.contentLabel.text=model.title;
            self.likeCountLabel.text=[NSString stringWithFormat:@"%ld",model.likes_count];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  cellView.m
//  LiWuShuo0424
//
//  Created by Sznag on 16/5/3.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "cellView.h"
#import "StrategyItem.h"
@implementation cellView
- (id) initWithModel:(StrategyItem *)model {
    self=[super init];
    if (self) {
        self.tag=1000;
        [self createUIWithModel:model];
    }
    return self;
}

- (void) createUIWithModel:(StrategyItem*)model {
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (kScreenWidth-50)/4-30, (kScreenWidth-50)/4-30)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
    imageView.layer.cornerRadius=((kScreenWidth-50)/4-30)/2;
    imageView.clipsToBounds=YES;
     [self addSubview:imageView];
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, imageView.bounds.size.height, imageView.bounds.size.width, 30)];
    nameLabel.font=[UIFont systemFontOfSize:15];
       nameLabel.textAlignment=NSTextAlignmentCenter;
    nameLabel.text=model.name;
    [self addSubview:nameLabel];
   
    
}

@end

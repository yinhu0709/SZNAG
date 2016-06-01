//
//  HotCollectionViewCell.h
//  LiWuShuo0424
//
//  Created by student on 16/4/27.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotGift;
@interface HotCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *privceLabel;
@property (weak, nonatomic) IBOutlet UILabel *fCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic ,retain)HotGift *model;
@end

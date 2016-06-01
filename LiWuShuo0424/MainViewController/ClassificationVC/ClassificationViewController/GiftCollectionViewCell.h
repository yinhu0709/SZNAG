//
//  GiftCollectionViewCell.h
//  LiWuShuo0424
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  GiftSubCategory;
@interface GiftCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic,retain) GiftSubCategory *model;
@end

//
//  AllCollectionViewCell.h
//  LiWuShuo0424
//
//  Created by student on 16/4/29.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StrategyTops;
@interface AllCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleALabel;
@property (weak, nonatomic) IBOutlet UILabel *subTItleLbael;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (nonatomic ,retain) StrategyTops *model;
@end

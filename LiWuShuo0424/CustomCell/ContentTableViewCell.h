//
//  ContentTableViewCell.h
//  LiWuShuo0424
//
//  Created by student on 16/4/26.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BottomTable ;
@interface ContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic ,retain) BottomTable *model;

@end

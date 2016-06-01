//
//  MiddleCollectionViewCell.h
//  LiWuShuo0424
//
//  Created by student on 16/4/25.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Menu;
@interface MiddleCollectionViewCell : UICollectionViewCell
@property (nonatomic,retain)  UITableView *tableView;
@property (nonatomic ,assign) id delegate;

- (void) setUpCellWith:(Menu*)model ;
- (void) setTableViewHeader:(NSMutableArray*) bigArr and:(NSMutableArray*) smallArr;
@end
@protocol MiddleCollectionCellDelegate <NSObject>

@optional
- (void) goToDetaliVCWithUrl:(NSString*) urlStr;

@end
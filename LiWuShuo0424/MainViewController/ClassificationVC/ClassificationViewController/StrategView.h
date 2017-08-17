//
//  StrategView.h
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/29.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StrategyTops;
@interface StrategView : UIView
@property (nonatomic ,assign) id delegate;
- (void) setUpView ;
@end
@protocol StrategyDelegate <NSObject>

@optional
- (void) topScrollViewBtnClickWithIndex:(StrategyTops*) model;
- (void) checkAllMenuTitle;

@end

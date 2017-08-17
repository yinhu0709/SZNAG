//
//  PullDownView.h
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/28.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PullDownView : UIView
@property (nonatomic,assign) id delegate;
- (id) initWithBtnArray:(NSArray*) array andIndex:(NSInteger)index;
@end
@protocol PullDownViewDelegate <NSObject>

@optional
- (void) changeSelectMenuWith:(NSInteger)offestX;

@end

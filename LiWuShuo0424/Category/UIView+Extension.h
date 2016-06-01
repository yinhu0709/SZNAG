//
//  UIView+Extension.h
//  NewsBoardDemo-05
//
//  Created by Invoter丶C on 16/4/19.
//  Copyright © 2016年 IT. All rights reserved.
/**
 *  @property  类中 ： 声明 并 实现  set  get   指针
 *  @property  类别中 ： 只声明 set  和 get  （没有指针 和 实现 ）
 */

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/*
 * 设置 宽度
 */
@property (nonatomic, assign) CGFloat    width;
/*
* 设置 高度
*/

@property (nonatomic, assign) CGFloat    height;
/*
* 设置x坐标
*/

@property (nonatomic, assign) CGFloat    x;
/*
* 设置y坐标
*/

@property (nonatomic, assign) CGFloat    y;



@end








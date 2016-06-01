//
//  UIView+Extension.m
//  NewsBoardDemo-05
//
//  Created by Invoter丶C on 16/4/19.
//  Copyright © 2016年 IT. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
/*
 height
 */
- (void)setHeight:(CGFloat)height {
    CGRect   rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
- (CGFloat)height {
    return self.frame.size.height;
}
    
    
- (void)setWidth:(CGFloat)width {
    CGRect   rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}
- (CGFloat)width {
    return self.frame.size.width;
}
    
- (void)setX:(CGFloat)x {
    CGRect  rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}
- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect  rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}
- (CGFloat)y {
    return self.frame.origin.y;
}

    

@end




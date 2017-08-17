//
//  MeGigtView.m
//  LiWuShuo0424
//
//  Created by Sznag on 16/5/6.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "MeGigtView.h"
#define KBgImageHeight 240
#define KFourViewHeight 80
#define KMiddleViewHeight 44
@implementation MeGigtView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor=[UIColor purpleColor];
        self.frame=CGRectMake(0, KFourViewHeight+KBgImageHeight+20+KMiddleViewHeight, kScreenWidth, kScreenHeight-20-KMiddleViewHeight);
;
        
            }
    return self;
}
@end

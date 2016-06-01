//
//  UILabel+NavTitleView.m
//  LiWuShuo0424
//
//  Created by student on 16/4/24.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "UILabel+NavTitleView.h"

@implementation UILabel (NavTitleView)
+ (UILabel*) setUpNavTitleViewWithText:(NSString*) text {
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.bounds=CGRectMake(0, 0, 0, 40);
    titleLabel.text=text;
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font=[UIFont boldSystemFontOfSize:23];
    return titleLabel;
}
@end

//
//  UIImage+ImageFile.m
//  NewsEX0420
//
//  Created by student on 16/4/20.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "UIImage+ImageFile.h"


@implementation UIImage (ImageFile)
+ (UIImage*) getImageWithString:(NSString*) str {
    NSString*path=[[NSString alloc]init];
    
    if ([str containsString:@"."]) {
        NSArray*arr=[str componentsSeparatedByString:@"."];
        NSString *path1=[[NSBundle mainBundle] pathForResource:arr[0] ofType:arr[1]];
        path=path1;

    } else {
        NSString*path2=[[NSBundle mainBundle] pathForResource:str ofType:@"png"];
        path=path2;

    }
    UIImage *image=[UIImage imageWithContentsOfFile:path];

    return image;
    
}
@end

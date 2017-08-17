//
//  Header.h
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/24.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#ifndef Header_h
#define Header_h
/**
 * 屏幕 宽高
 */
#define  kScreenBounds  [[UIScreen mainScreen] bounds]
#define  kScreenHeight  kScreenBounds.size.height
#define  kScreenWidth  kScreenBounds.size.width
/*
 * 颜色
 */
#define kRGBColor(r,g,b,a)      [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:(a)]
/*
 *debug 打印
 */
#ifdef  DEBUG
#define SZNLog(...)    NSLog(__VA_ARGS__)
#else
#define SZNLog(...)
#endif
#endif /* Header_h */

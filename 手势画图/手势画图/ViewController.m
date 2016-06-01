//
//  ViewController.m
//  手势画图
//
//  Created by student on 16/5/24.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UIImageView *_imageV;
    CGPoint _beginP;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _imageV =[[UIImageView alloc]initWithFrame:CGRectMake(5, 100, self.view.bounds.size.width-10, 400)];
    
    _imageV.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:_imageV];
    
}
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch =[touches anyObject];
    CGPoint point =[touch locationInView:self.view];
    _beginP=point;
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch =[touches anyObject];
    CGPoint point =[touch locationInView:_imageV];
//    创建一个画板
    UIGraphicsBeginImageContext(_imageV.bounds.size);
//    指定在哪个地方画画
    [_imageV drawRect:_imageV.bounds];
//    设置画画的属性和样式
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//    设置线的粗细
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5);
//    设置线的颜色
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1, 0, 0, 1);
//    画路径
    CGContextBeginPath(UIGraphicsGetCurrentContext());
//    开始点
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _beginP.x, _beginP.y);
//    结束点
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
//    要闭合线
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    _imageV.image=UIGraphicsGetImageFromCurrentImageContext();
//    结束画图
    UIGraphicsEndImageContext();
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

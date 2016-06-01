//
//  PullDownView.m
//  LiWuShuo0424
//
//  Created by student on 16/4/28.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "PullDownView.h"
#import "Menu.h"
#define KPullUpBtnWidth  35
#define KPullUpBtnHeight 35

@implementation PullDownView
- (id) initWithBtnArray:(NSArray*) array andIndex:(NSInteger)index {
    self=[super init];
    if (self) {
     
        self.backgroundColor=[UIColor whiteColor];;
        [self createUIWith:array andIndex:index];
    }
    return self;
}

- (void) createUIWith:(NSArray*) menuArr  andIndex:(NSInteger)index {
    
    static NSInteger j=0;
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KPullUpBtnHeight)];
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, KPullUpBtnWidth*2, KPullUpBtnHeight)];
    titleLabel.text=@"切换频道";
    UIButton *pullUpBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    pullUpBtn.frame=CGRectMake(kScreenWidth-KPullUpBtnWidth, 0, KPullUpBtnWidth, KPullUpBtnHeight);

    [pullUpBtn setBackgroundImage:[UIImage imageNamed:@"PullUpBtn"] forState:UIControlStateNormal];
    [pullUpBtn addTarget:self action:@selector(pullUpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:titleLabel];
    [topView addSubview:pullUpBtn];
    [self addSubview:topView];
    if (menuArr.count>0) {
        if (menuArr.count%4!=0) {
            j =menuArr.count/4+1;
        } else {
            j=menuArr.count/4;
        }
        
        for (int i=0; i<menuArr.count; i++) {
           
            UIButton *menuBtn=[UIButton buttonWithType:UIButtonTypeSystem];
            Menu *obj=menuArr[i];
            [menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [menuBtn setTitle:obj.name forState:UIControlStateNormal];
            menuBtn.frame=CGRectMake(i%4*(kScreenWidth/4),i/(menuArr.count/4)*KPullUpBtnHeight+KPullUpBtnHeight, kScreenWidth/4, KPullUpBtnHeight);
            [menuBtn addTarget:self action:@selector(MenuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            menuBtn.layer.borderWidth=1;
            menuBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
            menuBtn.tag=i;
            if (i==index) {
                UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, KPullUpBtnHeight-2, kScreenWidth/4, 2)];
                bottomView.backgroundColor=[UIColor redColor];
                [menuBtn addSubview:bottomView];
            }
             [self addSubview:menuBtn];
        }
      }
      self.frame=CGRectMake(0, 64, kScreenWidth, KPullUpBtnHeight*(j+1));
 }
#pragma mark ----->菜单按钮激发事件
- (void) MenuBtnClick:(UIButton*) sender {
        if ([self.delegate respondsToSelector:@selector(changeSelectMenuWith:)]) {
        [self.delegate changeSelectMenuWith:sender.tag];
    }
      [self selfRemoveFromSuperview];
}
#pragma mark----->上拉按钮激发事件
- (void) pullUpBtnClick:(UIButton *) sender {
    [self selfRemoveFromSuperview];
   
}
- (void) selfRemoveFromSuperview {
    [UIView animateWithDuration:0.1 animations:^{
        self.frame=CGRectMake(0, 0, 0, 0);
      
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
 }
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

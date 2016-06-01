//
//  StrategView.m
//  LiWuShuo0424
//
//  Created by student on 16/4/29.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "StrategView.h"
#import "StrategyTops.h"
#define KURL @"http://api.liwushuo.com/v2/collections?limit=10&offset=0"
#define KScrollBtnWidth 150
#define KScrollBtnHeight  80
#define KTopViewHeight  44
@interface StrategView () {
    NSMutableArray * arr;
}

@end
@implementation StrategView

#pragma mark------->创建UI
- (void) setUpView  {
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KTopViewHeight)];
   
        UILabel *topLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 100, KTopViewHeight-4)];
        topLabel.text=@"专题";
        [topView addSubview:topLabel];
    UIButton *allBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        allBtn.frame=CGRectMake(kScreenWidth-100, 5, 100, KTopViewHeight-4);
        [allBtn addTarget:self action:@selector(checkAll:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:allBtn];
        [allBtn setTitle:@"查看全部" forState:UIControlStateNormal];
        allBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [allBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
      
        [self addSubview:topView];
    [self addSubview:topView];
    //    创建scrollView
    
        [HttpManager getDataForClassMainVCOfStategyWithURL:KURL WithBlock:^(NSMutableArray *dataArr, NSString *str) {
            arr=[NSMutableArray array];
            [arr addObjectsFromArray:dataArr];
            UIScrollView * scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, topView.bounds.size.height, kScreenWidth, KScrollBtnHeight)];
            scrollView.contentSize=CGSizeMake((KScrollBtnWidth+10)*dataArr.count, 0);
            scrollView.bounces=NO;
            scrollView.showsHorizontalScrollIndicator=NO;
            for (int i=0; i<dataArr.count; i++) {
                UIButton *imageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                imageBtn.frame=CGRectMake(10+i *(KScrollBtnWidth+10), 0, KScrollBtnWidth, KScrollBtnHeight);
                StrategyTops *obj=dataArr[i];
                            [imageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:obj.banner_image_url] forState:UIControlStateNormal];
               
                [imageBtn addTarget:self action:@selector(checkDetail:) forControlEvents:UIControlEventTouchUpInside];
                imageBtn.tag=i;
                [scrollView addSubview:imageBtn];
            }
            
            [self addSubview:scrollView];
            
        }];

    

    
}
#pragma mark=====>scrollView上的点击事件
- (void) checkDetail:(UIButton *) sender {
    if ([self.delegate respondsToSelector:@selector(topScrollViewBtnClickWithIndex:)]) {
        StrategyTops *obj=arr[sender.tag];
        [self.delegate topScrollViewBtnClickWithIndex:obj];
    }
}
#pragma mark---- >查看更多按钮点击事件
- (void) checkAll:(UIButton *) sender {
    if ([self.delegate respondsToSelector:@selector(checkAllMenuTitle)]) {
        [self.delegate checkAllMenuTitle];
    }
}

@end

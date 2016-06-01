//
//  MeViewController.m
//  LiWuShuo0424
//
//  Created by student on 16/4/24.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "MeViewController.h"
#import "MeGigtView.h"
#import "MestrategyView.h"
#import "SettingViewController.h"
#define KBgImageHeight 240
#define KFourViewHeight 80
#define KMiddleViewHeight 44
@interface MeViewController ()<UIScrollViewDelegate> {
    UIView *_alphaView;
      NSArray *_viewArr;
    UIView *_bottomView;
    UIScrollView *_scrollView;

}

@end

@implementation MeViewController
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"clear"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"clear"]];
   }
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MeGigtView *giftView=[[MeGigtView alloc]init];
    MestrategyView *strateView=[[MestrategyView alloc]init];
    _viewArr=@[giftView,strateView];
    [self setUpNavBar];
    [self createUI];
      }

#pragma mark -------->设置导航条
- (void) setUpNavBar {
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"youxiang"] style: UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *setBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"settings"] style: UIBarButtonItemStylePlain target:self action:@selector(settingsBtnClick)];
    UIBarButtonItem *saomaBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"saoma"] style: UIBarButtonItemStylePlain target:self action:@selector(saomaBtnClick)];
    self.navigationItem.rightBarButtonItems =@[setBtn,saomaBtn];
    
   
}

#pragma mark------->创建UI
- (void) createUI {
    UIImageView *bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, KBgImageHeight)];
    bgImageView.image=[UIImage imageNamed:@"me_top.png"];
    [self.view addSubview:bgImageView];
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    scrollView.bounces=NO;
    scrollView.contentSize=CGSizeMake(0, kScreenHeight+KFourViewHeight+KBgImageHeight-64) ;
    [self.view addSubview:scrollView];
    UIImageView *fourImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, KBgImageHeight+20, kScreenWidth, KFourViewHeight)];
//    fourImageView.userInteractionEnabled=YES;
    for (int i=0; i<4; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(12+i*(50+60), 10, 50, 60);
               btn.tag=i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [fourImageView addSubview:btn];
    }
    fourImageView.image=[UIImage imageNamed:@"me_middle.png"];
    [scrollView addSubview:fourImageView];
    UIView *middleView=[[UIView alloc]initWithFrame:CGRectMake(0, KFourViewHeight+KBgImageHeight+20, kScreenWidth,KMiddleViewHeight)];
   
    NSArray *arr=@[@"礼物",@"攻略"];
    UISegmentedControl *seg=[[UISegmentedControl alloc]initWithItems:arr];
       seg.selectedSegmentIndex=0;
    seg.backgroundColor=[UIColor whiteColor];
    seg.tintColor=[UIColor orangeColor];
    seg.frame=CGRectMake(0, 0, kScreenWidth, KMiddleViewHeight);
    [seg addTarget:self action:@selector(changeSegValue:) forControlEvents:UIControlEventValueChanged];
    [middleView addSubview:seg];
    scrollView.delegate=self;
    scrollView.tag=100;
    [scrollView addSubview:middleView];
//    _bottomView= [[UIView alloc]initWithFrame:CGRectMake(0, KFourViewHeight+KBgImageHeight+20+KMiddleViewHeight, kScreenWidth, kScreenHeight-KFourViewHeight-KBgImageHeight-20-KMiddleViewHeight)];
//    _bottomView.backgroundColor=[UIColor cyanColor];
//    [_bottomView addSubview:_viewArr[0]];
//    [scrollView addSubview:_bottomView];
    [scrollView addSubview:_viewArr[0]];
    
    _scrollView=scrollView;
}
#pragma mark----->四个按钮点击事件------
- (void) btnClick:(UIButton*) sender {
    NSLog(@"%ld",sender.tag);
}
#pragma mark------>导航条左侧按钮点击shijian
- (void) leftBarButtonItemClick {
    
}
#pragma mark------>设置
- (void) settingsBtnClick {
    SettingViewController *setVC=[[SettingViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
    
    
}
#pragma mark----->扫码
- (void) saomaBtnClick {
    
}
#pragma mark ------>选择礼物or攻略
- (void) changeSegValue:(UISegmentedControl*) sender {
    [_scrollView addSubview:_viewArr[sender.selectedSegmentIndex]];
}
#pragma mark--------->滑动时
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag==100) {
        //1。拿到y值
    CGFloat contentOffY = scrollView.contentOffset.y;
    UIColor *color = [UIColor redColor];
        CGFloat alpah = contentOffY/ 260;
       if (!_alphaView) {
        _alphaView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        [self.navigationController.navigationBar insertSubview:_alphaView atIndex:0];
                   }
      [_alphaView setBackgroundColor:[color colorWithAlphaComponent:alpah]];
}
   
    if (scrollView.contentOffset.y==scrollView.contentSize.height-kScreenHeight) {
      
                           }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

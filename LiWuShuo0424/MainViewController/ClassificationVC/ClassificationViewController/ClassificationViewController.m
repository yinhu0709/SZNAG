//
//  ClassificationViewController.m
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/24.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "ClassificationViewController.h"
#import "SearchViewController.h"
#import "StrategyViewController.h"
#import "GiftViewController.h"
@interface ClassificationViewController ()<UIScrollViewDelegate> {
    UIScrollView *bgScrollView;
    UISegmentedControl *segControl;
}

@end

@implementation ClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUpNavBar];
}
#pragma mark----->设置导航条
- (void) setUpNavBar {
    NSArray *topArr=@[@"攻略",@"礼物"];
    segControl=[[UISegmentedControl alloc]initWithItems:topArr];
    segControl.bounds=CGRectMake(0, 0, 200, 30);
//    segControl.selectedSegmentIndex=0;
    [segControl addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView=segControl;
      self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(searchBtnClick)];
    
    StrategyViewController *strateVC=[[StrategyViewController alloc]init];
    GiftViewController *giftVC=[[GiftViewController alloc]init];
    
    [self addChildViewController:strateVC];
    [self addChildViewController:giftVC];
   
//   创建scrollView
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:kScreenBounds];
    scrollView.pagingEnabled=YES;
    scrollView.bounces=NO;
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.contentSize=CGSizeMake(kScreenWidth*2, 0);
    scrollView.delegate=self;
    [self.view addSubview:scrollView];

    [self scrollViewDidEndScrollingAnimation:scrollView];
    bgScrollView=scrollView;
}
#pragma mark----->
- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  
    NSUInteger  index = scrollView.contentOffset.x/kScreenWidth;
    UIViewController  *vc = self.childViewControllers[index];
    [scrollView addSubview:vc.view];
    segControl.selectedSegmentIndex=index;
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0.0;
}
//停止减速 必须用户手动

#pragma mark------->停止减速
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];

}
#pragma mark--->分段控制激发事件
- (void) changeVC:(UISegmentedControl*) sender {
        [bgScrollView setContentOffset:CGPointMake(sender.selectedSegmentIndex*kScreenWidth, 0) animated:YES];
    
    
    
}
#pragma mark---》搜索界面
- (void) searchBtnClick {
    SearchViewController *searchVC=[[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

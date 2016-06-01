//
//  SZNTabBarViewController.m
//  LiWuShuo0424
//
//  Created by student on 16/4/24.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "SZNTabBarViewController.h"
#import "HotViewController.h"
#import "ClassificationViewController.h"
#import "GuideViewController.h"
#import "MeViewController.h"
#import "SZNNavViewController.h"
@interface SZNTabBarViewController ()

@end

@implementation SZNTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpSZNTabBarViewController];
}
#pragma mark-------->初始化SZNTabBarViewController
- (void) setUpSZNTabBarViewController {
    NSArray *VCArr=@[[GuideViewController new],[HotViewController new],[ClassificationViewController new],[MeViewController new]];
    NSArray * titleArr=@[@"指南",@"热门",@"分类",@"我"];
    NSArray * imageArr=@[@"zhinan_1",@"remen_1",@"fenlei_1",@"me_1"];
    NSArray * selectArr= @[@"zhinan_2",@"remen_2",@"fenlei_2",@"me_2"];;
    UITabBarItem * item=[UITabBarItem appearance];
    NSDictionary *normalDic=@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    NSDictionary *selectDic=@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]};
    [item setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
    for (int i=0; i<VCArr.count; i++) {
        [self setUpTabBarWithViewController:VCArr[i] andTitle:titleArr[i] AndImage:imageArr[i] AndSelectImage:selectArr[i]];
    }
    
}
#pragma mark------->设置tabBar
- (void) setUpTabBarWithViewController:(UIViewController*) VC andTitle:(NSString*)title AndImage:(NSString*)imageName AndSelectImage:(NSString*)selectImageName {
    VC.tabBarItem.title=title;
    VC.tabBarItem.image=[UIImage imageNamed:imageName];
    VC.tabBarItem.selectedImage=[UIImage imageNamed:selectImageName];
    SZNNavViewController *nav=[[SZNNavViewController alloc]initWithRootViewController:VC];
    [self addChildViewController:nav];
    
    
    
    
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

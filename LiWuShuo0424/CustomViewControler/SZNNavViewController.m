//
//  SZNNavViewController.m
//  LiWuShuo0424
//
//  Created by student on 16/4/24.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "SZNNavViewController.h"

@interface SZNNavViewController ()

@end

@implementation SZNNavViewController
+ (void) initialize {
    UINavigationBar* bar=[UINavigationBar appearance];

//    bar.tintColor=[UIColor whiteColor];
    bar.barTintColor=[UIColor redColor];

   }
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(back )];
    viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:animated];
}
- (void) back {
    [self popViewControllerAnimated:YES];
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

//
//  EnterTopScrollViewController.m
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/29.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "EnterTopScrollViewController.h"
#import "StrategyTops.h"
@interface EnterTopScrollViewController ()

@end

@implementation EnterTopScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView=[UILabel setUpNavTitleViewWithText:self.model.title];
    UIWebView *webView=[[UIWebView alloc]initWithFrame:kScreenBounds];
   
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.liwushuo.com/collections/%ld?campaign=in_app_share&channel=android&source=copy_link",self.model.ID]]]];
        [self.view addSubview:webView];
    
    
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

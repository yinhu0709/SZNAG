//
//  HotDetailViewController.m
//  LiWuShuo0424
//
//  Created by student on 16/4/27.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "HotDetailViewController.h"
#import "HotGift.h"
@interface HotDetailViewController ()

@end

@implementation HotDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
    NSString *urlStr=[NSString stringWithFormat:@"%@?campaign=in_app_share&channel=android&source=copy_link",self.model.url];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
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

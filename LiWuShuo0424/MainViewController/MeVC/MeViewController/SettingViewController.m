//
//  SettingViewController.m
//  LiWuShuo0424
//
//  Created by Sznag on 16/5/6.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray *_dataArr;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView=[UILabel setUpNavTitleViewWithText:@"礼物说"];
    
    UITableView *_tableView=[[UITableView alloc ]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _dataArr=@[@"喜欢礼物到默认礼单",@"接受消息推送",@"夜间模式",@"清除缓存",@"检查更新",@"意见反馈",@"关于礼物说",@"推荐应用"].mutableCopy;
   }


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text=_dataArr[indexPath.row];
    if (indexPath.row>_dataArr.count-4) {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row<3) {
        UISwitch *swit=[[UISwitch alloc]init];
        swit.tag=indexPath.row;
        [swit addTarget:self action:@selector(changeValues:) forControlEvents: UIControlEventValueChanged];
        cell.accessoryView=swit;
    }
    if (indexPath.row==3) {
        UILabel *dataLabel=[[UILabel alloc]init];
        dataLabel.bounds=CGRectMake(0, 0, 80, 40) ;
        dataLabel.textAlignment=NSTextAlignmentRight;
        dataLabel.text=@"0B";
        cell.accessoryView=dataLabel;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void) changeValues:(UISwitch*) sender {
    NSLog(@"%ld",sender.tag);
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

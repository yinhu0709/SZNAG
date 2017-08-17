//
//  MestrategyView.m
//  LiWuShuo0424
//
//  Created by Sznag on 16/5/6.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "MestrategyView.h"
#define KBgImageHeight 240
#define KFourViewHeight 80
#define KMiddleViewHeight 44
@interface MestrategyView ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *_tableView;
}


@end
@implementation MestrategyView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor=[UIColor grayColor];
        self.frame=CGRectMake(0, KFourViewHeight+KBgImageHeight+20+KMiddleViewHeight, kScreenWidth, kScreenHeight-20-64-49-44);
;
       _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.bounds.size.height) style:UITableViewStylePlain];
        [self addSubview:_tableView];
        _tableView.delegate=self;
        _tableView.tag=100;
        _tableView.dataSource=self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//        _tableView.scrollEnabled=NO;
    }
    return self;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
@end

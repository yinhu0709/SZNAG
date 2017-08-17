//
//  DetailItemsViewController.m
//  LiWuShuo0424
//
//  Created by Sznag on 16/5/3.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "DetailItemsViewController.h"
#import "ContentTableViewCell.h"
#import "BottomTable.h"
#import "DetailViewController.h"
#define KCellHeight  180
@interface DetailItemsViewController () <UITableViewDataSource,UITableViewDelegate>{
    UITableView * _tableView;
    NSString *_urlStr;
    CGFloat _maxHeight;
}
@property (nonatomic ,retain) NSMutableArray *dataArr;
@end

@implementation DetailItemsViewController
- (NSMutableArray *) dataArr {
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView=[UILabel setUpNavTitleViewWithText:self.name];
    [self createTableView];
}
#pragma mark------>创建tableView
- (void) createTableView {
    _tableView =[[UITableView alloc]initWithFrame:kScreenBounds style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"ContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"tableViewCell"];
      _urlStr= [NSString stringWithFormat:@"http://api.liwushuo.com/v2/channels/%ld/items?ad=2&gender=2&generation=1&limit=20&offset=0",self.ID];
    [self getData];
    
}
- (void) getData {
    [HttpManager getDataForGuideVCTableViewOfDataWith:_urlStr WithBlock:^(NSMutableArray *array, NSString *nextUrl) {
        [self.dataArr addObjectsFromArray:array];
//        NSLog(@"%@,,,%ld",self.dataArr ,self.dataArr.count);
        [_tableView reloadData];
        _maxHeight =_tableView.contentSize.height;
        _urlStr=nextUrl;
    }];
}
// cell个数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}
//cell高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KCellHeight;
}
// cell样式
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    BottomTable *model=self.dataArr[indexPath.row];
    cell.model=model;
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailVC=[[DetailViewController alloc]init];
     BottomTable *model=self.dataArr[indexPath.row];
    detailVC.urlStr=model.url;
    [self.navigationController pushViewController:detailVC animated:YES];

}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentSize.height<=0) {
        return;
    }
    
    if (_maxHeight==scrollView.contentSize.height) {
        CGFloat bottomHeight =scrollView.contentSize.height - scrollView.contentOffset.y-kScreenHeight;
        if (bottomHeight<kScreenHeight) {
            [self getData];
            
            _maxHeight++;
        }
          }
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

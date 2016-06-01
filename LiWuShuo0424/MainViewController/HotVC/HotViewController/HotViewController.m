//
//  HotViewController.m
//  LiWuShuo0424
//
//  Created by student on 16/4/24.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "HotViewController.h"
#define KHOTCollURL  @"http://api.liwushuo.com/v2/items?limit=20&offset=0&gender=1&generation=1"
@interface HotViewController ()<UICollectionViewDataSource,UICollectionViewDelegate> {
    NSString *strUrl;
}
@property (nonatomic ,retain) UICollectionView *collectionView;
@property (nonatomic,retain) NSMutableArray *dataArr;
@end

@implementation HotViewController
- (NSMutableArray*) dataArr {
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
       [self setUpNavBar];
    [self setUpCollectionView];
}
#pragma mark ----》设置导航条
- (void) setUpNavBar {
    self.navigationItem.titleView=[UILabel setUpNavTitleViewWithText:@"热门"];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(searchBtnClick)];
}
#pragma mark---->创建collectionView
- (void) setUpCollectionView {
//    CGRect rect=CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
    UICollectionViewFlowLayout *layOut=[[UICollectionViewFlowLayout alloc]init];
    layOut.scrollDirection=UICollectionViewScrollDirectionVertical;
    layOut.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
          layOut.itemSize=CGSizeMake((kScreenWidth-30)/2, kScreenWidth/2*1.3);
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)collectionViewLayout:layOut];
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    strUrl=KHOTCollURL;
    [self getData];
    
}
#pragma mark------》请求数据
- (void) getData {
    [HttpManager getDataForHotVCCollectionViewOfDataWithURL:strUrl  WithBlock:^(NSMutableArray *array, NSString *nextUrl) {
        [self.dataArr addObjectsFromArray:array];
        strUrl=nextUrl;
          }];
}
#pragma mark-----导航条右侧按钮点击事件
- (void) searchBtnClick {
    
}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor orangeColor];
    return cell;
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

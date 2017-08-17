//
//  AllStrategyViewController.m
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/29.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "AllStrategyViewController.h"
#import "StrategyTops.h"
#import "AllCollectionViewCell.h"
#import "EnterTopScrollViewController.h"
#define KURL @"http://api.liwushuo.com/v2/collections?limit=10&offset=0"
@interface AllStrategyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate> {
    UICollectionView *_collectionView;
    NSString *_urlStr;
    CGFloat maxHeight;
}
@property (nonatomic ,retain) NSMutableArray *dataArr;

@end

@implementation AllStrategyViewController
- (NSMutableArray * )dataArr {
    if (!_dataArr) {
        _dataArr =[NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView=[UILabel setUpNavTitleViewWithText:@"礼物说"];
    [self createCollectionView];
}
- (void) createCollectionView {
    UICollectionViewFlowLayout *layOut=[[UICollectionViewFlowLayout alloc]init];
    layOut.scrollDirection=UICollectionViewScrollDirectionVertical;
    layOut.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    layOut.itemSize=CGSizeMake(kScreenWidth-20, (kScreenHeight-40)/3);
    _collectionView=[[UICollectionView alloc]initWithFrame:kScreenBounds collectionViewLayout:layOut];
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_collectionView];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [_collectionView registerNib:[UINib nibWithNibName:@"AllCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    _urlStr=KURL;
    [self getData];
    }
#pragma mark------>请求数据
- (void) getData {
    [HttpManager getDataForClassMainVCOfStategyWithURL:_urlStr WithBlock:^(NSMutableArray *array, NSString *url) {
        [self.dataArr addObjectsFromArray:array];
        [_collectionView reloadData];
        _urlStr=url;
    }];
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AllCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    StrategyTops *obj=self.dataArr[indexPath.row];
  
    cell.model=obj;
    return cell;
}
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EnterTopScrollViewController *VC=[[EnterTopScrollViewController alloc]init];
    StrategyTops * obj =self.dataArr[indexPath.row];
    VC.model=obj;
    [self.navigationController pushViewController:VC animated:YES];

}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentSize.height<=0) {
        return;
    }
        if (maxHeight<scrollView.contentSize.height) {
        maxHeight= scrollView.contentSize.height;
  }
    CGFloat bottomHeight =scrollView.contentSize.height-scrollView.contentOffset.y-kScreenHeight;
    if (maxHeight==scrollView.contentSize.height) {
        if (bottomHeight<(kScreenHeight-40)/3) {
            [self getData];
        
           
          maxHeight++;
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

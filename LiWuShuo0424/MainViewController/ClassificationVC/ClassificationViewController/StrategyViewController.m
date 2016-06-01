//
//  StrategyViewController.m
//  LiWuShuo0424
//
//  Created by student on 16/4/28.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "StrategyViewController.h"
#import "StrategyTops.h"
#import "StrategView.h"
#import "StrategyHeader.h"
#import "StrategyItem.h"
#import "cellView.h"
#import "EnterTopScrollViewController.h"
#import "AllStrategyViewController.h"
#import "DetailItemsViewController.h"
#define KURL @"http://api.liwushuo.com/v2/collections?limit=10&offset=0"
#define KScrollBtnWidth 150
#define KScrollBtnHeight  80
#define KTopViewHeight  44
#define KViewHeight 100
@interface StrategyViewController () <UICollectionViewDataSource,UICollectionViewDelegate,StrategyDelegate>{
    NSString *urlStr;
    UICollectionView *MidCollectionView;
    UIScrollView *bgScrollView;
}
@property (nonatomic,retain) NSMutableArray *headerArr;
@property (nonatomic ,retain) NSMutableArray *itemsArr;
@property (nonatomic ,retain) NSMutableDictionary *dataDictionary;
@end

@implementation StrategyViewController
- (NSMutableArray*) headerArr {
    if (!_headerArr) {
        _headerArr=[NSMutableArray array];
    }
    return _headerArr;
}

- (NSMutableArray *) itemsArr {
    if (!_itemsArr) {
        _itemsArr=[NSMutableArray array];
    }
    return _itemsArr;
}
- (NSMutableDictionary*) dataDictionary {
    if (!_dataDictionary) {
        _dataDictionary=[NSMutableDictionary dictionary];
    }
    return _dataDictionary;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        bgScrollView=[[UIScrollView alloc]initWithFrame:kScreenBounds];
       [self.view addSubview:bgScrollView];
    [self createTopScrollView];
    [self createMidCollectionView];
        }
#pragma mark---------->创建顶部的scrollView
- (void) createTopScrollView {
  
    StrategView *topView=[[StrategView alloc]init];
    topView.frame=CGRectMake(0, 64, kScreenWidth, KScrollBtnHeight+KTopViewHeight);
    topView.delegate=self;
    [topView setUpView];
    [bgScrollView addSubview:topView];
}

#pragma mark------->strategyView的代理方法
- (void) topScrollViewBtnClickWithIndex:(StrategyTops*) model {
    NSLog(@"%@",model);
    EnterTopScrollViewController *VC=[[EnterTopScrollViewController alloc]init];
    VC.model=model;
    [self.navigationController pushViewController:VC animated:YES];
   }

- (void) checkAllMenuTitle {
    AllStrategyViewController *VC=[[AllStrategyViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark--------->创建中间的CollectionView
- (void) createMidCollectionView {
    UICollectionViewFlowLayout *layOut=[[UICollectionViewFlowLayout alloc]init];
    layOut.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    layOut.scrollDirection= UICollectionViewScrollDirectionVertical;
    layOut.itemSize=CGSizeMake((kScreenWidth-50)/4, (kScreenWidth-50)/4);
//    layOut.footerReferenceSize=CGSizeMake(kScreenWidth, 10);
    layOut.headerReferenceSize=CGSizeMake(kScreenWidth, 60);
    MidCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+KScrollBtnHeight+KTopViewHeight, kScreenWidth, kScreenHeight-KScrollBtnHeight-KTopViewHeight-64-49) collectionViewLayout:layOut];
   
    MidCollectionView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:MidCollectionView];
   MidCollectionView.delegate=self;
   MidCollectionView.dataSource=self;
    [MidCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [MidCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusable"];
    [HttpManager getDataForClassMainVCOfStategyCollectionItemsWithBlock:^(NSMutableDictionary *dic) {
        self.dataDictionary=dic;
        self.headerArr=[NSMutableArray arrayWithArray:dic.allKeys];
        [MidCollectionView reloadData];
          }];
    
}
#pragma mark------>区的个数
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  self.headerArr.count;
}
#pragma mark----->cell的个数
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSMutableArray*arr= self.dataDictionary[self.headerArr[section]];
    return arr.count;
}
#pragma mark------>cell的样式
- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIView *oldView=[cell viewWithTag:1000];
    [oldView removeFromSuperview];
    StrategyItem *obj=self.dataDictionary[self.headerArr[indexPath.section]][indexPath.row];
    cellView *view=[[cellView alloc]initWithModel:obj];
    
    [cell addSubview:view];
    
    return cell;
}
#pragma mark---------->区头的样式
- (UICollectionReusableView*) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"reusable" forIndexPath:indexPath];
    for (UIView *view in reusableView.subviews) {
        [view removeFromSuperview];
    }
    UILabel *headLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth, 60)];
       headLabel.text=self.headerArr[indexPath.section];
      [reusableView addSubview:headLabel];
    return reusableView;
}
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
     StrategyItem *obj=self.dataDictionary[self.headerArr[indexPath.section]][indexPath.row];
    DetailItemsViewController *VC=[[DetailItemsViewController alloc]init];
    VC.ID=obj.ID;
    VC.name=obj.name;
    [self.navigationController pushViewController:VC animated:YES];
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

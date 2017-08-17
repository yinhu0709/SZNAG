//
//  GiftViewController.m
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/28.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "GiftViewController.h"
#import "GiftCategory.h"
#import "GiftCollectionViewCell.h"
#import "GiftSubCategory.h"
#import "GiftCollectionReusableView.h"
#import "GiftDetailViewController.h"
#define KTableViewWidth 90
#define KItemHeight 120

@interface GiftViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>{
      UICollectionView *_collectionView;
    UIScrollView *_scrollView;
    UITableView *_tableView;
    UIView *_sildeView;
}
@property (nonatomic,retain) NSMutableArray *tableArr;
@property (nonatomic,retain) NSMutableArray *collectArr;
@end

@implementation GiftViewController
- (NSMutableArray*) tableArr {
    if (!_tableArr) {
        _tableArr=[NSMutableArray array];
    }
    return _tableArr;
}
- (NSMutableArray*) collectArr {
    if (_collectArr) {
        _collectArr=[NSMutableArray array];
    }
    return _collectArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIButton *chooseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    chooseBtn.frame=CGRectMake(0, 64, kScreenWidth, 44);
    [chooseBtn setBackgroundImage:[UIImage imageNamed:@"chooseGiftBtn"] forState:UIControlStateNormal];
    chooseBtn.layer.borderWidth=1;
    chooseBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [chooseBtn addTarget:self action:@selector(chooseGiftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chooseBtn];
    [self createTableViewAndCollectionView];
   }
#pragma mark------->选礼神器按钮点击事件
- (void) chooseGiftBtnClick:(UIButton*) sender {
    
}
- (void) createTableViewAndCollectionView {
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 44+64, 2, kScreenHeight-44-64-49)];
    _sildeView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 2, 44)];
    _sildeView.backgroundColor=[UIColor redColor];
    [_scrollView addSubview:_sildeView];
    _scrollView.showsVerticalScrollIndicator=NO;
      [self.view addSubview:_scrollView];
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(2, 44+64, KTableViewWidth, kScreenHeight-44-64-49) style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tag=1000;
   
       [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
    
     UICollectionViewFlowLayout *layOut=[[UICollectionViewFlowLayout alloc]init];
    layOut.scrollDirection=UICollectionViewScrollDirectionVertical;
    layOut.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    layOut.itemSize=CGSizeMake((kScreenWidth-KTableViewWidth-40)/3, KItemHeight);
   layOut.headerReferenceSize=CGSizeMake(kScreenWidth-KTableViewWidth, KItemHeight/2);
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(KTableViewWidth, 44+64, kScreenWidth-KTableViewWidth, kScreenHeight-64-44-49) collectionViewLayout:layOut];
    _collectionView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_collectionView];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.tag=10010;
    _collectionView.showsVerticalScrollIndicator=NO;
    [_collectionView registerNib:[UINib nibWithNibName:@"GiftCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"GiftCollectionReusableView"bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
       [HttpManager getDataForClassMainVCOfGiftCollectionItemsWithBlock:^(NSMutableArray *tabArr, NSMutableArray *collArr) {
        self.collectArr=collArr;
        [_collectionView reloadData];
        self.tableArr=tabArr;
       _scrollView.contentSize=CGSizeMake(0, self.tableArr.count*44);
        [_tableView reloadData];
         [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
      
      }];
    
}

#pragma mark ----->cell的个数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableArr.count;
}
//TODO: 神牛是个大秃头
#pragma mark  -------->cell的样式
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
       GiftCategory *obj=self.tableArr[indexPath.row];
    cell.textLabel.text=obj.name;
    cell.textLabel.font=[UIFont systemFontOfSize:14];
   
    cell.textLabel.highlightedTextColor=[UIColor redColor];
 
    return cell;
}
#pragma mark -------->选中cell激发的事件
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   UITableViewCell *acell =[tableView cellForRowAtIndexPath:indexPath];
    _sildeView.y=acell.y;
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
}
#pragma mark--------->没有被选中cell的激发事件
- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *acell =[tableView cellForRowAtIndexPath:indexPath];
//    GiftCategory*obj=self.tableArr[indexPath.row];
//    obj.selected=NO;
//    acell.textLabel.textColor=[UIColor blackColor];
  }
#pragma mark------>滑动scrollView
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag==1000) {
        _scrollView.contentOffset=scrollView.contentOffset;
    }
    if (scrollView.tag==10010) {
                   NSIndexPath *index=  [_collectionView indexPathForItemAtPoint:CGPointMake(200,_collectionView.contentOffset.y+80)];
//        NSLog(@"%ld,%ld",index.section,index.row);
        if (index.section!=0) {
//           [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index.section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
//           [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index.section inSection:0] atScrollPosition: UITableViewScrollPositionMiddle animated:YES];
         
             }
    }
}
#pragma mark--------->collectionView的cell个数
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    GiftCategory *obj=self.tableArr[section];
    return obj.subcategories.count;
    }
#pragma mark ------->collectionView 区·的个数
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.tableArr.count;
}
#pragma mark------>collectionView 的样式
- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   GiftCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"collectCell" forIndexPath:indexPath];
    GiftCategory *obj=self.tableArr[indexPath.section];
    GiftSubCategory *model=[GiftSubCategory initWithDictionary:obj.subcategories[indexPath.row]];
       cell.model=model;
    
    return cell;
}
#pragma mark------>collectionView区头的样式
- (UICollectionReusableView*) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    GiftCollectionReusableView *resuableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    GiftCategory *obj=self.tableArr[indexPath.section];

    resuableView.headerNameLabel.text=obj.name;
    return resuableView;
    
}
#pragma mark---------->collectionView item选中时激发事件
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GiftCategory *obj=self.tableArr[indexPath.section];
    GiftSubCategory *model=[GiftSubCategory initWithDictionary:obj.subcategories[indexPath.row]];
    GiftDetailViewController *detailVC=[[GiftDetailViewController alloc]init];
    detailVC.model=model;
    [self.navigationController pushViewController:detailVC animated:YES];
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

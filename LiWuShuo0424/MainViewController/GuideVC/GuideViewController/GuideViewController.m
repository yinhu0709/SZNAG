//
//  GuideViewController.m
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/24.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "GuideViewController.h"
#import "SearchViewController.h"
#import "Menu.h"
#import "TopScroll.h"
#import "BigScroll.h"
#import "MiddleCollectionViewCell.h"
#import "ContentTableViewCell.h"
#import "DetailViewController.h"
#import "PullDownView.h"
#define KPullDownBtnWidth  35
#define KPullDownBtnHeight 35
#define KMenuBtnWidth   60
#define KBigScrollViewHeight 150
#define KTableViewHeaderHeight 230


@interface GuideViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MiddleCollectionCellDelegate,PullDownViewDelegate>
@property (nonatomic,retain) UIScrollView *menuScrollView;
@property (nonatomic ,retain)UIView *slideView;
@property (nonatomic ,retain) UICollectionView *middleCollectionView;
@property (nonatomic ,retain) NSMutableArray *dataArr;
@property (nonatomic ,retain) NSMutableArray *bigSArr;
@property (nonatomic ,retain) NSMutableArray *smallSArr;
@property (nonatomic ,retain) NSMutableArray *tableArr;
@end

@implementation GuideViewController
- (NSMutableArray*) dataArr {
    if (!_dataArr) {
        _dataArr =[NSMutableArray array];
    }
    return _dataArr;
}
- (NSMutableArray*) bigSArr {
    if (!_bigSArr) {
        _bigSArr=[NSMutableArray array];
    }
    return _bigSArr;
}

- (NSMutableArray*) smallSArr {
    if (!_smallSArr) {
        _smallSArr =[NSMutableArray array];
        
    }
    return _smallSArr;
    
}
- (NSMutableArray*) tableArr {
    if (!_tableArr) {
        _tableArr=[NSMutableArray array];
        
    }
    return _tableArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUpNavBar];
    [self setUpMenu];
    [self setUpMiddleCollectionView];
}
#pragma mark---->设置导航条
- (void) setUpNavBar {
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navleft_1"] style: UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
     self.navigationItem.titleView=[UILabel setUpNavTitleViewWithText:@"礼物说"];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(searchBtnClick)];
   }
#pragma mark------>设置菜单栏
- (void) setUpMenu {
    self.menuScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth-KPullDownBtnWidth, KPullDownBtnHeight)];
    self.menuScrollView.backgroundColor=[UIColor whiteColor];
    UIButton *pullDownBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    pullDownBtn.frame=CGRectMake(self.menuScrollView.bounds.size.width, 64, KPullDownBtnWidth, KPullDownBtnHeight);
    [pullDownBtn setBackgroundImage:[UIImage imageNamed:@"pullDownBtn"] forState:UIControlStateNormal];
    [self.view addSubview:pullDownBtn];
    [pullDownBtn addTarget:self action:@selector(pullDownBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _slideView=[[UIView alloc]initWithFrame:CGRectMake(0, KPullDownBtnHeight-2, KMenuBtnWidth, 2)];
    _slideView.backgroundColor=[UIColor redColor];
    [self.menuScrollView addSubview:_slideView];
    [self.view addSubview:self.menuScrollView];
    
  [HttpManager getDataForGuideVCMenuDataWithBlock:^(NSArray *array) {
            self.dataArr=[NSMutableArray arrayWithArray:array];
      [self.middleCollectionView reloadData];
      self.menuScrollView.contentSize=CGSizeMake(array.count*(KMenuBtnWidth+20), 0);
      self.menuScrollView.showsHorizontalScrollIndicator=NO;
      for (int i=0; i<array.count; i++) {
          UIButton *menuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
          menuBtn.frame=CGRectMake(i*(KMenuBtnWidth+20), 0, KMenuBtnWidth, KPullDownBtnHeight-2);
         menuBtn.backgroundColor=[UIColor whiteColor];
          Menu *obj=array[i];
         [menuBtn setTitle:obj.name forState:UIControlStateNormal];
          [menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          menuBtn.titleLabel.font=[UIFont systemFontOfSize:15];
          menuBtn.tag=i+1;
          [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
          [self.menuScrollView addSubview:menuBtn];
             }
       }];
}
# pragma mark----》创建一个collectionView然后上面放一些大cell 可以横向滑动 cell上tableView 展示数据 tag=10010
- (void) setUpMiddleCollectionView {
    CGRect rect=CGRectMake(0, KPullDownBtnHeight+64, kScreenWidth, kScreenHeight-KPullDownBtnHeight-64-49) ;
    UICollectionViewFlowLayout *layOut=[[UICollectionViewFlowLayout alloc]init];
    layOut.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layOut.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
//    layOut.minimumInteritemSpacing=0.f;
    layOut.minimumLineSpacing=0.f;
//    layOut.itemSize=CGSizeMake(self.middleCollectionView.bounds.size.width, self.middleCollectionView.bounds.size.height);
    self.middleCollectionView=[[UICollectionView alloc]initWithFrame:rect collectionViewLayout:layOut];
    self.middleCollectionView.backgroundColor=[UIColor whiteColor];
    self.middleCollectionView.pagingEnabled=YES;
    self.middleCollectionView.delegate=self;
    self.middleCollectionView.tag=10010;
    self.middleCollectionView.dataSource=self;
    [self.view addSubview:self.middleCollectionView];
    [self.middleCollectionView registerClass:[MiddleCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
  
    [HttpManager getDataForGuideVCSecondScrollViewDataWithBlock:^(NSArray *array) {
        self.smallSArr=[NSMutableArray arrayWithArray:array];
        [HttpManager getDataForGuideVCTopScrollViewDataWithBlock:^(NSArray *array, NSArray *targetArray) {
            self.bigSArr=[NSMutableArray arrayWithArray:array];
            [self.middleCollectionView reloadData];
            }];
        }];
     }
    
#pragma mark--->middleCollectionView上cell的个数
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    return self.dataArr.count;
}
#pragma mark---->middleCollectionView上cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(kScreenWidth, self.middleCollectionView.bounds.size.height);
}

#pragma mark------>设置middleCollectionView上cell的样式
- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MiddleCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate=self;
    Menu *obj=self.dataArr[indexPath.row];
    [cell setUpCellWith:obj ];
    if (indexPath.row==0) {
        [cell setTableViewHeader:self.bigSArr and:self.smallSArr];
    }
         return cell;
}
#pragma mark------->当middleCollectionView停止减速的时候
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag==10010) {
        NSInteger a=scrollView.contentOffset.x/kScreenWidth;
        UIButton *button=[self.menuScrollView viewWithTag:a+1];
        [UIView animateWithDuration:0.2 animations:^{
            self.slideView.x=button.x;
        }];
        if (a>=1&&a<self.dataArr.count-3) {
                       [UIView animateWithDuration:0.2 animations:^{
                [self.menuScrollView setContentOffset:CGPointMake((a-1)*(KMenuBtnWidth+20), 0)];
            }];
        }
    }
}
#pragma mark------> MiddleCell的代理
- (void) goToDetaliVCWithUrl:(NSString *)urlStr {
    DetailViewController *detailVC=[[DetailViewController alloc]init];
    detailVC.urlStr=urlStr;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark----->菜单按钮点击事件
- (void) menuBtnClick:(UIButton*) sender {
//    tag=i+1;
    [self.middleCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:sender.tag-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    _slideView.x=sender.x;
}
#pragma mark---->下拉按钮点击事件
- (void) pullDownBtnClick:(UIButton*) sender {
   NSInteger index= self.middleCollectionView.contentOffset.x/kScreenWidth;
    PullDownView *pullDownView=[[PullDownView alloc]initWithBtnArray:self.dataArr andIndex:index];
    pullDownView.delegate=self;
  
    [self.view addSubview:pullDownView];
    
}
#pragma mark------>pulldownView 选中menu的代理方法
- (void) changeSelectMenuWith:(NSInteger)offestX {
    [self.middleCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:offestX inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    UIButton *button=[self.menuScrollView viewWithTag:offestX+1];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.slideView.x=button.x;
     }];

    if (offestX>=1) {
        if (offestX>self.dataArr.count-4) {
            [self.menuScrollView setContentOffset:CGPointMake((self.dataArr.count-5)*(KMenuBtnWidth+20), 0) animated:YES];
               } else {
        [self.menuScrollView setContentOffset:CGPointMake((offestX-1)*(KMenuBtnWidth+20), 0) animated:YES];
        }
         }
}
#pragma mark---->导航条左侧按钮点击事件
- (void) leftBarButtonItemClick {
    
}
#pragma mark---->导航条右侧按钮点击事件 
- (void) searchBtnClick {
    SearchViewController *searchVC=[[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
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

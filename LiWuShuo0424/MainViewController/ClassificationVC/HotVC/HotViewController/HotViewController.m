//
//  HotViewController.m
//  LiWuShuo0424
//
//  Created by student on 16/4/24.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "HotViewController.h"
#import "HotCollectionViewCell.h"
#import "HotGift.h"
#import "HotDetailViewController.h"
#define KCellHeight kScreenWidth/2*1.3
#define KHOTCollURL  @"http://api.liwushuo.com/v2/items?limit=20&offset=0&gender=1&generation=1"
// http://api.liwushuo.com/v2/items?generation=1&gender=1&limit=20&offset=20";
@interface HotViewController ()<UICollectionViewDataSource,UICollectionViewDelegate> {
    NSString *strUrl;
    CGFloat maxContSizeHeight;
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
    layOut.sectionInset=UIEdgeInsetsMake(10, 10, 0, 10);
          layOut.itemSize=CGSizeMake((kScreenWidth-30)/2, KCellHeight);
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)collectionViewLayout:layOut];
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"HotCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    strUrl=KHOTCollURL;

    [self getData];
    
}
#pragma mark------》请求数据
- (void) getData {
    [HttpManager whatTypeOfNetworkWithBlock:^(NSString *string) {
         NSLog(@"%@",string);
        if ([string isEqualToString:@"3G|4G"]||[string isEqualToString:@"WiFi"]) {
            [HttpManager getDataForHotVCCollectionViewOfDataWithURL:strUrl  WithBlock:^(NSMutableArray *array, NSString *nextUrl) {
                
                [self.dataArr addObjectsFromArray:array];
                [self.collectionView reloadData];
                strUrl=nextUrl;
            }];

        } else {
//            NSLog(@"没有网络，请求数据失败");
        }
       
    }];
   }
#pragma mark-----导航条右侧按钮点击事件
- (void) searchBtnClick {
    
}
#pragma mark---->cell的个数
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.dataArr.count;
}
#pragma mark----->cell的样式
- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    HotGift *model=self.dataArr[indexPath.row];
    cell.model=model;
    return cell;
}
#pragma mark------>选中时激发事件
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HotDetailViewController *detailVC=[[HotDetailViewController alloc]init];
    detailVC.model=self.dataArr[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark----->滑动的代理
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentSize.height<=0) {
        return;
    }
    if (maxContSizeHeight<scrollView.contentSize.height) {
         maxContSizeHeight=scrollView.contentSize.height;
    }
   
           CGFloat scrolledHeight = scrollView.contentSize.height-(scrollView.contentOffset.y+64)-kScreenHeight+64+49;
    if (maxContSizeHeight==scrollView.contentSize.height) {
        if (scrolledHeight<KCellHeight) {

                        [self getData];
            maxContSizeHeight++;
            
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

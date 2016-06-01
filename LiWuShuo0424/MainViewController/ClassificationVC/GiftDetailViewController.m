//
//  GiftDetailViewController.m
//  LiWuShuo0424
//
//  Created by student on 16/5/6.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "GiftDetailViewController.h"
#import "GiftSubCategory.h"
#import "HotCollectionViewCell.h"  
#import "HotDetailViewController.h"
#import "HotGift.h"
#define KCellHeight kScreenWidth/2*1.3
@interface GiftDetailViewController () <UICollectionViewDelegate,UICollectionViewDataSource>{
    NSString * _urlStr;
    UICollectionView *_collectionView;
    CGFloat maxContSizeHeight;
}

@property (nonatomic ,retain) NSMutableArray *dataArr;
@end

@implementation GiftDetailViewController
- (NSMutableArray*) dataArr {
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView=[UILabel setUpNavTitleViewWithText:self.model.name];
  
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"choose_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(chooseBtnClick)];
    [self setUpCollectionView];
 }
- (void) chooseBtnClick {
    
}
#pragma mark---->创建collectionView
- (void) setUpCollectionView {
    //    CGRect rect=CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
    UICollectionViewFlowLayout *layOut=[[UICollectionViewFlowLayout alloc]init];
    layOut.scrollDirection=UICollectionViewScrollDirectionVertical;
    layOut.sectionInset=UIEdgeInsetsMake(10, 10, 0, 10);
    layOut.itemSize=CGSizeMake((kScreenWidth-30)/2, KCellHeight);
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)collectionViewLayout:layOut];
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [_collectionView registerNib:[UINib nibWithNibName:@"HotCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
    NSString *str=[NSString stringWithFormat:@"http://api.liwushuo.com/v2/item_subcategories/%ld/items?limit=20&offset=0",self.model.ID];
    _urlStr=str;
    [self getData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ----->请求数据
- (void) getData {
    [HttpManager getDataForClassMainVCOfGiftCollectionItemsWithUrl:_urlStr DetailWithBlock:^(NSMutableArray *array,NSString*nextUrl) {
               [self.dataArr addObjectsFromArray:array];
        [_collectionView reloadData];
        _urlStr=nextUrl;
    }];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

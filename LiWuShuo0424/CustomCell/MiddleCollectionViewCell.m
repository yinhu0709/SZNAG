//
//  MiddleCollectionViewCell.m
//  LiWuShuo0424
//
//  Created by student on 16/4/25.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "MiddleCollectionViewCell.h"
#import "TopScroll.h"
#import "BigScroll.h"
#import "BottomTable.h"
#import "ContentTableViewCell.h"
#import "DetailViewController.h"
#import "Menu.h"
#define KBigScrollViewHeight 150
#define KTableViewHeaderHeight 235
#define KSmallViewWidth 88
#define KCellHeight  180
#define KURL @"http://api.liwushuo.com/v2/channels/103/items?ad=2&gender=2&generation=1&limit=20&offset=0"
static NSTimer *timer = nil;
@interface  MiddleCollectionViewCell () <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    UIScrollView *bigScrollView;
    UIPageControl *pageControl;
    NSInteger arrCount;
    NSMutableArray *dataArr;
    NSMutableArray *bigSCArr;
    CGFloat  MaxContentSizeH;
    NSString *urlStr;
}
@end
@implementation MiddleCollectionViewCell

- (void)  setUpCellWith:(Menu*)model  {
     self.tableView=[[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
     
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tag=10086;
    self.tableView.showsVerticalScrollIndicator=NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"ContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"tableViewCell"];
    [self addSubview:self.tableView];
    NSString *url=[NSString stringWithFormat:@"http://api.liwushuo.com/v2/channels/%ld/items?ad=2&gender=2&generation=1&limit=20&offset=0",model.ID];
    [HttpManager getDataForGuideVCTableViewOfDataWith:url
                                            WithBlock:^( NSMutableArray *tableArr, NSString *nextUrl) {
                                                dataArr=tableArr;
                                                urlStr=nextUrl;
                                                [self.tableView reloadData];
                                                MaxContentSizeH=self.tableView.contentSize.height;
                                            }];

}

#pragma mark----.设置第一个tableView的表头
- (void) setTableViewHeader:(NSMutableArray*) bigArr and:(NSMutableArray*) smallArr  {
arrCount=bigArr.count;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KTableViewHeaderHeight)];
//    创建pageControl
    pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(100, KBigScrollViewHeight-20, kScreenWidth-200, 20)];
    pageControl.numberOfPages=bigArr.count;
    [pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
   
//    创建大scrollView
    bigScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KBigScrollViewHeight)];
    bigScrollView.contentSize=CGSizeMake(kScreenWidth*bigArr.count, 0);
    bigScrollView.pagingEnabled=YES;
    bigScrollView.delegate =self;
    bigScrollView.showsHorizontalScrollIndicator=NO;
    bigSCArr=bigArr;
        for (int i=0; i<bigArr.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(i*kScreenWidth, 0, kScreenWidth, KBigScrollViewHeight);
        BigScroll *obj=bigArr[i];
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:obj.image_url] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(topScrollViewClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i+100;
            bigScrollView.tag=99;
        [bigScrollView addSubview:btn];
    }
//    创建小scrollView
    UIScrollView *smallView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, KBigScrollViewHeight+5, kScreenWidth, KTableViewHeaderHeight-KBigScrollViewHeight-5)];
    smallView.contentSize=CGSizeMake((KSmallViewWidth+5)*smallArr.count, 0);
    smallView.showsHorizontalScrollIndicator=NO;

    for (int i=0; i<smallArr.count; i++) {
        TopScroll *obj=smallArr[i];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(5+i*(KSmallViewWidth+5), 0, KSmallViewWidth, smallView.bounds.size.height);
       
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:obj.image_url] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(smallScrollViewClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i+1000;
        [smallView addSubview:btn];
    }
    [view addSubview:bigScrollView];
     [view addSubview:pageControl];
    [view addSubview:smallView];
    self.tableView.tableHeaderView=view;
   
    if (!timer) {
//         NSLog(@"定时器");
       timer= [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollViewScrolling) userInfo:nil repeats:YES];
    }
    }
#pragma mark----->定时器激发事件
- (void) scrollViewScrolling {
    static int page=1;
    pageControl.currentPage=pageControl.currentPage+page;
    if (pageControl.currentPage==0||pageControl.currentPage==arrCount-1) {
        page=-page;
    }
    [UIView animateWithDuration:1 animations:^{
        bigScrollView.contentOffset=CGPointMake(pageControl.currentPage%arrCount*kScreenWidth, 0);
    }];
}
/*
 * tableView的代理方法
 
 */
#pragma mark----->cell的个数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}
#pragma mark-----》cell的样式
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    BottomTable *obj=dataArr[indexPath.row];
    cell.model = obj;
    cell.tag=indexPath.row;
    cell.likeBtn.tag=indexPath.row+1;
    [cell.likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark----->点赞按钮激发事件
- (void)likeBtnClick:(UIButton*) sender {
//    ContentTableViewCell *cell=[self.tableView viewWithTag:sender.tag-1];
//    BottomTable *obj=dataArr[sender.tag-1];
//    if (sender.selected) {
//        cell.likeCountLabel.text=[NSString stringWithFormat:@"%ld",obj.likes_count];
//        sender.selected=NO;
//    } else {
//   
//    cell.likeCountLabel.text=[NSString stringWithFormat:@"%ld",obj.likes_count+1];
//      sender.selected=YES;
//    }
}
#pragma mark----->cell的高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KCellHeight;
}
#pragma mark---->设置区头的高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

#pragma mark------->设置区头的内容
- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *timeLabel=[[UILabel alloc]init];
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日 EEEE"];
    NSArray *array=@[@"星期天",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    [formatter setWeekdaySymbols:array];
    NSString *dateStr=[formatter stringFromDate:date];
    timeLabel.text=dateStr;
    
    
    return timeLabel;
    
}
#pragma mark---->选中cell激发的事件
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(goToDetaliVCWithUrl:)]) {
        NSString *str=((BottomTable*)dataArr[indexPath.row]).url;
        [self.delegate goToDetaliVCWithUrl:str];
    }
}
#pragma mark----->pageControl
- (void)pageChange:(UIPageControl*) sender {
    
}
#pragma mark----->大scrollView的点击事件
- (void) topScrollViewClick: (UIButton *) sender {
    if ([self.delegate respondsToSelector:@selector(goToDetaliVCWithUrl:)]) {
        BigScroll *obj=bigSCArr[sender.tag-100];
        NSString *str=[NSString stringWithFormat:@"http://www.liwushuo.com/collections/%ld",obj.target_id];
        NSLog(@"%@",str);
        [self.delegate goToDetaliVCWithUrl:str];
    
    NSLog(@"大 点击事件");
}
}
#pragma mark------>小scrollView的点击事件
- (void) smallScrollViewClick:(UIButton *) sender {
    NSLog(@"小 点击事件");
}
#pragma mark---->tableView滑动时调用的方法
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag==10086) {
               
        if (scrollView.contentSize.height==MaxContentSizeH) {
            CGFloat bottomHeight=scrollView.contentSize.height-scrollView.contentOffset.y-kScreenHeight;
            if (bottomHeight<KCellHeight) {
              
                [self getData];
                MaxContentSizeH++;
            }
        }
    }
    if(scrollView.contentOffset.y>KTableViewHeaderHeight) {
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
    } else {
        if (!timer) {
                timer= [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollViewScrolling) userInfo:nil repeats:YES];
        }
    }
}
#pragma mark--->上拉加载 请求数据
- (void) getData {
    [HttpManager getDataForGuideVCTableViewOfDataWith:urlStr WithBlock:^(NSMutableArray *arr, NSString *nextUrl) {
        [dataArr addObjectsFromArray:arr];
        [self.tableView reloadData];
        urlStr=nextUrl;
        MaxContentSizeH=self.tableView.contentSize.height;
        
    }];
  }

@end

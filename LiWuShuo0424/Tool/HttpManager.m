//
//  HttpManager.m
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/24.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "HttpManager.h"
#import "AFNetworking.h"
#import "Menu.h"
#import "TopScroll.h"
#import "BigScroll.h"
#import "BottomTable.h"
#import "HotGift.h"
#import "StrategyTops.h"
#import "StrategyHeader.h"
#import "StrategyItem.h"
#import "GiftCategory.h"
#import "GiftSubCategory.h"
@implementation HttpManager

#pragma mark ------》判断网络类型
+ (void) whatTypeOfNetworkWithBlock:(void(^)(NSString*string))comleteBlock {
 __block   NSString *network=[[NSString alloc]init];
  
    
    
    AFNetworkReachabilityManager *manager =[AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
         NSLog(@"dafafgafafa");
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
               network=@"未知";
                break;
                case AFNetworkReachabilityStatusNotReachable:
                network=@"没有网络";
                break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                network=@"WiFi";
                case AFNetworkReachabilityStatusReachableViaWWAN:
                network=@"3G|4G";
                break;
            default:
                break;
        }
        
        if (comleteBlock) {
            comleteBlock (network);
        }
            }];
    [manager startMonitoring];
   
}








#pragma mark----->请求指南界面菜单栏的数据
+ (void) getDataForGuideVCMenuDataWithBlock:(void(^)(NSArray*array))comleteBlock {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:@"http://api.liwushuo.com/v2/channels/preset?gender=2&generation=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
//        SZNLog(@"%@",responseObject);
        NSDictionary *dataDic=responseObject[@"data"];
        NSArray *dataArr=dataDic[@"candidates"];
        NSMutableArray *arr=[NSMutableArray array];
        Menu *model=[[Menu alloc]init];
        model.name=@"精选";
        model.ID=103;
        [arr addObject:model];
        for (NSMutableDictionary *dic in dataArr) {
            Menu *obj=[Menu initWithDictionary:dic];
            [arr addObject:obj];
        
        }
      
        if (comleteBlock) {
            comleteBlock (arr);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SZNLog(@"%@",error.localizedDescription);
    }];
   }

#pragma mark------>请求指南界面第二个scrollView上的数据
+ (void) getDataForGuideVCSecondScrollViewDataWithBlock:(void (^)(NSArray *array))comleteBlock  {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:@"http://api.liwushuo.com/v2/secondary_banners?gender=2&generation=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
//        SZNLog(@"%@",responseObject);
        NSDictionary *dataDic=responseObject[@"data"];
        NSArray *dataArr=dataDic[@"secondary_banners"];
        NSMutableArray*arr=[NSMutableArray array];
      
        for (NSDictionary*dic in dataArr) {
          TopScroll *obj=[TopScroll initWithDictionary:dic];
                      [arr addObject:obj];
        }
        if (comleteBlock) {
            comleteBlock (arr);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SZNLog(@"%@",error.localizedDescription);
    }];
}

#pragma mark---->请求指南界面topScrollView的数据
+ (void) getDataForGuideVCTopScrollViewDataWithBlock:(void (^)(NSArray *array,NSArray*targetArray))comleteBlock {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:@"http://api.liwushuo.com/v2/banners?banners?channel=iOS" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary* responseObject) {
//      SZNLog(@"%@",responseObject);
        NSDictionary *dataDic=responseObject[@"data"];
        NSArray *dataArr=dataDic[@"banners"];
        NSMutableArray *arr=[NSMutableArray array];
          NSMutableArray *tagretArr=[NSMutableArray array];
        for (NSDictionary *dic in dataArr) {
            if ([dic[@"type"] isEqualToString:@"collection"]) {
                BigScroll *obj=[BigScroll initWithDictionary:dic];
                
                Target *model=[Target initWithDictionary:obj.target];
                [tagretArr addObject:model];
                
                [arr addObject:obj];
            }
            
        }
        if (comleteBlock) {
            comleteBlock (arr,tagretArr);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SZNLog(@"%@",error.localizedDescription);
    }];
}
#pragma mark------>指南界面tableView的请求数据
+ (void) getDataForGuideVCTableViewOfDataWith:(NSString*)URL WithBlock:(void (^)( NSMutableArray *,NSString*next))comleteBlock {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
//       SZNLog(@"%@",responseObject);
        NSDictionary *dataDic=responseObject[@"data"];
        NSArray *dataArr=dataDic[@"items"];
        NSMutableArray*arr=[NSMutableArray array];
        NSDictionary *nextDic=dataDic[@"paging"];
        NSString*nextUrl=nextDic[@"next_url"];
        for (NSDictionary *dic in dataArr) {
            BottomTable *obj=[BottomTable initWithDictionary:dic];
            [arr addObject:obj];
        }
        if (comleteBlock) {
            comleteBlock (arr ,nextUrl);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SZNLog(@"%@",error.localizedDescription);
    }];
}

#pragma mark------》热门界面的 请求数据
+ (void) getDataForHotVCCollectionViewOfDataWithURL:(NSString*)URL WithBlock:(void (^)(NSMutableArray *,NSString*))comleteBlock{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary* responseObject) {
        NSDictionary *dataDic=responseObject[@"data"];
        NSMutableArray *arr =[NSMutableArray array];
        NSArray *itemArray= dataDic[@"items"];
        for (NSDictionary *bigDic in itemArray ) {
            NSDictionary *deletailDic=bigDic[@"data"];
            HotGift *obj=[HotGift initWithDictionary:deletailDic];
            [arr addObject:obj];
        }
        NSString *nextUrl=dataDic[@"paging"][@"next_url"];
        if (comleteBlock) {
            comleteBlock (arr,nextUrl);
        }
//              SZNLog(@"%@",responseObject);
//        NSLog(@"%@",nextUrl);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SZNLog(@"%@",error.localizedDescription);
    }];
}
#pragma mark------>分类界面 攻略 专题 scrollView的url
+ (void) getDataForClassMainVCOfStategyWithURL:(NSString*)URL WithBlock:(void(^)(NSMutableArray*,NSString*))comleteBlock {
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
//       NSLog(@"%@",responseObject);
        NSDictionary *dataDic=responseObject[@"data"];
        NSString *str=dataDic[@"paging"][@"next_url"];
        NSArray *dataArr=dataDic[@"collections"];
        NSMutableArray *arr=[NSMutableArray array];
        for (NSDictionary *dic in dataArr) {
            StrategyTops * obj=[StrategyTops initWithDictionary:dic];
            [arr addObject:obj];
        }
        if (comleteBlock) {
            comleteBlock (arr,str);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}
#pragma mark------>分类界面 攻略 collectionViewItems的url
+ (void) getDataForClassMainVCOfStategyCollectionItemsWithBlock:(void (^)(NSMutableDictionary*))comleteBlock {
    AFHTTPSessionManager * manager= [AFHTTPSessionManager manager];
    [manager GET:@"http://api.liwushuo.com/v2/channel_groups/all" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
//        NSLog(@"%@",responseObject);
        NSDictionary *dataDic=responseObject[@"data"];
        NSArray *dataArr=dataDic[@"channel_groups"];
        NSMutableArray *groupArr=[NSMutableArray array];
        for (NSDictionary *bigDic in dataArr) {
            StrategyHeader *obj=[StrategyHeader initWithDictionary:bigDic];
            [groupArr addObject:obj];
        }
//        NSLog(@"%ld,%@",groupArr.count,groupArr);
        NSMutableDictionary *itemDic=[NSMutableDictionary dictionary];
        for (StrategyHeader *obj in groupArr) {
            NSArray *itemArr=obj.channels;
            NSString *key=obj.name;
            NSMutableArray *modelArr=[NSMutableArray array];
            for (NSDictionary*dic in itemArr) {
                StrategyItem *item=[StrategyItem initWithDictionary:dic];
                [modelArr addObject:item];
            }
            
            [itemDic setObject:modelArr forKey:key];
        
                    }
        if (comleteBlock) {
            comleteBlock (itemDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);

    }];
}
#pragma mark  ----------> 分类---礼物---url
+ (void) getDataForClassMainVCOfGiftCollectionItemsWithBlock:(void (^)(NSMutableArray *tabArr,NSMutableArray*collArr))comleteBlock {
    AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
    [manager GET:@"http://api.liwushuo.com/v2/item_categories/tree" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
//       NSLog(@"%@",responseObject);
        NSDictionary *dataDic=responseObject[@"data"];
        NSArray *dataArr=dataDic[@"categories"];
        NSMutableArray *categoryArr=[NSMutableArray array];
        for (NSDictionary *categoryDic in dataArr) {
            GiftCategory *obj=[GiftCategory initWithDictionary:categoryDic];
//            NSLog(@"%@,%ld",obj.name,obj.ID);
            [categoryArr addObject:obj];
        }
        NSMutableArray *subCategoryArr=[NSMutableArray array];
        for (GiftCategory *model in categoryArr) {
                       for (NSDictionary *subDic in model.subcategories) {
                GiftSubCategory *obj=[GiftSubCategory initWithDictionary:subDic];
                [subCategoryArr addObject:obj];
//                NSLog(@"%@,%ld",obj.name,obj.parent_id);
            }
        }
        if (comleteBlock) {
            comleteBlock (categoryArr,subCategoryArr);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}
#pragma mark--------->分类----礼物----点击items的链接
+ (void) getDataForClassMainVCOfGiftCollectionItemsWithUrl:(NSString*)URL DetailWithBlock:(void (^)(NSMutableArray *,NSString*nextUrl))comleteBlock {
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
//        SZNLog(@"%@",responseObject);
            NSDictionary *dataDic=responseObject[@"data"];
            NSMutableArray *arr =[NSMutableArray array];
            NSArray *itemArray= dataDic[@"items"];
            for (NSDictionary *bigDic in itemArray ) {
               
                HotGift *obj=[HotGift initWithDictionary:bigDic];
                [arr addObject:obj];
            }
            NSString *nextUrl=dataDic[@"paging"][@"next_url"];
            if (comleteBlock) {
                comleteBlock (arr,nextUrl);
            }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SZNLog(@"%@",error.localizedDescription);
    }];
}
@end

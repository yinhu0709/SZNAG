//
//  HttpManager.h
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/24.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpManager : NSObject

+ (void) whatTypeOfNetworkWithBlock:(void(^)(NSString*string))comleteBlock;

+ (void) getDataForGuideVCMenuDataWithBlock:(void(^)(NSArray*array))comleteBlock;
+ (void) getDataForGuideVCTopScrollViewDataWithBlock:(void (^)(NSArray *array,NSArray*targetArray))comleteBlock ;
+ (void) getDataForGuideVCSecondScrollViewDataWithBlock:(void (^)(NSArray *array))comleteBlock ;
+ (void) getDataForGuideVCTableViewOfDataWith:(NSString*)URL WithBlock:(void (^)( NSMutableArray*,NSString*nextUrl))comleteBlock;

+ (void) getDataForHotVCCollectionViewOfDataWithURL:(NSString*)URL WithBlock:(void (^)(NSMutableArray *,NSString*))comleteBlock;
+ (void) getDataForClassMainVCOfStategyWithURL:(NSString*)URL WithBlock:(void(^)(NSMutableArray*,NSString*))comleteBlock;
+ (void) getDataForClassMainVCOfStategyCollectionItemsWithBlock:(void (^)(NSMutableDictionary *))comleteBlock;
+ (void) getDataForClassMainVCOfGiftCollectionItemsWithBlock:(void (^)(NSMutableArray *tabArr,NSMutableArray*collArr))comleteBlock;
+ (void) getDataForClassMainVCOfGiftCollectionItemsWithUrl:(NSString*)URL DetailWithBlock:(void (^)(NSMutableArray *,NSString*nextUrl))comleteBlock;
@end

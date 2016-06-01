//
//  GiftSubCategory.h
//  LiWuShuo0424
//
//  Created by student on 16/5/3.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftSubCategory : NSObject
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,assign) NSInteger order;
@property (nonatomic,assign) NSInteger parent_id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *icon_url;
@property (nonatomic,copy) NSString *items_count;
- (id) initWithDictionary:(NSDictionary*) dic;
+ (id) initWithDictionary:(NSDictionary*) dic;
@end

//
//  StrategyItem.h
//  LiWuShuo0424
//
//  Created by student on 16/4/29.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StrategyItem : NSObject
@property (nonatomic,assign) NSInteger group_id;
@property (nonatomic,copy) NSString *icon_url;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,assign) NSInteger items_count;
@property (nonatomic,assign) NSInteger order;
- (id) initWithDictionary:(NSDictionary*) dic;
+ (id) initWithDictionary:(NSDictionary*) dic;
@end

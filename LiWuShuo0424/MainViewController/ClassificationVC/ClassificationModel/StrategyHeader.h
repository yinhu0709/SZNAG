//
//  StrategyHeader.h
//  LiWuShuo0424
//
//  Created by student on 16/4/28.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StrategyHeader : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger order;
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,retain) NSArray *channels;
- (id) initWithDictionary:(NSDictionary*) dic;
+ (id) initWithDictionary:(NSDictionary*) dic;
@end

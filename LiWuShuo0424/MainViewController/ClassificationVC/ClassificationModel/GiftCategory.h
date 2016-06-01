//
//  GiftCategory.h
//  LiWuShuo0424
//
//  Created by student on 16/5/3.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftCategory : NSObject
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,copy) NSString *icon_url;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger order;
@property (nonatomic,retain) NSArray *subcategories;
@property (nonatomic,assign) BOOL selected;
- (id) initWithDictionary:(NSDictionary*) dic;
+ (id) initWithDictionary:(NSDictionary*) dic;

@end

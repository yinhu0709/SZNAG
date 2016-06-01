//
//  HotGift.h
//  LiWuShuo0424
//
//  Created by student on 16/4/27.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotGift : NSObject
//@property (nonatomic,assign) NSInteger category_id;
@property (nonatomic,copy) NSString *cover_image_url;
@property (nonatomic,copy) NSString *Description;
@property (nonatomic,assign) NSInteger favorites_count;
@property (nonatomic ,retain) NSArray *image_urls;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *purchase_url;
@property (nonatomic,copy) NSString *url;
- (id) initWithDictionary:(NSDictionary*) dic;
+ (id) initWithDictionary:(NSDictionary*) dic;

@end

//
//  BigScroll.h
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/24.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Target;
@interface BigScroll : NSObject
@property (nonatomic,copy) NSString *image_url;
@property (nonatomic,retain) NSDictionary *target;
@property (nonatomic,copy) NSString *target_url;
@property (nonatomic,assign) NSInteger target_id;
@property (nonatomic,copy) NSString *webp_url;
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic ,assign) NSInteger order;
- (id) initWithDictionary:(NSDictionary*)dic;
+ (id) initWithDictionary:(NSDictionary*)dic;
@end
@interface Target : NSObject
@property (nonatomic,copy) NSString *banner_image_url;
@property (nonatomic,copy) NSString *banner_webp_url;
@property (nonatomic,copy) NSString *cover_image_url;
@property (nonatomic,copy) NSString *cover_webp_url;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) NSInteger posts_count;
- (id) initWithDictionary:(NSDictionary*)dic;
+ (id) initWithDictionary:(NSDictionary*)dic;
@end

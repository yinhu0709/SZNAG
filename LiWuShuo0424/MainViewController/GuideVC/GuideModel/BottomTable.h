//
//  BottomTable.h
//  LiWuShuo0424
//
//  Created by student on 16/4/25.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BottomTable : NSObject
@property (nonatomic,copy) NSString *content_url;
@property (nonatomic,copy) NSString *cover_image_url;
@property (nonatomic,copy) NSString *cover_webp_url;
@property (nonatomic ,copy) NSString *image_url;
@property (nonatomic,copy) NSString *share_msg;
@property (nonatomic,copy) NSString *title;
@property (nonatomic ,copy) NSString *type ;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,assign) NSInteger likes_count;
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,copy) NSString *short_title;
@property (nonatomic ,assign) NSInteger gap_days;
- (id) initWithDictionary:(NSDictionary*)dic;
+ (id) initWithDictionary:(NSDictionary*)dic;

@end

//
//  TopScroll.h
//  LiWuShuo0424
//
//  Created by student on 16/4/24.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopScroll : NSObject
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,copy) NSString *image_url;
@property (nonatomic,copy) NSString *target_url;
@property (nonatomic,copy) NSString *webp_url;
- (id) initWithDictionary:(NSDictionary*)dic;
+ (id) initWithDictionary:(NSDictionary*)dic;
@end

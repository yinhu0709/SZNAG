//
//  StrategyTops.h
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/28.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StrategyTops : NSObject
@property (nonatomic,copy) NSString *banner_image_url ;
@property (nonatomic,copy) NSString *banner_webp_url;
@property (nonatomic,copy) NSString *cover_image_url;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) NSInteger  ID;
- (id) initWithDictionary:(NSDictionary*) dic;
+ (id) initWithDictionary:(NSDictionary*) dic;

@end

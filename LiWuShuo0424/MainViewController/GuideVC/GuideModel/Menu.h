//
//  Menu.h
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/24.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Menu : NSObject
@property (nonatomic,copy) NSString *name;

@property (nonatomic ,assign) NSInteger ID;
- (id) initWithDictionary:(NSDictionary*)dic;
+ (id) initWithDictionary:(NSDictionary*)dic;
@end

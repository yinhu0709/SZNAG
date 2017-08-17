//
//  GiftCategory.m
//  LiWuShuo0424
//
//  Created by Sznag on 16/5/3.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "GiftCategory.h"

@implementation GiftCategory
- (id) initWithDictionary:(NSDictionary*) dic {
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"ID"];
    }
}
+ (id) initWithDictionary:(NSDictionary*) dic {
    return  [[self alloc]initWithDictionary:dic];
}

@end

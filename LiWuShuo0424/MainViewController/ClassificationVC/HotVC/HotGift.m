//
//  HotGift.m
//  LiWuShuo0424
//
//  Created by student on 16/4/27.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "HotGift.h"

@implementation HotGift
- (id) initWithDictionary:(NSDictionary*) dic {
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        [self setValue:value forKey:@"Description"];
    }
}
+ (id) initWithDictionary:(NSDictionary*) dic {
    return [[self alloc]initWithDictionary:dic];
}
@end

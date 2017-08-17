//
//  StrategyHeader.m
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/28.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "StrategyHeader.h"

@implementation StrategyHeader
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

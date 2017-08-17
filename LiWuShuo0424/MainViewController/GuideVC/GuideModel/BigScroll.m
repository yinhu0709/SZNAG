//
//  BigScroll.m
//  LiWuShuo0424
//
//  Created by Sznag on 16/4/24.
//  Copyright © 2016年 刘新银. All rights reserved.
//

#import "BigScroll.h"

@implementation BigScroll
- (id) initWithDictionary:(NSDictionary*)dic {
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
//    if ([key isEqualToString:@"target"]) {
//        [self setValue:value forKeyPath:@"target"];
//        NSLog(@"%@",self.target);
//    }
}
+ (id) initWithDictionary:(NSDictionary*)dic {
    return [[self alloc]initWithDictionary:dic];
}
@end

@implementation Target

- (id) initWithDictionary:(NSDictionary*)dic {
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
  
}
+ (id) initWithDictionary:(NSDictionary*)dic {
    return [[self alloc]initWithDictionary:dic];
}


@end

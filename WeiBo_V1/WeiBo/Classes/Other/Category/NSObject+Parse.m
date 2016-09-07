//
//  NSObject+Parse.m
//  ParseJSON_NSObjectCategory
//
//  Created by Qinting on 16/7/13.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "NSObject+Parse.h"

@implementation NSObject (Parse)

/** 让调用的类去重写这个方法 */
+(NSDictionary *)objectInArray
{
    return nil;
}

/** 调用的时候去调用这个方法 */
+ (id)parse:(id)JSON
{
    if ( [JSON isKindOfClass: [NSArray class]]) {
     return [self parseArr:JSON];
    }
    if ([JSON isKindOfClass:[NSDictionary class]]) {
        return [self  parseDict:JSON];
    }
    return JSON;
}

/** 解析数组 数组里的每一个元素都是数据模型类*/
+(NSArray*)parseArr:(NSArray *)JSON
{
    NSMutableArray *mutableArr = [NSMutableArray array];
        [JSON enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [mutableArr addObject:[self parse:obj]];
        }];
    return mutableArr;
}

/** 解析字典   */
+(NSDictionary *)parseDict:(NSDictionary*)JSON
{
    id model = [self new];
    [JSON enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        Class class = [self objectInArray][key];
        if (class) {
            obj = [class parse:obj];
        }
        [model setValue:obj forKey:key];
    }];
    return model;
}

- (void)setNilValueForKey:(NSString *)key;
{

}

@end

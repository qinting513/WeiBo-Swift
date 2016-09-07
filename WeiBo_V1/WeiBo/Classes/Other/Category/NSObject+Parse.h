//
//  NSObject+Parse.h
//  ParseJSON_NSObjectCategory
//
//  Created by Qinting on 16/7/13.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Parse)

+(NSDictionary *)objectInArray;

+ (id)parse:(id)JSON;

+(NSArray*)parseArr:(NSArray *)JSON;
+(id)parseDict:(NSDictionary *)JSON;



@end

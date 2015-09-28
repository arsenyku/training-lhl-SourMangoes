//
//  RLMResults+ArrayConversion.m
//  Sour Mangoes
//
//  Created by asu on 2015-09-19.
//  Copyright © 2015 asu. All rights reserved.
//

#import "RLMResults+ArrayConversion.h"

@implementation RLMResults (ArrayConversion)
-(NSArray *)array{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (RLMObject *resultObject in self) {
        [result addObject:resultObject];
    }
    return result;
}
@end

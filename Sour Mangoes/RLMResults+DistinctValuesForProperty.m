//
//  RLMResults+DistinctValuesForProperty.m
//  Sour Mangoes
//
//  Created by asu on 2015-09-20.
//  Copyright © 2015 asu. All rights reserved.
//

#import "RLMResults+DistinctValuesForProperty.h"

@implementation RLMResults (DistinctValuesForProperty)
+ (NSArray *)distinctValuesForProperty:(NSString*)propertyName class:(Class)class {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    return nil;
//    
//    [RLMRealm defaultRealm] obje forPrimaryKey:<#(id)#>:<#(NSString *)#>
//    
//    RLMResults *unsorted = [SMMovie allObjectsInRealm:[RLMRealm defaultRealm]];
//    NSArray *allRatings = [unsorted valueForKey:propertyName];
//    NSOrderedSet *distinctRatings = [NSOrderedSet orderedSetWithArray:allRatings];
//    NSArray *sectionTitles = [[distinctRatings array] sortedArrayUsingSelector:@selector(compare:)];
}
@end

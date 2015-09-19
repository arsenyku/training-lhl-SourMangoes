//
//  NSString+RealmString.m
//  Sour Mangoes
//
//  Created by asu on 2015-09-19.
//  Copyright © 2015 asu. All rights reserved.
//

#import "RLMObject+RealmStorable.h"


@implementation RealmStorable
-(instancetype)initWithStorableValue:(id)value{
    self = [super init];
    if (self){
	    _value = value;
    }
    return self;
}
+ (instancetype)storableWithValue:(id)value{
    return [[RealmStorable alloc] initWithStorableValue:value];
}

@end

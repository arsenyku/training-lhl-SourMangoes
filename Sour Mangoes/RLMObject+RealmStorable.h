//
//  NSString+RealmString.h
//  Sour Mangoes
//
//  Created by asu on 2015-09-19.
//  Copyright © 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface RealmStorable:RLMObject
@property (nonatomic)NSString *value;

+ (instancetype)storableWithValue:(id)value;
@end

RLM_ARRAY_TYPE(RealmStorable)
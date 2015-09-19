//
//  SMActor.h
//  Sour Mangoes
//
//  Created by asu on 2015-09-19.
//  Copyright © 2015 asu. All rights reserved.
//

#import <Realm/Realm.h>

RLM_ARRAY_TYPE(SMActor)

@interface SMActor : RLMObject
@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSString *name;

+ (RLMArray<SMActor>*)actorsWithValue:(id)value;
@end


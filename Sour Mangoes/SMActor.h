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

/**
 * Creates an array of actor objects from a dictionary
 *
 * @param "apiActorData" An array of dictionaries containing actor attributes to be mapped
 * to properties.  Each dictionary in the array represents one actor.
 *
 * @return An array of SMActor objects.
 */
+ (RLMArray<SMActor>*)actorsWithData:(NSArray*)apiActorData;
@end


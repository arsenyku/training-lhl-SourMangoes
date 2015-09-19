//
//  SMActor.m
//  Sour Mangoes
//
//  Created by asu on 2015-09-19.
//  Copyright © 2015 asu. All rights reserved.
//

#import "SMConstants.h"
#import "SMActor.h"

@interface SMActor()
@property (nonatomic) NSString *identifier;
@property (nonatomic) NSString *name;

@end

@implementation SMActor

- (instancetype)initWithValue:(id)value {
    NSDictionary *actorData = value;
    self = [super init];
    if (self){
        _identifier = actorData[ INTHEATRES_MOVIE_CAST_IDENTIFIER_KEY ];
        _name = actorData [ INTHEATRES_MOVIE_CAST_NAME_KEY ];
    }
    return self;
}


+(NSString *)primaryKey{
    return @"identifier";
}


+ (RLMArray<SMActor>*)actorsWithValue:(id)value{
    RLMArray<SMActor> *result = [[RLMArray<SMActor> alloc] initWithObjectClassName:[SMActor className]];
    NSArray *dataForActors = value;
    for (NSDictionary *dataForActor in dataForActors) {
        [result addObject:[[SMActor alloc] initWithValue:dataForActor]];
    }
    return result;
}

@end

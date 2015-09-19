//
//  SMMovie.m
//  Sour Mangoes
//
//  Created by asu on 2015-09-18.
//  Copyright © 2015 asu. All rights reserved.
//

#import "SMConstants.h"
#import "SMMovie.h"

@implementation SMMovie

-(instancetype)initWithDictionary:(NSDictionary*)movieData{
    self = [super init];
    if (self) {
        _identifier = movieData[ INTHEATRES_MOVIE_ID_KEY ];
        _title = movieData[ INTHEATRES_MOVIE_TITLE_KEY ];
        _year = movieData[ INTHEATRES_MOVIE_YEAR_KEY ];
        _mpaaRating = movieData[ INTHEATRES_MOVIE_RATING_KEY ];
        _runtimeInMinutes = movieData[ INTHEATRES_MOVIE_RUNTIME_KEY ];
        _synopsis = movieData[ INTHEATRES_MOVIE_SYNOPSIS_KEY ];
        _posterImageAddress = movieData[ INTHEATRES_MOVIE_POSTERS_KEY ][ INTHEATRES_MOVIE_POSTERS_ORIGINAL_KEY ];
        _posterImage = nil;
        _actorNames = [self actorNamesFromArray:movieData[INTHEATRES_MOVIE_CAST_KEY] ];
    }
    return self;
}


-(NSArray*)actorNamesFromArray:(NSArray*)data{
    NSMutableArray *result = [NSMutableArray new];
    for (NSDictionary* actorInfo in data) {
        NSString *actorName = actorInfo[ INTHEATRES_MOVIE_CAST_NAME_KEY ];
        [result addObject:actorName];
    }
    return [result copy];
}


+(instancetype)movieWithDictionary:(NSDictionary *)data{
    return [[SMMovie alloc] initWithDictionary:data];
}

@end


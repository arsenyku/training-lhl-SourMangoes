//
//  SMMovie.m
//  Sour Mangoes
//
//  Created by asu on 2015-09-18.
//  Copyright © 2015 asu. All rights reserved.
//

#import "SMConstants.h"
#import "SMMovie.h"
#import "NSNumber+NumberFromString.h"

@interface SMMovie()

@property(nonatomic, strong)NSString* identifier;
@property(nonatomic, strong)NSString* title;
@property(nonatomic, assign)int year;
@property(nonatomic, strong)NSString* mpaaRating;
@property(nonatomic, assign)float runtimeInMinutes;
@property(nonatomic, strong)NSString* synopsis;
@property(nonatomic, strong)NSString* posterImageAddress;
@property(nonatomic, strong)UIImage* posterImage;
@property(nonatomic, strong)RLMArray<SMActor>* cast;

@end

@implementation SMMovie

-(instancetype)initWithValue:(id)value{
    NSDictionary *movieData = value;
	self = [super init];
    if (self) {
        _identifier = movieData[ INTHEATRES_MOVIE_ID_KEY ];
        _title = movieData[ INTHEATRES_MOVIE_TITLE_KEY ];
        _year = [movieData[ INTHEATRES_MOVIE_YEAR_KEY ] intValue];
        _mpaaRating = movieData[ INTHEATRES_MOVIE_RATING_KEY ];
        _runtimeInMinutes = [movieData[ INTHEATRES_MOVIE_RUNTIME_KEY ] floatValue];
        _synopsis = movieData[ INTHEATRES_MOVIE_SYNOPSIS_KEY ];
        _posterImageAddress = movieData[ INTHEATRES_MOVIE_POSTERS_KEY ][ INTHEATRES_MOVIE_POSTERS_ORIGINAL_KEY ];
        _posterImage = nil;
        _cast = [SMActor actorsWithValue:movieData[INTHEATRES_MOVIE_CAST_KEY] ];
    }
    return self;
}





-(NSString *)description{
    return [NSString stringWithFormat:@"%@(%@)", self.identifier, self.title];
}

+ (NSString *)primaryKey {
    return @"identifier";
}

+(NSArray*)ignoredProperties
{
    // Must ignore these properties because Realm can't persist them
    return @[@"posterImage"];
}


@end


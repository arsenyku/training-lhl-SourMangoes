//
//  SMMovie.m
//  Sour Mangoes
//
//  Created by asu on 2015-09-18.
//  Copyright © 2015 asu. All rights reserved.
//

#import "SMConstants.h"
#import "SMMovie.h"
#import "NSURLSession+DownloadFromAddress.h"
#import "RLMResults+ArrayConversion.h"

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

@property(nonatomic, strong)NSURLSessionTask* downloadTask;
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
        _cast = [SMActor actorsWithData:movieData[INTHEATRES_MOVIE_CAST_KEY] ];
    }
    return self;
}

-(UIImage*)posterImage{
    if(_posterImage == nil)
       [self downloadPosterImage];
    return _posterImage;
}

-(NSArray*)actorNames{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (SMActor *actor in self.cast) {
        [result addObject:actor.name];
    }
    return [result copy];
}



-(NSString *)description{
    return [NSString stringWithFormat:@"%@(%@)", self.identifier, self.title];
}

-(NSString*)highResPosterImageAddress{
    NSString *result = self.posterImageAddress;
    NSRange range = [result rangeOfString:HIGH_RES_POSTER_IMAGE_URL];
    
    if (range.location < NSNotFound)
        result = [NSString stringWithFormat:@"https://%@", [result substringFromIndex:range.location]];
    else
        NSLog(@"Unexpected URL for image %@", result);
    
    return result;

}

-(void)downloadPosterImage{
    if (self.downloadTask)
        return;
    
    self.downloadTask =
    [NSURLSession downloadFromAddress:self.highResPosterImageAddress
                           completion:^(NSData *data, NSURLResponse *response, NSError *error) {
                               
                               if (error)
                                   NSLog(@"Error while downloading image: %@", error);
                               
                               UIImage *downloadedImage = [UIImage imageWithData:data];
                               self.posterImage = downloadedImage;
                               
                               if (self.delegate)
                                   [self.delegate dataUpdated:self];
                           }
     ];

}



+ (NSString *)primaryKey {
    return @"identifier";
}

+ (NSArray*)ignoredProperties
{
    // Must ignore these properties because Realm can't persist them
    return @[@"posterImage", @"delegate", @"downloadTask"];
}


+ (NSMutableDictionary *)moviesGroupedByProperty:(NSString*)propertyName{
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    
    RLMResults *unsorted = [SMMovie allObjects];
    NSArray *allRatings = [unsorted valueForKey:propertyName];
    NSOrderedSet *distinctRatings = [NSOrderedSet orderedSetWithArray:allRatings];
    NSArray *sectionTitles = [[distinctRatings array] sortedArrayUsingSelector:@selector(compare:)];
    
    for (NSString *sectionTitle in sectionTitles) {
        NSLog(@"%@ == %@", propertyName, sectionTitle);
        NSPredicate *groupingPredicate = [NSPredicate predicateWithFormat:@"mpaaRating = %@", sectionTitle];
        RLMResults *moviesForSection = [SMMovie objectsWithPredicate:groupingPredicate];

        //        RLMResults *moviesForSection = [SMMovie objectsWhere:[NSString stringWithFormat:@"%@ = %@", propertyName, @"%@"], sectionTitle];
        result[ sectionTitle ] = moviesForSection;
    }
    return result;
}
@end


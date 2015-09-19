//
//  ViewController.m
//  Sour Mangoes
//
//  Created by asu on 2015-09-18.
//  Copyright © 2015 asu. All rights reserved.
//

#import <Realm/Realm.h>

#import "SMConstants.h"
#import "SMMoviesViewController.h"
#import "SMMovie.h"
#import "NSURLSession+DownloadFromAddress.h"

@interface SMMoviesViewController ()

@property (nonatomic) NSMutableArray *movies;

@property (nonatomic) int moviesPerPage;
@property (nonatomic) int currentPageOfMovies;
@property (nonatomic) int totalNumberOfMovies;

@end

@implementation SMMoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.moviesPerPage = 50;
    self.currentPageOfMovies = 0;
    
    
    NSLog(@"%@", [RLMRealmConfiguration defaultConfiguration]);
    NSLog(@"%@", [RLMRealm defaultRealm]);
    
    NSLog(@"%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]);

}


#pragma mark - private

-(void)loadData{
    
    [NSURLSession downloadFromAddress:self.urlStringWithApiKey completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error){
            NSLog(@"In Theatres Endpoint Download Error: %@", error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *inTheatres = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        
        if (jsonError){
            NSLog(@"In Theatres Endpoint Deserialization Error: %@", error);
            return;
        }
        
        self.totalNumberOfMovies = [(NSNumber *)inTheatres[ INTHEATRES_MOVIES_KEY ] intValue];
        NSArray *movies = inTheatres[ INTHEATRES_MOVIES_KEY ];
        
        for (NSDictionary *movieData in movies) {
            [self.movies addObject:[SMMovie movieWithDictionary:movieData]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            //[self.collectionView reloadData];
            
        });
        
        
    }];
    
}


-(NSString*)urlStringWithApiKey{
	NSString *urlStringWithApiKey = [NSString stringWithFormat:INTHEATRES_ENDPOINT_URL, API_KEY, self.moviesPerPage, self.currentPageOfMovies];
    return urlStringWithApiKey;
}



@end

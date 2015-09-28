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
#import "SMMovieDetailViewController.h"
#import "SMMovie.h"
#import "SMMovieCellView.h"
#import "NSURLSession+DownloadFromAddress.h"
#import "RLMResults+ArrayConversion.h"

@interface SMMoviesViewController () <UICollectionViewDataSource, UICollectionViewDelegate, SMUpdateDelegate>

@property (nonatomic) NSMutableArray *movies;
//@property (nonatomic) RLMResults *storedMovies;
@property (nonatomic) NSMutableDictionary* moviesByMpaaRating;


@property (nonatomic) int moviesPerPage;
@property (nonatomic) int currentPageOfMovies;
@property (nonatomic) int totalNumberOfMovies;

@end

@implementation SMMoviesViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.moviesPerPage = 50;
    self.currentPageOfMovies = 1;
    
    
    NSLog(@"%@", [RLMRealmConfiguration defaultConfiguration]);
    NSLog(@"%@", [RLMRealm defaultRealm]);
    
    NSLog(@"%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]);

    self.movies = [[NSMutableArray alloc] init];
//    self.storedMovies = nil;
    self.moviesByMpaaRating = [[NSMutableDictionary alloc] init];
    
    [self loadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDetail"]){
        SMMovieDetailViewController *detail = (SMMovieDetailViewController*)segue.destinationViewController;
        SMMovieCellView *cell = sender;
        detail.movie = cell.movie;
    }
}


#pragma mark - Table View

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.moviesByMpaaRating count];
//    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSString *sectionKey = [self.moviesByMpaaRating allKeys][section];
    NSArray *moviesForSection = self.moviesByMpaaRating[sectionKey];
    return [moviesForSection count];
//    return [self.movies count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"movieCell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    if (self.moviesPerPage * self.currentPageOfMovies - 1 <= indexPath.item){
        [self loadMoreData];
    }
    
    return cell;
}

-(void)configureCell:(id)cell atIndexPath:(NSIndexPath*)indexPath{
    SMMovieCellView *movieCell = cell;
    NSString *section = [self.moviesByMpaaRating allKeys][indexPath.section];
    RLMResults *movies = self.moviesByMpaaRating[section];
    [movieCell setContent:movies[indexPath.item]];
//    SMMovie *movie = self.movies[indexPath.item];
//    [movieCell setContent:movie];
}


#pragma mark - SMUpdateDelegate
-(void)dataUpdated:(id)sender{
    dispatch_async(dispatch_get_main_queue(), ^ {
        [self.collectionView reloadData];
        
    });
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
        
        self.totalNumberOfMovies = [(NSNumber *)inTheatres[ INTHEATRES_TOTAL_KEY ] intValue];
        NSArray *movies = inTheatres[ INTHEATRES_MOVIES_KEY ];
        
        for (NSDictionary *movieData in movies) {
            SMMovie* movie = [[SMMovie alloc] initWithValue:movieData];
            movie.delegate = self;
            [self.movies addObject:movie];
            NSLog(@"saving %@", movie);
        }
        
        [self saveMovies];
        NSLog(@"%@", self.movies);
        
        self.moviesByMpaaRating = [SMMovie moviesGroupedByProperty:@"mpaaRating"];
        
//        self.storedMovies = [SMMovie allObjects];
        
        [self dataUpdated:self];
        
    }];
    
}

-(BOOL)moreMoviesAvailable{
    int downloadedSoFar = self.moviesPerPage * self.currentPageOfMovies;
    return ( downloadedSoFar < self.totalNumberOfMovies );
}

-(void)loadMoreData{
    
    if ( [self moreMoviesAvailable] ){
        self.currentPageOfMovies += 1;
        [self loadData];
    }
}

-(void)saveMovies{
    [[RLMRealm defaultRealm] beginWriteTransaction];
    for (SMMovie *movie in self.movies) {
        [SMMovie createOrUpdateInDefaultRealmWithValue:movie];
    }
    [[RLMRealm defaultRealm] commitWriteTransaction];
}


-(NSString*)urlStringWithApiKey{
	NSString *urlStringWithApiKey = [NSString stringWithFormat:INTHEATRES_ENDPOINT_URL, API_KEY, self.moviesPerPage, self.currentPageOfMovies];
    return urlStringWithApiKey;
}



@end

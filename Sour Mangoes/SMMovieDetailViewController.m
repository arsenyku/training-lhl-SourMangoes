//
//  RMMovieDetailViewController.m
//  Rotten Mangoes
//
//  Created by asu on 2015-09-15.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "SMMovieDetailViewController.h"
//#import "SMReviewPagesViewController.h"

@interface SMMovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *castLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UIButton *reviewsButton;

@end

@implementation SMMovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.movie){
//        self.titleLabel.text = self.movie.title;
//        self.castLabel.text = [NSString stringWithFormat:@"Starring: %@",
//                               [self.movie.actorNames componentsJoinedByString:@", "]];
//        self.synopsisLabel.text = self.movie.synopsis;
//        self.movieImageView.image = [self.movie imageWithType:Original];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowReviews"]){
//        RMReviewPagesViewController *pagesController = sender;
//        pagesController.movie = self.movie;
    }
}

- (IBAction)goToReviews:(UIBarButtonItem *)sender {
}

@end

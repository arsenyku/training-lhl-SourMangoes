//
//  RMMovieCell.m
//  Rotten Mangoes
//
//  Created by asu on 2015-09-14.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "SMMovieCellView.h"

@interface SMMovieCellView()
@property (weak, nonatomic) IBOutlet UIImageView *collectionImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@property (nonatomic) SMMovie *movie;
@end

@implementation SMMovieCellView


-(void)setRatingLabel:(UILabel *)ratingLabel{
    _ratingLabel = ratingLabel;
    
    _ratingLabel.layer.cornerRadius = 10.0f;
    _ratingLabel.layer.masksToBounds = YES;
}

    
-(void)setContent:(SMMovie*)movie{
    _movie = movie;

    self.titleLabel.text = self.movie.title;
    self.ratingLabel.text = [NSString stringWithFormat:@"%@", self.movie.mpaaRating];
    self.collectionImageView.image = self.movie.posterImage;
}



@end

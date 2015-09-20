//
//  RMMovieCell.h
//  Rotten Mangoes
//
//  Created by asu on 2015-09-14.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMMovie.h"

@interface SMMovieCellView : UICollectionViewCell
@property(nonatomic,readonly)SMMovie* movie;
-(void)setContent:(SMMovie*)movie;
@end

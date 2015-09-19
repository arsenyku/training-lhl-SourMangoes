//
//  SMAppDelegate.h
//  Sour Mangoes
//
//  Created by asu on 2015-09-18.
//  Copyright © 2015 asu. All rights reserved.
//

#define API_KEY @"j9fhnct2tp8wu2q9h75kanh9"

// Rotten Tomatoes In Theatres Endpoint
#define INTHEATRES_ENDPOINT_URL @"https://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=%@&page_limit=%d&page=%d"
#define INTHEATRES_MOVIES_KEY @"movies"
#define INTHEATRES_TOTAL_KEY = @"total"

#define INTHEATRES_MOVIE_ID_KEY @"id"
#define INTHEATRES_MOVIE_TITLE_KEY @"title"
#define INTHEATRES_MOVIE_YEAR_KEY @"year"
#define INTHEATRES_MOVIE_RATING_KEY @"mpaa_rating"
#define INTHEATRES_MOVIE_RUNTIME_KEY @"runtime"
#define INTHEATRES_MOVIE_SYNOPSIS_KEY @"synopsis"
#define INTHEATRES_MOVIE_POSTERS_KEY @"posters"
#define INTHEATRES_MOVIE_CAST_KEY @"abridged_cast"

#define INTHEATRES_MOVIE_POSTERS_THUMB_KEY @"thumbnail"
#define INTHEATRES_MOVIE_POSTERS_ORIGINAL_KEY @"original"
#define INTHEATRES_MOVIE_POSTERS_PROFILE_KEY @"profile"
#define INTHEATRES_MOVIE_POSTERS_DETAILED_KEY @"detailed"

#define INTHEATRES_MOVIE_CAST_NAME_KEY @"name"

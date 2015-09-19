//
//  SMMovie.h
//  Sour Mangoes
//
//  Created by asu on 2015-09-18.
//  Copyright © 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Realm/Realm.h>


@interface SMMovie : RLMObject

@property(nonatomic, strong, readonly)NSString* identifier;
@property(nonatomic, strong, readonly)NSString* title;
@property(nonatomic, strong, readonly)NSNumber* year;
@property(nonatomic, strong, readonly)NSString* mpaaRating;
@property(nonatomic, strong, readonly)NSNumber* runtimeInMinutes;
@property(nonatomic, strong, readonly)NSString* synopsis;
@property(nonatomic, strong, readonly)NSString* posterImageAddress;
@property(nonatomic, strong, readonly)UIImage* posterImage;
@property(nonatomic, strong, readonly)NSArray* actorNames;

-(instancetype)initWithDictionary:(NSDictionary*)data;
+(instancetype)movieWithDictionary:(NSDictionary*)data;

@end

@protocol SMMovieUpdateDelegate <NSObject>
-(void)movieDataUpdated:(SMMovie*)movie;
@end





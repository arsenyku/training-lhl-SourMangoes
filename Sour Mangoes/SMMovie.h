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
#import "SMActor.h"

@protocol SMUpdateDelegate <NSObject>
-(void)dataUpdated:(id)sender;
@end


@interface SMMovie : RLMObject

@property(nonatomic, strong, readonly)NSString* identifier;
@property(nonatomic, strong, readonly)NSString* title;
@property(nonatomic, assign, readonly)int  year;
@property(nonatomic, strong, readonly)NSString* mpaaRating;
@property(nonatomic, assign, readonly)float runtimeInMinutes;
@property(nonatomic, strong, readonly)NSString* synopsis;
@property(nonatomic, strong, readonly)NSString* posterImageAddress;
@property(nonatomic, strong, readonly)UIImage* posterImage;
@property(nonatomic, strong, readonly)RLMArray<SMActor> * cast;


@property(nonatomic, weak) id<SMUpdateDelegate> delegate;

/**
 * Extracts actor names for the movie returns them as an array of strings.
 * @return Array of strings containing the names of the movie's actors.
 */
-(NSArray*)actorNames;


+ (NSMutableDictionary *)moviesGroupedByProperty:(NSString*)propertyName;

@end

RLM_ARRAY_TYPE(SMMovie)






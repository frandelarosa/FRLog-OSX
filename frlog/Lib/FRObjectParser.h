//
//  FRObjectParser.h
//  frlog
//
//  Created by Fran on 10/5/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#import <Foundation/Foundation.h>

// Objects
#import "FRLogServerDataDefault.h"
#import "FRLogServerDataURL.h"

@interface FRObjectParser : NSObject

/**
 Get current date and time.
*/
+ (NSString *)getCurrentTime;

/**
 Parse log content.
 @param data Default data object.
*/

+ (NSString *)parseDefaultData:(FRLogServerDataDefault *)data;

/**
 Parse log content.
 @param data URL data object.
 */
+ (NSString *)parseURLData:(FRLogServerDataURL *)data;

@end

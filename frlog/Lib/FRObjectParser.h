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

@interface FRObjectParser : NSObject

+ (NSString *)parseDefaultData:(FRLogServerDataDefault *)data;

@end

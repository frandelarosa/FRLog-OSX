//
//  FRObjectParser.m
//  frlog
//
//  Created by Fran on 10/5/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#define CLASSNAME @"[classname not defined]"
#define LINE      @"NLN"
#define CONTENT   @"Content not defined"

#import "FRObjectParser.h"

// Object
#import "FRObjectParser.h"

@implementation FRObjectParser

#pragma mark -
#pragma mark INFO
#pragma mark -

+ (NSString *)parseDefaultData:(FRLogServerDataDefault *)data {
    
    NSMutableString *finalString = [[NSMutableString alloc] initWithString:@"\n"];
    
    // Date
    [finalString appendString:data.obj_date];
    
    // Classname
    [finalString appendString:data.obj_classname];
    
    // Line
    [finalString appendString:[NSString stringWithFormat:@":%@", data.obj_line]];
    
    // Content
    [finalString appendString:[NSString stringWithFormat:@" %@", data.obj_content]];
    
    return [NSString stringWithString:finalString];
    
}


#pragma mark -
#pragma mark URL
#pragma mark -

+ (NSString *)parseURLData:(FRLogServerDataURL *)data {
    
    NSMutableString *finalString = [[NSMutableString alloc] initWithString:@"\n"];
    
    // Date
    [finalString appendString:data.obj_date];
    
    // Request Name
    [finalString appendString:[NSString stringWithFormat:@" --- %@ --- ", [data.obj_requestname uppercaseString]]];
    
    // URL
    [finalString appendString:[NSString stringWithFormat:@" %@", data.obj_url]];
    
    return [NSString stringWithString:finalString];
    
}

@end

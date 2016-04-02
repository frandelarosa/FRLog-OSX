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
    
    return [NSString stringWithString:data.obj_content];
    
}


#pragma mark -
#pragma mark URL
#pragma mark -

+ (NSString *)parseURLData:(FRLogServerDataURL *)data {
    
    NSMutableString *content = [NSMutableString new];
    
    [content appendString:[NSString stringWithFormat:@"%@", data.obj_url]];
    
    return [NSString stringWithString:content];
    
}

@end

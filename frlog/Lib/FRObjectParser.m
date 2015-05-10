//
//  FRObjectParser.m
//  frlog
//
//  Created by Fran on 10/5/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#define CLASSNAME @"[classname not defined]"
#define LINE @"NLN"
#define CONTENT @"Content not defined"

#import "FRObjectParser.h"

// Object
#import "FRObjectParser.h"

@implementation FRObjectParser

+ (NSString *)parseDefaultData:(FRLogServerDataDefault *)data {
    
    NSString *str = nil;
    
    // Data to parse
    NSString *obj_classname = nil;
    NSString *obj_line      = nil;
    NSString *obj_content   = nil;
    
    // Classname
    if (data.obj_classname != nil && ![data.obj_classname isEqualTo:[NSNull null]] && data.obj_classname.length > 0){
        obj_classname = [NSString stringWithFormat:@"%@", data.obj_classname];
    }else{
        obj_classname = [NSString stringWithFormat:@"%@", CLASSNAME];
    }
    
    // Linenumber
    if (data.obj_line != nil && ![data.obj_line isEqualTo:[NSNull null]] && data.obj_line.length > 0){
        obj_line = [NSString stringWithFormat:@"%@", data.obj_line];
    }else{
        obj_line = [NSString stringWithFormat:@"%@", LINE];
    }
    
    // Content
    if (data.obj_content != nil && ![data.obj_content isEqualTo:[NSNull null]] && data.obj_content.length > 0){
        obj_content = [NSString stringWithFormat:@"%@", data.obj_content];
    }else{
        obj_content = [NSString stringWithFormat:@"%@", CONTENT];
    }
    
    // Build string
    str = [NSString stringWithFormat:@"\n%@:%@ %@", obj_classname, obj_line, obj_content];
    
    return str;
    
    
}

@end

//
//  FRTextColor.h
//  frlog
//
//  Created by Fran on 25/4/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

@import AppKit;

#import <Foundation/Foundation.h>

@interface FRTextColor : NSAttributedString

/**
 Apply color to given text.
*/
+ (NSAttributedString *)applyColor:(NSColor *)color toText:(NSString *)text;

/**
 Apply HEX color (000000 format) to given text.
*/
+ (NSAttributedString *)applyHexColor:(NSString *)color toText:(NSString *)text;

@end

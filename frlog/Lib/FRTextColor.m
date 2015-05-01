//
//  FRTextColor.m
//  frlog
//
//  Created by Fran on 25/4/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#import "FRTextColor.h"

@implementation FRTextColor

#pragma mark -
#pragma mark Color
#pragma mark -

+ (NSAttributedString *)applyColor:(NSColor *)color toText:(NSString *)text {
    
    // Create attributes with the color
    NSDictionary *attrs = @{NSForegroundColorAttributeName:color};
    
    // Create NSAttributedString
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text attributes:attrs];
    
    // Return formatted text
    return attrStr;
    
}

+ (NSAttributedString *)applyHexColor:(NSString *)color toText:(NSString *)text {
    
    // Convert string color to NSColor
    NSColor *result = nil;
    unsigned colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (color != nil){
        
        NSScanner* scanner = [NSScanner scannerWithString:color];
        (void)[scanner scanHexInt:&colorCode];
        
    }
    
    redByte   = (unsigned char)(colorCode >> 16);
    greenByte = (unsigned char)(colorCode >> 8);
    blueByte  = (unsigned char)(colorCode);
    
    result = [NSColor
              colorWithCalibratedRed:(CGFloat)redByte / 0xff
              green:(CGFloat)greenByte / 0xff
              blue:(CGFloat)blueByte / 0xff
              alpha:1.0];
    
    return [self applyColor:result toText:text];
    
}


@end

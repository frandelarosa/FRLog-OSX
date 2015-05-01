//
//  FRTextView.h
//  frlog
//
//  Created by Fran on 25/4/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FRTextView : NSTextView

/**
 Add non-formatted text to console.
*/
- (void)addTextToConsole:(NSString *)text;

/**
 Add formatted text to console.
*/
- (void)addAttributedTextToConsole:(NSAttributedString *)text;

@end

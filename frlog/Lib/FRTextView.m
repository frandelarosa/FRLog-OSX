//
//  FRTextView.m
//  frlog
//
//  Created by Fran on 25/4/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#import "FRTextView.h"

@implementation FRTextView

- (void)drawRect:(NSRect)dirtyRect {
    
    [super drawRect:dirtyRect];
    
    
}

#pragma mark -
#pragma mark Add Text
#pragma mark -

- (void)addTextToConsole:(NSString *)text {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:text];
        
        [[self textStorage] appendAttributedString:attr];
        [self scrollRangeToVisible:NSMakeRange([[self string] length], 0)];
        
    });
    
}

- (void)addAttributedTextToConsole:(NSAttributedString *)text {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSAttributedString *attr = [[NSAttributedString alloc] initWithAttributedString:text];
        
        [[self textStorage] appendAttributedString:attr];
        [self scrollRangeToVisible:NSMakeRange([[self string] length], 0)];
        
    });
    
    
}


@end

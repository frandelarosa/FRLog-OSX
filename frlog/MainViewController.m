//
//  ViewController.m
//  frlog
//
//  Created by Fran on 25/4/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#import "MainViewController.h"

// Lib
#import "FRTextColor.h"
#import "FRLogServer.h"

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    server = [[FRLogServer alloc] initWithDelegate:self OnPort:1283];
    
}

- (void)addText:(NSString *)text withHexColor:(NSString *)hex_color {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSAttributedString *textToAdd = [FRTextColor applyHexColor:hex_color toText:text];
        [self.console addAttributedTextToConsole:textToAdd];
    });
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
    NSLog(@"setRepresentedObject");
}

#pragma mark -
#pragma mark Server Delegate
#pragma mark -

- (void)onServer:(FRLogServer *)server withStatus:(FRLogServerState)state withError:(NSError *)error {
    
    if (state == FRLogServerStateRunning){
        
        [self addText:@"=== SERVER RUNNING ON PORT 1283 ===" withHexColor:@"FFFFFF"];
        
    }else if (state == FRLogServerStateStopped){
        
        [self addText:@"=== ERROR STARTING SERVER ===" withHexColor:@"EC1A1A"];
        
    }
    
}

@end

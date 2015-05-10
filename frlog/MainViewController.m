//
//  ViewController.m
//  frlog
//
//  Created by Fran on 25/4/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#import "MainViewController.h"

// Lib
#import "FRLogServer.h"
#import "FRTextColor.h"
#import "FRObjectParser.h"
#import "FRLogSettings.h"

// Models
#import "FRLogServerDataDefault.h"

@implementation MainViewController


#pragma mark -
#pragma mark View Cycle
#pragma mark -

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    server = [[FRLogServer alloc] initWithDelegate:self OnPort:1283];
    
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

- (void)onServer:(FRLogServer *)server readData:(id)datatype {
    
    if ([datatype isKindOfClass:[FRLogServerDataDefault class]]){
        
        [self parseDefaultData:datatype];
        
    }else{
        
        [self addText:@"Data type not supported" withHexColor:@"c81a1a"];
    }
    
    
}


#pragma mark -
#pragma mark Parse Objects
#pragma mark -

- (void)parseDefaultData:(FRLogServerDataDefault *)data {
    
    NSString *dataParsed = [FRObjectParser parseDefaultData:data];
    
    switch([data.obj_type integerValue]){
            
        // INFO
        case 2:
            [self addText:dataParsed withHexColor:COLOR_INFO];
            break;
            
        // DEFAULT
        default:
            [self addText:dataParsed withHexColor:COLOR_DEFAULT];
            break;
    }
    

}


#pragma mark -
#pragma mark Text
#pragma mark -

- (void)addText:(NSString *)text withHexColor:(NSString *)hex_color {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSAttributedString *textToAdd = [FRTextColor applyHexColor:hex_color toText:text];
        [self.console addAttributedTextToConsole:textToAdd];
    });
    
}

- (void)addText:(NSAttributedString *)text {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.console addAttributedTextToConsole:text];
    });
    
    
}

@end

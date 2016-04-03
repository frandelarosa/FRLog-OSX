//
//  ViewController.m
//  frlog
//
//  Created by Fran on 25/4/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#define FRLOG_OBJ_TYPE      @"frlog_type"
#define FRLOG_OBJ_CLASSLINE @"frlog_classline"
#define FRLOG_OBJ_OUTPUT    @"frlog_output"

#define FRLOG_OBJ_TYPEINFO  @"Info"
#define FRLOG_OBJ_TYPEURL   @"URL"
#define FRLOG_OBJ_TYPERROR  @"Error"

#define FRLOG_MSG_RUNNING   @"=== SERVER RUNNING ON PORT 1283 ==="
#define FRLOG_MSG_ERROR     @"=== ERROR STARTING SERVER ON PORT 1283 ==="

#import "MainViewController.h"

// Lib
#import "FRLogServer.h"
#import "FRTextColor.h"
#import "FRObjectParser.h"
#import "FRLogSettings.h"

// Models
#import "FRLogServerDataDefault.h"
#import "FRLogServerDataURL.h"

@implementation MainViewController

#pragma mark -
#pragma mark View Cycle
#pragma mark -

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initVars];
    
    server = [[FRLogServer alloc] initWithDelegate:self OnPort:1283];
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
    NSLog(@"setRepresentedObject");
}


#pragma mark -
#pragma mark Init
#pragma mark -

- (void)initVars {
    
    _dataSource = [NSMutableArray new];
    
}


#pragma mark -
#pragma mark Server Delegate
#pragma mark -

- (void)onServer:(FRLogServer *)server withStatus:(FRLogServerState)state withError:(NSError *)error {
    
    if (state == FRLogServerStateRunning){

        [self addText:FRLOG_MSG_RUNNING withHexColor:@"FFFFFF"];
        
    }else if (state == FRLogServerStateStopped){
        
        [self addText:FRLOG_MSG_ERROR withHexColor:@"D2290D"];
        
    }
    
}

- (void)onServer:(FRLogServer *)server readData:(id)datatype {
    
    NSString *objParsed = [FRObjectParser parseDefaultData:datatype];
    
    [self addText:objParsed withHexColor:@"336699"];
    
}


#pragma mark -
#pragma mark Text
#pragma mark -

- (void)addText:(NSString *)text withHexColor:(NSString *)hex_color {
    
 
    dispatch_async(dispatch_get_main_queue(), ^{
        NSAttributedString *textToAdd = [FRTextColor applyHexColor:hex_color toText:text];
        [self.console addAttributedTextToConsole:textToAdd];
        NSLog(@"OUTPUT: %@", textToAdd);
    });
   
    
}

- (void)addText:(NSAttributedString *)text {
    
    /*
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"OUTPUT: %@", text);
        //[self.console addAttributedTextToConsole:text];
    });
    */
    
}



@end

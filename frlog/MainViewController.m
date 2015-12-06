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
    
    [self initVars];
    [self initTable];
    
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
    
    dataSource = [NSMutableArray new];
    
}

- (void)initTable {
    
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    
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
    
    /*
    
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
     */
    
    [dataSource addObject:data];
    [self.tableView reloadData];
    

}


#pragma mark -
#pragma mark Text
#pragma mark -

- (void)addText:(NSString *)text withHexColor:(NSString *)hex_color {
    
    /*
    dispatch_async(dispatch_get_main_queue(), ^{
        NSAttributedString *textToAdd = [FRTextColor applyHexColor:hex_color toText:text];
        //[self.console addAttributedTextToConsole:textToAdd];
        NSLog(@"OUTPUT: %@", textToAdd);
    });
     */
    
}

- (void)addText:(NSAttributedString *)text {
    
    /*
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"OUTPUT: %@", text);
        //[self.console addAttributedTextToConsole:text];
    });
    */
    
}


#pragma mark -
#pragma mark TableView
#pragma mark -

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    
    NSInteger numRows = 0;
    
    if (dataSource && [dataSource count] > 0){
        numRows = [dataSource count];
    }
    
    return numRows;
    
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    FRLogServerDataDefault *logObj = (FRLogServerDataDefault *)[dataSource objectAtIndex:row];

    // Data
    if ([tableColumn.identifier isEqualToString:FRLOG_OBJ_TYPE]) {
        
        return [self setColumnType:logObj.obj_type];
        
    }else if ([tableColumn.identifier isEqualToString:FRLOG_OBJ_CLASSLINE]) {
        
        return [NSString stringWithFormat:@"%@:%@", logObj.obj_classname, logObj.obj_line];
        
    }else {
        
        return logObj.obj_content;
        
    }
    
}

- (NSCell *)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    NSTextFieldCell *cell = [tableColumn dataCell];
    
    FRLogServerDataDefault *logObj = (FRLogServerDataDefault *)[dataSource objectAtIndex:row];
    
    /******************
     Background Color
    *******************/
    
    [cell setDrawsBackground:YES];
    
    if (row % 2){
        [cell setBackgroundColor:[FRTextColor getColorByHexColor:@"e0e0e0" withAlpha:1]];
    }else {
        [cell setBackgroundColor:[NSColor whiteColor]];
    }
    
    
    /******************
     Text Color
    *******************/
    
    switch([logObj.obj_type integerValue]){
        case 2: // Info
            [cell setTextColor:[FRTextColor getColorByHexColor:@"3b8b3e" withAlpha:1]];
            break;
    }
    
    return cell;
    
}

#pragma mark -
#pragma mark Column Behaviour
#pragma mark -

- (NSString *)setColumnType:(NSString *)obj_type {
    
    NSString *columnName;
    
    switch ([obj_type integerValue]) {
            
        default:
        case 1: // URL
            columnName = FRLOG_OBJ_TYPEURL;
            break;
            
        case 2: // Info
            columnName = FRLOG_OBJ_TYPEINFO;
            break;
            
        case 3: // Error
            columnName = FRLOG_OBJ_TYPERROR;
            break;
            
    }
    
    return columnName;
    
}



@end

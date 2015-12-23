//
//  ViewController.m
//  frlog
//
//  Created by Fran on 25/4/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#define FRLOG_OBJ_ID        @"frlog_id"
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
#import "FRLogServerDataURL.h"

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

        NSLog(@"=== SERVER RUNNING ON PORT 1283 ===");
        
    }else if (state == FRLogServerStateStopped){
        
        NSLog(@"=== ERROR STARTING SERVER ===");
        
    }
    
}

- (void)onServer:(FRLogServer *)server readData:(id)datatype {
    
    /*
    if ([datatype isKindOfClass:[FRLogServerDataDefault class]]){
        
        [self parseDefaultData:datatype];
        
    }else if ([datatype isKindOfClass:[FRLogServerDataURL class]]){
        
        [self parseDefaultData:<#(FRLogServerDataDefault *)#>]
        
    }else {
        
        NSLog(@"=== ERROR === Data type not supported");
        
    }
     */
    
    [dataSource addObject:datatype];
    
    [self.tableView reloadData];
    
    if ([dataSource count] > 0)
        [self.tableView scrollRowToVisible:[dataSource count] - 1];
    
    
}

/*
#pragma mark -
#pragma mark Parse Objects
#pragma mark -

- (void)parseDefaultData:(FRLogServerDataDefault *)data {
    
    NSLog(@"DATA TO PARSE TYPE: %@", data.obj_type);
    
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
 
    
    [dataSource addObject:data];
   
    

}
*/

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
    
    id logObject = [dataSource objectAtIndex:row];
    
    if ([logObject isKindOfClass:[FRLogServerDataDefault class]]){
        return [self drawDefaultObject:logObject inColumn:tableColumn row:row];
    }else {
        return [self drawURLObject:logObject inColumn:tableColumn row:row];
    }
    
}

- (NSCell *)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    NSTextFieldCell *cell = [tableColumn dataCell];
    
    id logObj = [dataSource objectAtIndex:row];
    
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
    
    if ([tableColumn.identifier isEqualToString:FRLOG_OBJ_ID]){
        
        [cell setTextColor:[NSColor blackColor]];
        
    }else {
        
        switch([[logObj valueForKey:@"obj_type"] integerValue]){
                
            case FRLSDDefault:
                [cell setTextColor:[FRTextColor getColorByHexColor:@"3b8b3e" withAlpha:1]];
                break;
                
            case FRLSDURL:
                [cell setTextColor:[FRTextColor getColorByHexColor:@"f99a1d" withAlpha:1]];
                break;
        }
        
    }
    
    return cell;
    
}


#pragma mark -
#pragma mark Column Behaviour
#pragma mark -

- (NSString *)setColumnType:(FRLogServerData)obj_type {
    
    NSString *columnName;
    
    switch (obj_type) {
            
        default:
        case 1: // Info
            columnName = FRLOG_OBJ_TYPEINFO;
            break;
            
        case 2: // Info
            columnName = FRLOG_OBJ_TYPEURL;
            break;
            
    }
    
    return columnName;
    
}


#pragma mark -
#pragma mark Draw
#pragma mark -

- (id)drawDefaultObject:(id)object inColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    FRLogServerDataDefault *logObj = (FRLogServerDataDefault *)[dataSource objectAtIndex:row];
    
    if ([tableColumn.identifier isEqualToString:FRLOG_OBJ_ID]){
        
        // ID
        return [NSString stringWithFormat:@"%li", row+1];
        
    }else if ([tableColumn.identifier isEqualToString:FRLOG_OBJ_TYPE]) {
        
        // Type
        return [self setColumnType:FRLSDDefault];
        
    }else if ([tableColumn.identifier isEqualToString:FRLOG_OBJ_CLASSLINE]) {
        
        // Class name and line
        return [NSString stringWithFormat:@"%@:%@", logObj.obj_classname, logObj.obj_line];
        
    }else {
        
        // Content
        return logObj.obj_content;
        
    }
    
}

- (id)drawURLObject:(id)object inColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    FRLogServerDataURL *logObj = (FRLogServerDataURL *)[dataSource objectAtIndex:row];
    
    if ([tableColumn.identifier isEqualToString:FRLOG_OBJ_ID]){
        
        // ID
        return [NSString stringWithFormat:@"%li", row+1];
        
    } else if ([tableColumn.identifier isEqualToString:FRLOG_OBJ_TYPE]) {
        
        // Type
        return [self setColumnType:FRLSDURL];
        
    }else if ([tableColumn.identifier isEqualToString:FRLOG_OBJ_CLASSLINE]) {
        
        // Class name and line
        return [NSString stringWithFormat:@"-"];
        
    }else {
        
        // Content
        return [NSString stringWithFormat:@"REQUEST: %@\nURL: %@", logObj.obj_requestname, logObj.obj_url];
        
    }
    
}


@end

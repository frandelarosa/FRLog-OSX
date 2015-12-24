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
    
    self.dataSource = [NSMutableArray new];
    
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
    
    [self.dataSource addObject:datatype];
    
    [self.tableView reloadData];
    [self.tableView sizeLastColumnToFit];
    
    if ([self.dataSource count] > 0)
        [self.tableView scrollRowToVisible:[self.dataSource count] - 1];
    
    
}


#pragma mark -
#pragma mark TableView
#pragma mark -

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    
    NSInteger numRows = 0;
    
    if (self.dataSource && [self.dataSource count] > 0){
        numRows = [self.dataSource count];
    }
    
    return numRows;
    
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    id logObject = [self.dataSource objectAtIndex:row];
    
    if ([logObject isKindOfClass:[FRLogServerDataDefault class]]){
        return [self drawDefaultObject:logObject inColumn:tableColumn row:row];
    }else {
        return [self drawURLObject:logObject inColumn:tableColumn row:row];
    }
    
}

- (NSCell *)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    NSTextFieldCell *cell = [tableColumn dataCell];
    
    id logObj = [self.dataSource objectAtIndex:row];
    
    /******************
     Background Color
    *******************/
    
    [cell setDrawsBackground:YES];
    
    switch([[logObj valueForKey:@"obj_type"] integerValue]){
            
        case FRLSDDefault:
            [cell setBackgroundColor:[FRTextColor getColorByHexColor:@"0bd177" withAlpha:0.4]];
            break;
            
        case FRLSDURL:
            [cell setBackgroundColor:[FRTextColor getColorByHexColor:@"f99a1d" withAlpha:0.4]];
            break;
    }
    
    /******************
     Text Color
    *******************/
    
    [cell setTextColor:[NSColor blackColor]];
        

    
    return cell;
    
}

/*
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    
    id logObject = [dataSource objectAtIndex:row];
    
    NSString *content = nil;
    
    if ([logObject isKindOfClass:[FRLogServerDataDefault class]]){
        content = [FRObjectParser parseDefaultData:(FRLogServerDataDefault *)logObject];
    }else {
        content = [FRObjectParser parseURLData:(FRLogServerDataURL *)logObject];
    }
    
    NSTableColumn *tableColoumn = [tableView tableColumnWithIdentifier:FRLOG_OBJ_OUTPUT];
    
    CGFloat height = 0;
    
    if (tableColoumn){
        
        NSCell *dataCell = [tableColoumn dataCell];
        
        [dataCell setWraps:YES];
        [dataCell setStringValue:content];
        
        height = [self calculateIdealHeightForSize:[dataCell cellSize] content:content];

        return height;
        
    }
    
    return 30;
 
 https://www.youtube.com/watch?v=Zdw-rRFmi9c
    
}
 */

- (CGFloat)calculateIdealHeightForSize:(NSSize)size content:(NSString *)content {
    
    NSTextStorage * storage =
    [[NSTextStorage alloc] initWithAttributedString:[[NSAttributedString alloc] initWithString: content ]];
    
    NSTextContainer * container =
    [[NSTextContainer alloc] initWithContainerSize: size];
    NSLayoutManager * manager = [[NSLayoutManager alloc] init];
    
    [manager addTextContainer: container];
    [storage addLayoutManager: manager];
    
    [manager glyphRangeForTextContainer: container];
    
    NSRect idealRect = [manager usedRectForTextContainer: container];
    
    // Include a fudge factor.
    return idealRect.size.height + 25;
    
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
    
    FRLogServerDataDefault *logObj = (FRLogServerDataDefault *)[self.dataSource objectAtIndex:row];
    
    if ([tableColumn.identifier isEqualToString:FRLOG_OBJ_ID]){
        
        // Time
        return logObj.obj_date;
        
    }else if ([tableColumn.identifier isEqualToString:FRLOG_OBJ_TYPE]) {
        
        // Type
        return [[self setColumnType:FRLSDDefault] uppercaseString];
        
    }else if ([tableColumn.identifier isEqualToString:FRLOG_OBJ_CLASSLINE]) {
        
        // Class name and line
        return [NSString stringWithFormat:@"%@:%@", logObj.obj_classname, logObj.obj_line];
        
    }else {
        
        // Content
        return [FRObjectParser parseDefaultData:logObj];
        
    }
    
}

- (id)drawURLObject:(id)object inColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    FRLogServerDataURL *logObj = (FRLogServerDataURL *)[self.dataSource objectAtIndex:row];
    
    if ([tableColumn.identifier isEqualToString:FRLOG_OBJ_ID]){
        
        // Time
        return logObj.obj_date;
        
    } else if ([tableColumn.identifier isEqualToString:FRLOG_OBJ_TYPE]) {
        
        // Type
        return [[self setColumnType:FRLSDURL] uppercaseString];
        
    }else if ([tableColumn.identifier isEqualToString:FRLOG_OBJ_CLASSLINE]) {
        
        // Class name and line
        return [NSString stringWithFormat:@"-"];
        
    }else {
        
        // Content
        return [FRObjectParser parseURLData:logObj];
        
    }
    
}


@end

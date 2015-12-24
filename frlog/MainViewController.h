//
//  ViewController.h
//  frlog
//
//  Created by Fran on 25/4/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// Lib
#import "FRLogServer.h"

@interface MainViewController : NSViewController <FRLogServerDelegate, NSTableViewDataSource, NSTableViewDelegate> {
    
    FRLogServer *server;
    NSPredicate *filterPredicate;
    
    
}

@property (weak) IBOutlet NSTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end


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
#import "FRTextView.h"

@interface MainViewController : NSViewController <FRLogServerDelegate> {
    
    FRLogServer *server;
    NSMutableArray *_dataSource;
    
}

@property (unsafe_unretained) IBOutlet FRTextView *console;

@end


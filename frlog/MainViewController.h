//
//  ViewController.h
//  frlog
//
//  Created by Fran on 25/4/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FRTextView.h"

// Lib
#import "FRLogServer.h"

@interface MainViewController : NSViewController <FRLogServerDelegate> {
    
    FRLogServer *server;
    
}

@property (unsafe_unretained) IBOutlet FRTextView *console;

@end


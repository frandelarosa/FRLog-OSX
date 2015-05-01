//
//  AppDelegate.m
//  frlog
//
//  Created by Fran on 25/4/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    /*
   
    // Initalize our http server
    server = [[HTTPServer alloc] init];
    
    [server setPort:3000];
    [server setConnectionClass:[FRServerConnection class]];
    [server setType:@"_http._tcp."];
    
    NSError *error;
    BOOL success = [server start:&error];
    
    if(!success)
    {
        NSLog(@"Error starting HTTP Server: %@", error);
    }else{
        NSLog(@"Server Started On PORT: %i", 3000);
    }
     */
    
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end

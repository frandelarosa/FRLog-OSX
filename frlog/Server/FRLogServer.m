//
//  FRLogServer.m
//  frlog
//
//  Created by Fran on 25/4/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#import "FRLogServer.h"

@implementation FRLogServer

- (instancetype)initWithDelegate:(id)vcdelegate OnPort:(NSInteger)port {
    
    self = [super init];
    
    if (self){
        
        self.delegate = vcdelegate;
        
        // Initalize server
        server = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        NSError *error = nil;
        
        // Server stopped
        if (![server bindToPort:port error:&error]){
            
            [self.delegate onServer:self withStatus:FRLogServerStateStopped withError:error];
            return nil;
            
        }
        
        // Server closed
        if (![server beginReceiving:&error]){
            
            [server close];
            [self.delegate onServer:self withStatus:FRLogServerStateClosed withError:error];
            return nil;
            
        }
        
        // Server is running
        [self.delegate onServer:self withStatus:FRLogServerStateRunning withError:nil];
        self.isRunning = YES;
        
    }
    
    return self;
    
}

#pragma mark -
#pragma mark Reading
#pragma mark -

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext {
    
    // Decode data
    NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if (msg){
        NSLog(@"==== MSG RCVD ====\n%@", msg);
    }else{
        NSLog(@"==== MSG ERROR ====\nError converting received data into UTF-8 String");
    }
    
}


@end

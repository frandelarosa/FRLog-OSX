//
//  FRLogServer.m
//  frlog
//
//  Created by Fran on 25/4/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#import "FRLogServer.h"

// Models
#import "FRLogServerDataDefault.h"
#import "FRLogServerDataURL.h"

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
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    // Type
    if (json != nil && ![json isEqualTo:[NSNull null]]){
        
        //NSLog(@"JSON: %@", json);
        
        // Get object type
        NSInteger objectType = [json[@"type"] integerValue];
        NSArray *jsonArr     = [NSArray arrayWithObject:json[@"log"]];
        
        switch(objectType){
                
            // Default Object
            case FRLSDDefault:
                [self parseDefaultObject:jsonArr];
                break;
                
            // URL Object
            case FRLSDURL:
                [self parseURLObject:jsonArr];
                break;
        }
        

    }
    
}


#pragma mark -
#pragma mark Parsing
#pragma mark -

- (void)parseDefaultObject:(NSArray *)jsonArr {
    
    NSArray *arrData = [FRLogServerDataDefault arrayOfModelsFromDictionaries:jsonArr];
    
    FRLogServerDataDefault *objdata = (FRLogServerDataDefault *)arrData.firstObject;
    
    [self.delegate onServer:self readData:objdata];
    
}

- (void)parseURLObject:(NSArray *)jsonArr {
    
    NSArray *arrData = [FRLogServerDataURL arrayOfModelsFromDictionaries:jsonArr];
    
    FRLogServerDataURL *objdata = (FRLogServerDataURL *)arrData.firstObject;
    
    [self.delegate onServer:self readData:objdata];
    
}


@end

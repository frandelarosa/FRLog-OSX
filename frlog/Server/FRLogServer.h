//
//  FRLogServer.h
//  frlog
//
//  Created by Fran on 25/4/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GCDAsyncUdpSocket.h"

typedef NS_ENUM(NSUInteger, FRLogServerState) {
    FRLogServerStateStopped,
    FRLogServerStateRunning,
    FRLogServerStateClosed
};

@protocol FRLogServerDelegate;

@interface FRLogServer : NSObject <GCDAsyncUdpSocketDelegate> {
    
    GCDAsyncUdpSocket *server;
    
}

// Properties
@property (nonatomic, assign) BOOL isRunning;

// Delegate
@property (weak)id<FRLogServerDelegate> delegate;

// Methods
- (instancetype)initWithDelegate:(id)vcdelegate OnPort:(NSInteger)port;

@end

@protocol FRLogServerDelegate

- (void)onServer:(FRLogServer *)server withStatus:(FRLogServerState)state withError:(NSError *)error;

@end

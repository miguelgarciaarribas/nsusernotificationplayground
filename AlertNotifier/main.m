//
//  main.m
//  AlertNotifier
//
//  Created by Miguel Garcia on 18/04/2016.
//  Copyright © 2016 Miguel Garcia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlertNotifier.h"

@interface ServiceDelegate : NSObject <NSXPCListenerDelegate>
- (void) initNotiticationCenter;
@property (weak) NSXPCConnection *connection;
@end

@implementation ServiceDelegate
- (void) initNotiticationCenter {
    NSLog(@"INITIALIZING SERVICE OBJECT");
    [[NSUserNotificationCenter defaultUserNotificationCenter]setDelegate:self];
}

- (BOOL)listener:(NSXPCListener *)listener shouldAcceptNewConnection:(NSXPCConnection *)newConnection {
    // This method is where the NSXPCListener configures, accepts, and resumes a new incoming NSXPCConnection.
    
    // Configure the connection.
    // First, set the interface that the exported object implements.
    newConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(AlertNotifierProtocol)];
    
    // Next, set the object that the connection exports. All messages sent on the connection to this service will be sent to the exported object to handle. The connection retains the exported object.
    AlertNotifier *exportedObject = [AlertNotifier new];
    newConnection.exportedObject = exportedObject;
    _connection = newConnection;
    newConnection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol: @protocol(AlertNotifierReplyProtocol)];
    
    // Resuming the connection allows the system to deliver more incoming messages.
    [newConnection resume];
    
    // Returning YES from this method tells the system that you have accepted this connection. If you want to reject the connection for some reason, call -invalidate on the connection and return NO.
    return YES;
}

- (void)userNotificationCenter:(NSUserNotificationCenter*)center
       didActivateNotification:(NSUserNotification*)notification {
    NSLog(@"NOTIFICATION CLICKED ON THE XPC SERVICE");
    [[_connection remoteObjectProxy] notificationClick: @"notId"];
}

@end

int main(int argc, const char *argv[])
{
    NSLog(@"INITIALIZING XPC SERVICE MAIN");
    // Create the delegate for the service.
    ServiceDelegate *delegate = [ServiceDelegate new];
    [delegate initNotiticationCenter];
    
    // Set up the one NSXPCListener for this service. It will handle all incoming connections.
    NSXPCListener *listener = [NSXPCListener serviceListener];
    listener.delegate = delegate;

    // This keeps the connection open forever since there is no xpc_transaction_end()
    xpc_transaction_begin();
    
    // Resuming the serviceListener starts this service. This method does not return.
    [listener resume];
    return 0;
}

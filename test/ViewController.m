//
//  ViewController.m
//  test
//
//  Created by Miguel Garcia on 07/01/2016.
//  Copyright © 2016 Miguel Garcia. All rights reserved.
//

#import "ViewController.h"
#import "AlertNotifier.h"
#import "CommonDefinitions.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _shouldRenotify.state = NSOffState;
    _shouldDelay.state = NSOffState;
    _requireInteraction.state = NSOffState;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (IBAction)onclic:(id)sender {    
    if (_shouldDelay.state == NSOnState) {
        usleep(3000000);
    }
    
    if (_requireInteraction.state == NSOnState) {
        NSLog(@"DISPLAY ALERT");
        _connection = [[NSXPCConnection alloc] initWithServiceName:@"cg.AlertNotifier"];
        _connection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(AlertNotifierProtocol)];
        _connection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(AlertNotifierReplyProtocol)];
        _connection.exportedObject = self;
        [_connection resume];
        
        NSDictionary* notificationInfo = @{
                                           @"title" : [_titleTextBox stringValue],
                                           @"informativeText" : @"Sponsored by XPC services TM."
                                           };
        
        [[_connection remoteObjectProxy] showAlert:notificationInfo];
    } else {
    
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    [notification setTitle: [_titleTextBox stringValue]];
    /*
    // Set tag
    if ([notification respondsToSelector:@selector(setIdentifier:)] &&
        _tagBox.stringValue.length > 0) {
      [notification setValue:_tagBox.stringValue
               forKey:@"identifier"];
        
    // If renotify remove any existing notification in the notification center.
    if (_shouldRenotify.state == NSOnState) {
        NSUserNotificationCenter* notificationCenter =
        [NSUserNotificationCenter defaultUserNotificationCenter];
        for (NSUserNotification* toast in
             [notificationCenter deliveredNotifications]) {
            
            if ([toast.identifier isEqual: _tagBox.stringValue]) {
                [notificationCenter removeDeliveredNotification:toast];
            }
        }
        
    }
  } */




  [notification setValue:@YES forKey:@"_showsButtons"];
  notification.hasActionButton = YES;
  notification.otherButtonTitle = @"Close";
  notification.actionButtonTitle = @"Options..";

  [notification setValue:@2 forKey:@"_displayStyle"];  // 2 alert // 1 banner
  [notification setValue:@2 forKey:@"_style"];  // This seems useless]
  [notification setValue:@YES forKey:@"_presented"];

    

  // 0x0 == default; 0x2 would be system
  NSUserNotificationCenter* center =
    [NSUserNotificationCenter _centerForIdentifier:@"com.google.NotificationTest.banners"  type:0x0];
    
    
    /// DISPLAY
   [center deliverNotification:notification];
    }
}

- (void) notificationClick: (NSString*) notificationId {
    [self logMessage:[NSString stringWithFormat:@"Alert Notification Clicked"]];
}

- (void)logMessage:(NSString*)message {
    _eventLog.stringValue = message;
}


@end

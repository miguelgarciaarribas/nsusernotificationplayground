//
//  ViewController.m
//  test
//
//  Created by Miguel Garcia on 07/01/2016.
//  Copyright © 2016 Miguel Garcia. All rights reserved.
//

#import "ViewController.h"
#import "CommonDefinitions.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _shouldRenotify.state = NSOffState;
    _shouldDelay.state = NSOffState;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (IBAction)onclic:(id)sender {
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

  if (_shouldDelay.state == NSOnState) {
        usleep(3000000);
  }


  [notification setValue:@YES forKey:@"_showsButtons"];
  notification.hasActionButton = YES;
  notification.otherButtonTitle = @"Close";
  notification.actionButtonTitle = @"Options..";

  [notification setValue:@1 forKey:@"_displayStyle"];  // 2 alert // 1 banner
  [notification setValue:@1 forKey:@"_style"];  // This seems useless

  // 0x0 == default; 0x2 would be system
  NSUserNotificationCenter* center =
    [NSUserNotificationCenter _centerForIdentifier:[[NSBundle mainBundle] bundleIdentifier]  type:0x0];
    
    
    /// DISPLAY
   [center scheduleNotification:notification];
}

- (void)logMessage:(NSString*)message {
    _eventLog.stringValue = message;
}


@end

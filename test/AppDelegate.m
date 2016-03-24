//
//  AppDelegate.m
//  test
//
//  Created by Miguel Garcia on 07/01/2016.
//  Copyright © 2016 Miguel Garcia. All rights reserved.
//

#import "AppDelegate.h"
#import "CommonDefinitions.h"

//#import "_NSUserNotificationCenterDelegatePrivate.h"

struct InternalFrames {
    NSRect contextMessageFrame;
    NSRect settingsButtonFrame;
};


@interface AppDelegate ()

- (void) increaseFrames:(struct InternalFrames*)frame
                  delta:(CGFloat) detlta;

@end


@implementation AppDelegate


- (void) increaseFrames:(struct InternalFrames*) frame
                  delta:(CGFloat) delta {
    frame->contextMessageFrame.origin.y += delta;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSUserNotificationCenter* center =
    [NSUserNotificationCenter _centerForIdentifier:[[NSBundle mainBundle] bundleIdentifier]  type:0x0];
    [center setDelegate:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center
     shouldPresentNotification:(NSUserNotification *)notification
{
    NSLog(@"shouldPresent called");
    return YES;
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center
     shouldActivateForNotification:(NSUserNotification *)notification
{
    NSLog(@"shouldActivate called");
    return NO;
}

- (void)userNotificationCenter:(NSUserNotificationCenter*)center
       didActivateNotification:(NSUserNotification*)notification {
    NSLog(@"activated called type %ld", (long) notification.activationType);
    NSLog(@"Multiple items? %@", [notification valueForKey:@"_alwaysShowAlternateActionMenu"]);
    NSLog(@"activated index %@", [notification valueForKey:@"_alternateActionIndex"]);
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)arg1 didDismissAlert:(NSUserNotification *)notification {
    NSLog(@"Notification dismissed %@", notification.title);
    
    NSNumber* display_style = [notification valueForKey:@"_displayStyle"];
    NSNumber* style = [notification valueForKey:@"_style"];
    NSLog(@"STYLE VALUE %@", style);
    NSLog(@"DISPLAY Style VALUE %@", display_style);
}


@end

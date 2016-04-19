//
//  AppDelegate.m
//  test
//
//  Created by Miguel Garcia on 07/01/2016.
//  Copyright © 2016 Miguel Garcia. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
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
    [NSUserNotificationCenter _centerForIdentifier:@"com.google.NotificationTest.banners" type:0x0];
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

    NSNumber* display_style = [notification valueForKey:@"_displayStyle"];
    NSLog(@"style %@", [notification valueForKey:@"_style"]);

    ViewController* controller = (ViewController *)[[NSApplication sharedApplication] mainWindow].contentViewController;
    [controller logMessage:[NSString stringWithFormat:@"Notification Clicked: Display Style - %@, Activation type %ld",
                            display_style,  (long)notification.activationType]];
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)arg1 didDismissAlert:(NSUserNotification *)notification {
    NSLog(@"Notification dismissed %@", notification.title);

    NSNumber* display_style = [notification valueForKey:@"_displayStyle"];
    NSNumber* style = [notification valueForKey:@"_style"];
    NSLog(@"STYLE VALUE %@", style);
    NSLog(@"DISPLAY Style VALUE %@", display_style);

    NSApplication* application = [NSApplication sharedApplication];

    ViewController* controller = (ViewController *)[[NSApplication sharedApplication] mainWindow].contentViewController;
    [controller logMessage:[NSString stringWithFormat:@"Notification Closed: Display Style - %@",
                            display_style]];
}


@end

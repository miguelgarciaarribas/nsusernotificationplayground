//
//  AlertNotifier.m
//  AlertNotifier
//
//  Created by Miguel Garcia on 18/04/2016.
//  Copyright © 2016 Miguel Garcia. All rights reserved.
//

#import "AlertNotifier.h"

@implementation AlertNotifier

- (void)showAlert:(NSDictionary*) properties {
    NSLog(@"NOTIFICATION RECEIVED ON XPC");
    NSUserNotification* n = [NSUserNotification new];
    n.title = [properties objectForKey:@"title"];
    n.informativeText = [properties objectForKey:@"informativeText"];
    [n setValue:@YES forKey:@"_showsButtons"];
    n.hasActionButton = YES;
    n.otherButtonTitle = @"Close";
    n.actionButtonTitle = @"Options..";
    NSUserNotificationCenter* c = [NSUserNotificationCenter defaultUserNotificationCenter];
    [c deliverNotification:n];
}

@end

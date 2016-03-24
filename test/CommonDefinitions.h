//
//  CommonDefinitions.h
//  test
//
//  Created by Miguel Garcia on 24/03/2016.
//  Copyright © 2016 Miguel Garcia. All rights reserved.
//

#ifndef CommonDefinitions_h
#define CommonDefinitions_h


@interface NSUserNotificationCenter (PrivateAPI)
+ (NSUserNotificationCenter*)_centerForIdentifier:(NSString*)ident type:(NSUInteger)type;
@end


@protocol _NSUserNotificationCenterDelegatePrivate <NSUserNotificationCenterDelegate>

@optional
- (void)userNotificationCenter:(NSUserNotificationCenter *)arg1 notificationsDisabled:(BOOL)arg2;
- (void)userNotificationCenter:(NSUserNotificationCenter *)arg1 summaryShown:(BOOL)arg2;
- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)arg1 shouldActivateForNotification:(NSUserNotification *)arg2;
- (void)userNotificationCenter:(NSUserNotificationCenter *)arg1 responseChanged:(unsigned long long)arg2 forNotification:(NSUserNotification *)arg3;
- (void)userNotificationCenter:(NSUserNotificationCenter *)arg1 didFailToRegisterForRemoteNotificationsWithError:(NSError *)arg2;
- (void)userNotificationCenter:(NSUserNotificationCenter *)arg1 didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)arg2;
- (void)userNotificationCenter:(NSUserNotificationCenter *)arg1 didExpireNotifications:(NSArray *)arg2;
- (void)userNotificationCenter:(NSUserNotificationCenter *)arg1 didRemoveDeliveredNotifications:(NSArray *)arg2;
- (void)userNotificationCenter:(NSUserNotificationCenter *)arg1 didSnoozeAlert:(NSUserNotification *)arg2;
- (void)userNotificationCenter:(NSUserNotificationCenter *)arg1 didDismissAlert:(NSUserNotification *)arg2;
@end


#endif /* CommonDefinitions_h */

//
//  AlertNotifierProtocol.h
//  AlertNotifier
//
//  Created by Miguel Garcia on 18/04/2016.
//  Copyright © 2016 Miguel Garcia. All rights reserved.
//

#import <Foundation/Foundation.h>

// The protocol that this service will vend as its API. This header file will also need to be visible to the process hosting the service.
@protocol AlertNotifierProtocol

- (void)showAlert:(NSDictionary*) properties;
    
@end


@protocol AlertNotifierReplyProtocol
- (void) notificationClick: (NSString*) notificationId;
@end
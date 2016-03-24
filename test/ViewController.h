//
//  ViewController.h
//  test
//
//  Created by Miguel Garcia on 07/01/2016.
//  Copyright © 2016 Miguel Garcia. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController
- (IBAction)onclic:(id)sender;

@property (weak) IBOutlet NSTextField *titleTextBox;
@property (weak) IBOutlet NSTextField *tagBox;
@property (weak) IBOutlet NSButton *shouldRenotify;
@property (weak) IBOutlet NSButton *shouldDelay;

@end


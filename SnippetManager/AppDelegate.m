//
//  AppDelegate.m
//  SnippetManager
//
//  Created by Kirill Ushkov on 1/31/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    NSWindow *window = [[[NSApplication sharedApplication] windows] firstObject];
    
    ViewController *vc = (ViewController*)[window contentViewController];
    
    vc.apiClient = [ApiClient sharedInstance];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end

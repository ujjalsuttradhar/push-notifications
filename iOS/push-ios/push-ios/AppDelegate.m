//
//  AppDelegate.m
//  push-ios
//
//  Created by Enosis on 5/7/15.
//  Copyright (c) 2015 Enosis. All rights reserved.
//

#import "AppDelegate.h"

#define serviceURL @"http://192.168.1.64:8888/push-notifications/webservice/index.php?action_type=deviceInfo"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"Did Register for Remote Notifications with Device Token (%@)", deviceToken);
    
    
    NSString *bndry = [self generateRandomBoundryString];
    NSString *contentType = [[NSString alloc] initWithString:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", bndry]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serviceURL]];
    [request setHTTPMethod:@"POST"];
    
    NSMutableData *requestBody = [NSMutableData data];
    
    [requestBody appendData:[[NSString stringWithFormat:@"device_name=%@&token=%@&type=iOS", @"Ujjal", deviceToken] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody: requestBody];
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    
    NSString *responseBody = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", responseBody);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%@, %@", error, error.localizedDescription);
}

-(NSString *)generateRandomBoundryString {
    CFUUIDRef UUID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef UUIDString = CFUUIDCreateString(kCFAllocatorDefault,UUID);
    NSString *aNSString = (__bridge NSString *)UUIDString;
    CFRelease(UUID);
    CFRelease(UUIDString);
    return aNSString;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    // This get's the number you sent in the push and update your app badge.
    [UIApplication sharedApplication].applicationIconBadgeNumber = [[userInfo objectForKey:@"badge"] integerValue];
    
    // Shows an alert in case the app is open, otherwise it won't notify anything
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"New Notification!"
                                                        message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]  delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];    
}

@end

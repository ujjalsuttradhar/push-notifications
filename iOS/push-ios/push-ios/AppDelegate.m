//
//  AppDelegate.m
//  push-ios
//
//  Created by Enosis on 5/7/15.
//  Copyright (c) 2015 Enosis. All rights reserved.
//

#import "AppDelegate.h"

#define serviceURL @"http://192.168.1.64:8888/push-notifications/webservice/index.php?type=deviceInfo"

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
    
    [requestBody appendData:[[NSString stringWithFormat:@"username=%@&device_token=%@&os_type=iOS", @"ujjal", deviceToken] dataUsingEncoding:NSUTF8StringEncoding]];
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

@end

# What is push-notifications?
push-notifications is an example of using remote push notification in both Android and iOS. For iOS, Apple Push Notification (APN) and for Android Google Cloud Messaging (GCM) are used.


# How to execute (iOS)?
1. Dump push_notification.sql on your database.
2. Update database connection string in webservice/index.php line 12
3. Open push-ios project using XCode.
4. Update serviceURL (path to the webservice) in appDelegate.m
5. Change PushIOS.pem file following the URL no 02 from reference list
6. Open send_push_service.php and and update $passphrase
7. Run push-ios from the device
7. Now open webservice/index.php which will show a list of devices. Select anyone of them and press submit to send a push notification

# References
1. [developer.apple.com](https://developer.apple.com/library/ios/documentation/IDEs/Conceptual/AppDistributionGuide/ConfiguringPushNotifications/ConfiguringPushNotifications.html)

2. [tutsplus](http://code.tutsplus.com/tutorials/setting-up-push-notifications-on-ios--cms-21925)

3. [raywenderlich](http://www.raywenderlich.com/32960/apple-push-notification-services-in-ios-6-tutorial-part-1)
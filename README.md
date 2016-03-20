# NOTIFIT-Swift

[![CI Status](http://img.shields.io/travis/Tomas Sykora, jr./NOTIFIT-Swift.svg?style=flat)](https://travis-ci.org/Tomas Sykora, jr./NOTIFIT-Swift)
[![Version](https://img.shields.io/cocoapods/v/NOTIFIT-Swift.svg?style=flat)](http://cocoapods.org/pods/NOTIFIT-Swift)
[![License](https://img.shields.io/cocoapods/l/NOTIFIT-Swift.svg?style=flat)](http://cocoapods.org/pods/NOTIFIT-Swift)
[![Platform](https://img.shields.io/cocoapods/p/NOTIFIT-Swift.svg?style=flat)](http://cocoapods.org/pods/NOTIFIT-Swift)

## Installation

NOTIFIT-Swift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "NOTIFIT-Swift"
```

## Usage

### Register device

You can register device with running your running application to NOTIFIT server just by adding this line to your `AppDelegate` to `didFinishLaunchingWithOptions` function

```swift
    Notifit.registerDeviceForProject("PROJECT_TOKEN", forApplication: "APPLICATION_TOKEN")
```

### Notification token

If you want to be able to send push notification to this device you need to implement this line of code to `didRegisterForRemoteNotificationsWithDeviceToken`

```swift
Notifit.updateNotificationToken(deviceToken)
```

### Getting PEM certificate

In order to be able to send push notification to device with this NOTIFIT SDK, you need to add correct PEM certificate to created application on NOTIFIT server.

In case you are not using fastlane (https://github.com/fastlane/fastlane.git) you really should. In Fastlane tools there is a tool called pem (https://github.com/fastlane/fastlane/tree/master/pem) using this you are able to generate PEM certificate for your application.

#### Production certificate

```sh
pem 
```

This will create 3 file on your disk `production_{{BUNDLE_ID}}.{pem | pkey | p12}`

You need to upload `.pem` to NOTIFIT

#### Development certificate (for sandbox device tokens)

```sh
pem --development
```

Proceed same as with production certificate

You need to create 2 iOS applications for each application on NOTIFIT in order to be able to recieve push notification while developing and also when running production builds of your iOS application.


## Author

Tomas Sykora, jr., jump@syky.cz 
Project leader, iOS developer and initiator of NOTIFIT

## License

NOTIFIT-Swift is available under the MIT license. See the LICENSE file for more info.

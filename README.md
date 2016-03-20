# NOTIFIT-Swift

[![CI Status](http://img.shields.io/travis/Tomas Sykora, jr./NOTIFIT-Swift.svg?style=flat)](https://travis-ci.org/Tomas Sykora, jr./NOTIFIT-Swift)
[![Version](https://img.shields.io/cocoapods/v/NOTIFIT-Swift.svg?style=flat)](http://cocoapods.org/pods/NOTIFIT-Swift)
[![License](https://img.shields.io/cocoapods/l/NOTIFIT-Swift.svg?style=flat)](http://cocoapods.org/pods/NOTIFIT-Swift)
[![Platform](https://img.shields.io/cocoapods/p/NOTIFIT-Swift.svg?style=flat)](http://cocoapods.org/pods/NOTIFIT-Swift)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

NOTIFIT-Swift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "NOTIFIT-Swift"
```

## Usage

### Register device

You can register device with running your running application to NOTIFIT server just by adding this line to your `AppDelegate`

```
Notifit.registerDeviceForProject("93c5752c-aaee-e511-942b-00155d000710", forApplication: "ab64e743-aaee-e511-942b-00155d000710")
```


## Author

Tomas Sykora, jr., jump@syky.cz

## License

NOTIFIT-Swift is available under the MIT license. See the LICENSE file for more info.

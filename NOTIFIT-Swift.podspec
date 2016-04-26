#
# Be sure to run `pod lib lint NOTIFIT-Swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "NOTIFIT-Swift"
  s.version          = "0.1.1"
  s.summary          = "SDK for NOTIFIT.io"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = "Swift pod for implementing NOTIFIT to your iOS application"

  s.homepage         = "https://github.com/NOTIFIT/notifit-ios-swift-sdk"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Tomas Sykora, jr." => "jump@syky.cz" }
  s.source           = { :git => "https://github.com/NOTIFIT/notifit-ios-swift-sdk.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/syky27'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'NOTIFIT-Swift' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

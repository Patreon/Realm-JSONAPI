#
# Be sure to run `pod lib lint RLMObject-JSONAPI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "RLMObject-JSONAPI"
  s.version          = "0.0.1"
  s.summary          = "Easily integrate with a JSON-API compliant server"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
RLMObject+JSONAPI provides a set of utilities to easily move between
JSON-API formatted data (http://jsonapi.org) and Realm objects (http://realm.io).
                       DESC

  s.homepage         = "https://github.com/Patreon/RLMObject-JSONAPI"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { "David Kettler" => "david@patreon.com" }
  s.source           = { :git => "https://github.com/Patreon/RLMObject-JSONAPI.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'RLMObject-JSONAPI/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RLMObject-JSONAPI' => ['RLMObject-JSONAPI/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Realm', '~> 0.102.1'
end

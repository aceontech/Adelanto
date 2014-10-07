#
# Be sure to run `pod lib lint Adelanto.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Adelanto"
  s.version          = "0.1.0"
  s.summary          = "iOS version and update utilities"
  s.description      = <<-DESC
                       ADLVersionManager can be used to display the app's current version and build number in the iOS Settings panel.
                       DESC
  s.homepage         = "https://github.com/aceontech/Adelanto"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Alex Manarpies" => "alex@manarpies.com" }
  s.source           = { :git => "https://github.com/aceontech/Adelanto.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/aceontech'

  s.platform     = :ios, '7.1'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'Adelanto' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

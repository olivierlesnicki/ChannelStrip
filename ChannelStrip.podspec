#
#  Be sure to run `pod spec lint ChannelStrip.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "ChannelStrip"
  s.version      = "0.0.1"
  s.summary      = "A suite of effect and analysis nodes for AudioKit"
  s.homepage     = "https://github.com/olivierlesnicki/ChannelStrip"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Olivier Lesnicki" => "olivier.lesnicki@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/olivierlesnicki/ChannelStrip.git", :tag => "#{s.version}" }
  s.source_files  = "ChannelStrip/**/*.{swift}"
  s.dependency 'AudioKit', '~> 3.5'
end

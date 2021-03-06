#
# Be sure to run `pod lib lint PerhapYs.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PerhapYs'
  s.version          = '1.0.1'
  s.summary          = 'my develop toolBox'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                            this pod help me develop my swift development
                       DESC

  s.homepage         = 'https://github.com/PerhapYs/PerhapYs'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'PerhapYs' => '370060080@qq.com' }
  s.source           = { :git => 'https://github.com/PerhapYs/PerhapYs.git', :tag => 'v1.0.1.0'}
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.platform         = :ios
  s.requires_arc      = true
  s.ios.deployment_target = '10.0'
  s.swift_versions   = '5.0'
  s.source_files = 'PerhapYs/Classes/*','PerhapYs/Classes/Base/*','PerhapYs/Classes/Custom/*','PerhapYs/Classes/Define/*','PerhapYs/Classes/Extension/*','PerhapYs/Classes/Manager/*'
  
  # s.resource_bundles = {
  #   'PerhapYs' => ['PerhapYs/Assets/*.png']
  # }

  #s.public_header_files = 'Pod/Classes/*.swift'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end


Pod::Spec.new do |s|

  s.name         = "FMTipsWatchDog"
  s.version      = "0.0.1"
  s.summary      = "FMTipsWatchDog that is an framework be used manage popover tips when the page is very complex."

  s.description  = "in a page is very complex, we maybe need add some tips and manage it sequence, but they maybe be difine in difference of view. And then, that is very complex things, this framework is useful when we do that."

  s.homepage     = "https://github.com/acekiller/FMTipsWatchDog"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "acekiller" => "fengxijun51020@hotmail.com" }
  # Or just: s.author    = "acekiller"
  # s.authors            = { "acekiller" => "fengxijun51020@hotmail.com" }
  # s.social_media_url   = "http://twitter.com/acekiller"
  # s.platform     = :ios
  s.platform     = :ios, "8.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/acekiller/FMTipsWatchDog.git", :tag => "0.0.1" }

  s.source_files  = "Classes", "FMTipsWatchDog/Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "ReactiveCocoa", "~> 2.5"

end

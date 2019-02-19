Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '12.0'
s.name = "gameballSDK"
s.summary = "gameball SDK pod."
s.requires_arc = true

# 2
s.version = "0.1.7"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Ahmed Abodeif" => "ahmed.adel.abodeif@gmail.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/AhmedDeif/gameballSDK"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/AhmedDeif/gameballSDK.git", 
             :tag => "#{s.version}" }

#s.static_framework = true
# 7
s.framework = "UIKit"
#s.dependency 'Firebase'
#

  s.static_framework = true
  s.dependency 'Firebase'
s.dependency 'Firebase/Core'
  s.pod_target_xcconfig = {

"ENABLE_BITCODE" => 'NO',

"OTHER_LDFLAGS" => '$(inherited) -framework "gameballSDK"'
}

# 8
#s.source_files = "gameballSDK/*.{swift}"
s.source_files = "gameballSDK/**/*.{swift}"
#s.public_header_files = 'gameballSDK*.h'
#s.exclude_files = "gameballSDK/info.plist"

# 9
s.resources = "gameballSDK/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}", "gameballSDK/GoogleService-InfoGameball.plist"

# 10
s.swift_version = "4.2"

end

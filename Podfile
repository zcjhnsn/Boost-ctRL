# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'Boost ctRL' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Boost ctRL

pod 'Firebase'
pod 'Firebase/Core'
pod 'Firebase/Database'
pod 'Firebase/Storage'
pod 'Firebase/Messaging'
pod 'ACTabScrollView', :git => 'https://github.com/azurechen/ACTabScrollView.git'
pod 'RealmSwift', '~> 3.18.0'
pod 'AlertOnboarding', :git => 'https://github.com/gilthonweapps/AlertOnboarding'

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings.delete('CODE_SIGNING_ALLOWED')
    config.build_settings.delete('CODE_SIGNING_REQUIRED')
  end
end

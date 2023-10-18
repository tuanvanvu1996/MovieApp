# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MovieApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'FirebaseCore'
  pod 'FirebaseAuth'
  pod 'KeychainSwift', '~> 20.0'
  pod 'GoogleSignIn'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'
  pod 'Alamofire'
  pod 'Kingfisher', '~> 7.0'
  # Pods for MovieApp

end
post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target, |
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
  end
end

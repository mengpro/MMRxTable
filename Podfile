# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'MMRxTable' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MMRxTable
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxBlocking'
  pod 'RxDataSources'
  pod 'Then'
  pod 'Moya/RxSwift'
  pod 'ObjectMapper'
  pod 'SnapKit'
  pod 'SwiftyJSON'
  pod 'TSVoiceConverter'
  pod 'XCGLogger'
  pod 'TimedSilver'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'YES'
#            config.build_settings['SWIFT_ENFORCE_EXCLUSIVE_ACCESS'] = 'compile-time'
        end
    end
end

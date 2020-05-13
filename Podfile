source 'https://github.com/CocoaPods/Specs.git'

platform :ios, ‘10.0’
use_frameworks!
inhibit_all_warnings!

target 'Development' do
    pod 'Nuke'
    pod 'IQKeyboardManagerSwift'
    pod 'Alamofire'
    pod 'ESPullToRefresh'
    pod 'FTIndicator'
    pod 'Mocker'
    pod 'Resolver'
    pod 'AppCenter'
    pod 'SwiftLint'
    pod 'RxSwift'
    pod 'RxCocoa'
    pod "Apollo"

    target 'MockingProjectTests' do
        inherit! :search_paths
    end

    target 'Test' do
        inherit! :search_paths
        pod 'RxBlocking'
        pod 'RxTest'
    end

    target 'Production' do
        inherit! :search_paths
    end
end


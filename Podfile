source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

target 'Development' do

    #UI Dev
    pod 'Nuke'
    pod 'IQKeyboardManagerSwift'
    pod 'ESPullToRefresh'
    pod 'FTIndicator'

    #Networking
    pod 'Alamofire'

    #Testing
    pod 'Mocker'

    #Dependency Injection
    pod 'Swinject'
    pod 'SwinjectAutoregistration'
    pod 'SwinjectStoryboard'
    pod 'Resolver'


    #Reactive / Functional Programming
    pod 'RxSwift'
    pod 'RxCocoa'

    #CI/CD
    pod 'AppCenter'
    pod 'SwiftLint'

    #GraphQL
    pod 'Apollo'

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


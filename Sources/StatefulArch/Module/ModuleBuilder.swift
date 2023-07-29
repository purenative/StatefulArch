//
// ModuleBuilder.swift
// StatefulArch
//
// MIT License
//
// Copyright (c) 2022 Pure Native
//

import Foundation

public protocol ModuleBuilder {
    
    @MainActor
    func buildModule(serviceProvider: ServiceProvider) -> ModuleConvertible
    
}

public extension ModuleBuilder {
    
    @MainActor
    func buildPageModule<P: PageView>(typeOfPage: P.Type, launchInfo: P.Interceptor.LaunchInfo, serviceProvider: ServiceProvider) -> ModuleConvertible {
        let state = P.Interceptor.State()
        
        let page = P(state: state)
        
        page.interceptor.provideServices(withServiceProvider: serviceProvider)
        page.interceptor.set(state: state)
        page.interceptor.start(launchInfo: launchInfo)

        return page
    }
    
    @MainActor
    func buildPageModule<P: PageView>(typeOfPage: P.Type, serviceProvider: ServiceProvider) -> ModuleConvertible where P.Interceptor.LaunchInfo == Void {
        buildPageModule(
            typeOfPage: typeOfPage,
            launchInfo: (),
            serviceProvider: serviceProvider
        )
    }
    
}

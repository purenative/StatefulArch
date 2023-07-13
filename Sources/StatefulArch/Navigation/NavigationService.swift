//
// NavigationService.swift
// StatefulArch
//
// MIT License
//
// Copyright (c) 2022 Pure Native
//

import Foundation
import Dispatch

@MainActor
public final class NavigationService {
    
    private(set) static var moduleAssembler: ModuleAssembler!
    
    public static func set(serviceProvider: ServiceProvider) {
        self.moduleAssembler = ModuleAssembler(serviceProvider: serviceProvider)
    }
    
    public static func use(navigation: Navigation, with moduleBuilder: ModuleBuilder?, animated: Bool) {
        try! throwServiceProviderNotInstalledError()
        
        DispatchQueue.main.async {
            if let moduleBuilder = moduleBuilder {
                let module = moduleAssembler.assemblyModule(using: moduleBuilder)
                navigation.navigate(
                    module: module,
                    in: RootView.rootViewController,
                    animated: animated
                )
            } else {
                navigation.navigate(
                    module: nil,
                    in: RootView.rootViewController,
                    animated: animated
                )
            }
        }
    }
    
}

private extension NavigationService {
 
    static func throwServiceProviderNotInstalledError() throws {
        if moduleAssembler == nil {
            throw NavigationServiceError.serviceProviderNotInstalled
        }
    }
    
}

public enum NavigationServiceError: Error {
    
    case serviceProviderNotInstalled
    
}

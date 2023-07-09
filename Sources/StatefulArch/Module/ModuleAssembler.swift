//
// ModuleAssembler.swift
// StatefulArch
//
// MIT License
//
// Copyright (c) 2022 Pure Native
//

import Foundation

@MainActor
public struct ModuleAssembler {
    
    let serviceProvider: ServiceProvider
    
    public init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    public func assemblyModule(using builder: ModuleBuilder) -> Module {
        return builder
            .buildModule(serviceProvider: serviceProvider)
            .asModule()
    }
    
}

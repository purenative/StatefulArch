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

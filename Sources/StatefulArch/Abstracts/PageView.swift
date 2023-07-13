//
// PageView.swift
// StatefulArch
//
// MIT License
//
// Copyright (c) 2022 Pure Native
//

import Foundation
import SwiftUI

public protocol PageView: View, ModuleConvertible {
    
    associatedtype Interceptor: PageInterceptor

    var state: Interceptor.State { get }
    var interceptor: Interceptor { get }
    
    init(state: Interceptor.State)
    
}

public extension PageView {
    
    func asModule(withOptions moduleOptions: ModuleOptions) -> Module {
        let controller = PageViewHostingController(rootView: self)
        let module = controller.asModule(withOptions: moduleOptions)
        return module
    }
    
}

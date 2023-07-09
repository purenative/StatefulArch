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

public protocol PageView: View {
    
    associatedtype State
    associatedtype Interceptor
    
    var interceptor: Interceptor { get }
    
    init(state: State,
         interceptor: Interceptor)
    
}

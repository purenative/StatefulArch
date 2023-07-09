//
// BasePageInterceptor.swift
// StatefulArch
//
// MIT License
//
// Copyright (c) 2022 Pure Native
//

import Foundation

@MainActor
public protocol BasePageInterceptor: AnyObject {
    
    associatedtype Action
    
    func call(action: Action)
    func notify(lifeCycleEvent: PageLifeCycleEvent)
    
}

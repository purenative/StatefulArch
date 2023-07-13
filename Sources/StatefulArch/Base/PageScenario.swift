//
// PageScenario.swift
// StatefulArch
//
// MIT License
//
// Copyright (c) 2022 Pure Native
//

import Foundation
import Combine

@MainActor
open class PageScenario {
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(serviceProvider: ServiceProvider) {
        provideServices(with: serviceProvider)
        bind()
        subscribe()
    }
    
    open func provideServices(with serviceProvider: ServiceProvider) {
        
    }
    
    open func bind() {
        
    }
    
    open func subscribe() {
        
    }
    
}

@MainActor
public extension PageScenario {
    
    func onChange<T>(_ publisher: Published<T>.Publisher, call action: @escaping () async -> Void) {
        publisher.receive(on: RunLoop.main)
            .sink { _ in
                Task {
                    await action()
                }
            }
            .store(in: &cancellables)
    }
    
    func onChange<T>(_ publisher: Published<T>.Publisher, call action: @escaping () -> Void) {
        publisher.receive(on: RunLoop.main)
            .sink { _ in
                action()
            }
            .store(in: &cancellables)
    }
    
    func onChange<T>(_ publisher: Published<T>.Publisher, call action: @escaping (T) async -> Void) {
        publisher.receive(on: RunLoop.main)
            .sink { newValue in
                Task {
                    await action(newValue)
                }
            }
            .store(in: &cancellables)
    }
    
    func onChange<T>(_ publisher: Published<T>.Publisher, call action: @escaping (T) -> Void) {
        publisher.receive(on: RunLoop.main)
            .sink { newValue in
                action(newValue)
            }
            .store(in: &cancellables)
    }
    
}

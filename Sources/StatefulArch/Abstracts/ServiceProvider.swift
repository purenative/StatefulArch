public protocol ServiceProvider {
    
    func provideService<T>() -> T
    
}

public extension ServiceProvider {
    
    func provide<T>(service: inout T) {
        let resolvedService: T = provideService()
        service = resolvedService
    }
    
    func provide<T>(service: inout Optional<T>) {
        let resolvedService: T = provideService()
        service = .some(resolvedService)
    }
    
}

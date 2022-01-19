public protocol ModuleBuilder {
    
    @MainActor
    func buildModule(serviceProvider: ServiceProvider) -> ModuleConvertible
    
}

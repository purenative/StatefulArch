@MainActor
public final class NavigationService {
    
    private(set) static var moduleAssembler: ModuleAssembler!
    
    private static var layers = [NavigationLayer]()
    
    public static func set(serviceProvider: ServiceProvider) {
        self.moduleAssembler = ModuleAssembler(serviceProvider: serviceProvider)
    }
    
    public static func push(using builder: ModuleBuilder) {
        try! throwServiceProviderNotInstalledError()
        
        let module = moduleAssembler.assemblyModule(using: builder)
        
        getTopLayer()?.push(module: module)
    }
    
    public static func pop(modules: Int = 1) {
        try! throwServiceProviderNotInstalledError()
        
        getTopLayer()?.pop(modules: modules)
    }
    
    public static func popToRootModule() {
        try! throwServiceProviderNotInstalledError()
        
        getTopLayer()?.popToRootModule()
    }
    
    public static func present(using builder: ModuleBuilder) {
        try! throwServiceProviderNotInstalledError()
        
        let module = moduleAssembler.assemblyModule(using: builder)
        getTopLayer()?.present(module: module)
        let newLayer = NavigationLayer(startModule: module)
        layers.append(newLayer)
    }
    
    public static func dismiss() {
        try! throwServiceProviderNotInstalledError()
        
        let layer = layers.removeLast()
        
        layer.dismissModule()
    }
    
    public static func setRoot(using builder: ModuleBuilder) {
        try! throwServiceProviderNotInstalledError()
        
        let module = moduleAssembler.assemblyModule(using: builder)
        
        let newLayer = NavigationLayer(startModule: module)
        layers.removeAll()
        layers.append(newLayer)
        
        RootView.rootViewController.change(rootModule: module)
    }
    
    private static func getTopLayer() -> NavigationLayer? {
        while let nextLayer = layers.last {
            if nextLayer.isInvalid {
                _ = layers.removeLast()
            } else {
                return layers.last
            }
        }
        
        return nil
    }
    
    private static func throwServiceProviderNotInstalledError() throws {
        if moduleAssembler == nil {
            throw NavigationServiceError.serviceProviderNotInstalled
        }
    }
    
}

public enum NavigationServiceError: Error {
    
    case serviceProviderNotInstalled
    
}

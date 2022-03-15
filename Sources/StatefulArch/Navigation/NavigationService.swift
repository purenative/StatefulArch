import Dispatch

@MainActor
public final class NavigationService {
    
    private(set) static var moduleAssembler: ModuleAssembler!
    
    public private(set) static var layers = [NavigationLayer]()
    
    public static func set(serviceProvider: ServiceProvider) {
        self.moduleAssembler = ModuleAssembler(serviceProvider: serviceProvider)
    }
    
    public static func push(using builder: ModuleBuilder) {
        try! throwServiceProviderNotInstalledError()
        
        let module = moduleAssembler.assemblyModule(using: builder)
        
        DispatchQueue.main.async {
            getTopLayer()?.push(module: module)
        }
    }
    
    public static func replace(using builder: ModuleBuilder) {
        try! throwServiceProviderNotInstalledError()
        
        let module = moduleAssembler.assemblyModule(using: builder)
        
        DispatchQueue.main.async {
            getTopLayer()?.replace(module: module)
        }
    }
    
    public static func replace(count: Int,
                               using builders: [ModuleBuilder]) {
        try! throwServiceProviderNotInstalledError()
        
        let modules = builders.map {
            moduleAssembler.assemblyModule(using: $0)
        }
        DispatchQueue.main.async {
            getTopLayer()?.replace(count: count,
                                   using: modules)
        }
    }
    
    public static func pop(modules: Int = 1) {
        try! throwServiceProviderNotInstalledError()
        
        DispatchQueue.main.async {
            getTopLayer()?.pop(modules: modules)
        }
    }
    
    public static func popToRootModule() {
        try! throwServiceProviderNotInstalledError()
        
        DispatchQueue.main.async {
            getTopLayer()?.popToRootModule()
        }
    }
    
    public static func present(using builder: ModuleBuilder) {
        try! throwServiceProviderNotInstalledError()
        
        DispatchQueue.main.async {
            let module = moduleAssembler.assemblyModule(using: builder)
            getTopLayer()?.present(module: module)
            let newLayer = NavigationLayer(startModule: module)
            layers.append(newLayer)
        }
    }
    
    public static func dismiss() {
        try! throwServiceProviderNotInstalledError()
        
        DispatchQueue.main.async {
            layers.removeLast().dismissModule()
        }
    }
    
    public static func setRoot(using builder: ModuleBuilder) {
        try! throwServiceProviderNotInstalledError()
        
        DispatchQueue.main.async {
            let module = moduleAssembler.assemblyModule(using: builder)
            
            let newLayer = NavigationLayer(startModule: module)
            layers.removeAll()
            layers.append(newLayer)
            
            RootView.rootViewController.change(rootModule: module)
        }
    }
    
    public static func custom(using builder: ModuleBuilder,
                              presentOn: @escaping (Module, Module) -> Void) {
        try! throwServiceProviderNotInstalledError()
        
        DispatchQueue.main.async {
            if let topModule = getTopLayer()?.startModule {
                let module = moduleAssembler.assemblyModule(using: builder)
                presentOn(module, topModule)
                let newLayer = NavigationLayer(startModule: module)
                layers.append(newLayer)
            }
        }
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

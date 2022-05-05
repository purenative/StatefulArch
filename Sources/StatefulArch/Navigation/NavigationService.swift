import Dispatch

@MainActor
public final class NavigationService {
    
    private(set) static var moduleAssembler: ModuleAssembler!
    
    public static func set(serviceProvider: ServiceProvider) {
        self.moduleAssembler = ModuleAssembler(serviceProvider: serviceProvider)
    }
    
    public static func push(using builder: ModuleBuilder,
                            animated: Bool = true) {
        
        use(navigation: PushNavigation(),
            with: builder,
            animated: animated)
    }
    
    public static func replace(using builder: ModuleBuilder,
                               animated: Bool = true) {
        
        use(navigation: ReplaceNavigation(),
            with: builder,
            animated: animated)
    }
    
    public static func pop(modules: Int = 1,
                           animated: Bool = true) {
        
        use(navigation: PopNavigation(count: modules),
            with: nil,
            animated: animated)
    }
    
    public static func popToRootModule(animated: Bool = true) {
        
        use(navigation: PopNavigation(count: .max),
            with: nil,
            animated: animated)
    }
    
    public static func present(using builder: ModuleBuilder,
                               animated: Bool = true) {
        
        use(navigation: PresentNavigation(),
            with: builder,
            animated: animated)
    }
    
    public static func dismiss(animated: Bool = true) {
        
        use(navigation: DismissNavigation(),
            with: nil,
            animated: animated)
    }
    
    public static func setRoot(using builder: ModuleBuilder) {
        
        use(navigation: RootNavigation(),
            with: builder,
            animated: true)
    }
    
    public static func use(navigation: Navigation,
                           with moduleBuilder: ModuleBuilder?,
                           animated: Bool) {
        
        try! throwServiceProviderNotInstalledError()
        
        DispatchQueue.main.async {
            if let moduleBuilder = moduleBuilder {
                let module = moduleAssembler.assemblyModule(using: moduleBuilder)
                navigation.navigate(module: module,
                                    in: RootView.rootViewController,
                                    animated: animated)
            } else {
                navigation.navigate(module: nil,
                                    in: RootView.rootViewController,
                                    animated: animated)
            }
        }
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

import Foundation

@MainActor
open class PageInterceptor<Action, State: ObservableObject>: BasePageInterceptor {
    
    public private(set) weak var state: State?

    public required init(state: State,
                         serviceProvider: ServiceProvider) {
        
        self.state = state
        
        provideServices(withServiceProvider: serviceProvider)
        
        var state = state
        subscribe(withState: &state)
    }
    
    open func subscribe(withState state: inout State) {
        
    }
    
    open func provideServices(withServiceProvider serviceProvider: ServiceProvider) {
        
    }
    
    public func call(action: Action) {
        Task {
            await handle(action: action)
        }
    }
    
    open func handle(action: Action) async {
        fatalError("Need to override 'handle(action: AssociatedAction)' for InterceptorTemplate")
    }
    
    public func notify(lifeCycleEvent: PageLifeCycleEvent) {
        Task {
            await handle(lifeCycleEvent: lifeCycleEvent)
        }
    }
    
    open func handle(lifeCycleEvent: PageLifeCycleEvent) async {
        
    }
    
    public func updateState(updating: @escaping (State) -> Void) {
        guard let state = state else {
            return
        }
        updating(state)
    }
    
}

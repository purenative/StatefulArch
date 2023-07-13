import Foundation

open class BasePageInterceptor<Action, State: PageState, LaunchInfo>: PageInterceptor {
    
    private weak var state: State?
    
    public required init() { }
    
    open func provideServices(withServiceProvider serviceProvider: ServiceProvider) { }
    
    open func bind(state: inout State) { }
    
    open func start(launchInfo: LaunchInfo) { }
    
    public func set(state: State) {
        self.state = state
        
        if var state = self.state {
            bind(state: &state)
        }
    }
    
    public func call(action: Action) {
        Task { [weak self] in
            if let state = self?.state {
                await self?.handle(action: action, state: state)
            }
        }
    }
    
    open func handle(action: Action, state: State) async {
        fatalError("Need to override '\(#function)' for PageInterceptor child")
    }
    
    public func notify(lifeCycleEvent: PageLifeCycleEvent) {
        Task { [weak self] in
            if let state = self?.state {
                await self?.handle(lifeCycleEvent: lifeCycleEvent, state: state)
            }
        }
    }
    
    open func handle(lifeCycleEvent: PageLifeCycleEvent, state: State) async { }
    
    public func updateState(updating: @escaping (State) -> Void) {
        if let state {
            updating(state)
        }
    }
    
}

import Combine

public protocol PageInterceptor: AnyObject {
    
    associatedtype LaunchInfo
    associatedtype State: PageState

    init()
    
    func set(state: State)
    
    func provideServices(withServiceProvider serviceProvider: ServiceProvider)
    
    func bind(state: inout State)
    
    func start(launchInfo: LaunchInfo)
    
    func notify(lifeCycleEvent: PageLifeCycleEvent)
    
}

@MainActor
public protocol BasePageInterceptor: AnyObject {
    
    associatedtype Action
    
    func call(action: Action)
    func notify(lifeCycleEvent: PageLifeCycleEvent)
    
}

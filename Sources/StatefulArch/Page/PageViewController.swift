import UIKit
import Combine

open class PageViewController<Action, State: ObservableObject>: UIViewController {
    
    var cancellables = Set<AnyCancellable>()
    
    public let state: State
    public let interceptor: PageInterceptor<Action, State>
    
    public init(state: State,
                interceptor: PageInterceptor<Action, State>) {
        
        self.state = state
        self.interceptor = interceptor
        
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        configureAppearence()
        bindViews()
    
        interceptor.notify(lifeCycleEvent: .didLoad)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interceptor.notify(lifeCycleEvent: .willAppear)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        interceptor.notify(lifeCycleEvent: .didAppear)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        interceptor.notify(lifeCycleEvent: .willDisappear)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        interceptor.notify(lifeCycleEvent: .didDisappear)
    }
    
    open func addViews() {
        
    }
    
    open func configureAppearence() {
        
    }
    
    open func bindViews() {
        
    }
    
}



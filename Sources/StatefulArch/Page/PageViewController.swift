import UIKit
import Combine

public class PageViewController<Action, State: PageState>: UIViewController {
    
    var cancellables = Set<AnyCancellable>()
    
    let state: State
    let interceptor: PageInterceptor<Action, State>
    
    public init(state: State,
                interceptor: PageInterceptor<Action, State>) {
        
        self.state = state
        self.interceptor = interceptor
        
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        configureAppearence()
        bindViews()
    
        interceptor.notify(lifeCycleEvent: .didLoad)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interceptor.notify(lifeCycleEvent: .willAppear)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        interceptor.notify(lifeCycleEvent: .didAppear)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        interceptor.notify(lifeCycleEvent: .willDisappear)
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
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



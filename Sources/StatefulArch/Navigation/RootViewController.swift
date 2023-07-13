import UIKit

public class RootViewController: UIViewController {
    
    private var currentRootModule: Module?
    
    func change(rootModule: Module) {
        currentRootModule?.view?.removeFromSuperview()
        currentRootModule?.removeFromParent()
        
        currentRootModule = rootModule
        
        addChild(rootModule)
        view.addSubview(rootModule.view)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentRootModule?.viewWillAppear(animated)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currentRootModule?.viewDidAppear(animated)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        currentRootModule?.viewWillDisappear(animated)
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        currentRootModule?.viewDidDisappear(animated)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        currentRootModule?.view.frame = view.bounds
    }
    
    public func getVisibleViewController() -> UIViewController {
        visibleController(from: self)
    }
    
}

private extension RootViewController {
    
    func visibleController(from controller: UIViewController) -> UIViewController {
        
        switch controller {
        case let navigationController as UINavigationController:
            return visibleController(from: navigationController.visibleViewController!)
            
        case let tabBarController as UITabBarController:
            return visibleController(from: tabBarController.selectedViewController!)
            
        default:
            if let presentedViewController = controller.presentedViewController {
                return visibleController(from: presentedViewController)
            }
            
            if let tabBarController = controller.children.first(where: { $0 is UITabBarController }) {
                return visibleController(from: tabBarController)
            }
            
            if let navigationController = controller.children.first(where: { $0 is UINavigationController }) {
                return visibleController(from: navigationController)
            }
            
            return controller
        }
        
    }
    
}

import UIKit
import SwiftUI

public class RootViewController: UIViewController {
    
    private var currentRootModule: Module!
    
    func change(rootModule: Module) {
        currentRootModule?.view?.removeFromSuperview()
        currentRootModule?.removeFromParent()
        
        currentRootModule = rootModule
        
        addChild(rootModule)
        view.addSubview(rootModule.view)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        currentRootModule?.view.frame = view.bounds
    }
    
    public func getVisibleViewController() -> UIViewController {
        visibleController(from: self)
    }
    
    private func visibleController(from controller: UIViewController) -> UIViewController {
        
        if let navigationController = controller as? UINavigationController {
            
            return visibleController(from: navigationController.visibleViewController!)

        } else if let tabBarController = controller as? UITabBarController {
            
            return visibleController(from: tabBarController.selectedViewController!)
            
        } else {

            if let presentedViewController = controller.presentedViewController {

                return visibleController(from: presentedViewController)

            } else if !controller.children.isEmpty {
                
                if let tabBarController = controller.children.compactMap({ $0 as? UITabBarController }).first {
                    return visibleController(from: tabBarController.selectedViewController!)
                }
                
                if let navigationController = controller.children.compactMap({ $0 as? UINavigationController }).first {
                    return visibleController(from: navigationController.visibleViewController!)
                }
                
            }
            
            return controller
        }
        
    }

}

public struct RootView: UIViewControllerRepresentable {
    
    static let rootViewController = RootViewController()
    
    public init() {
        
    }
    
    public func makeUIViewController(context: Context) -> RootViewController {
        RootView.rootViewController
    }
    
    public func updateUIViewController(_ rootViewController: RootViewController,
                                       context: Context) {
        
    }
    
}

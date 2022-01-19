import UIKit

struct NavigationLayer {
    weak var startModule: Module?
    
    var isInvalid: Bool {
        startModule == nil
    }
}

extension NavigationLayer {
    
    private var navigationController: UINavigationController? {
        startModule as? UINavigationController
    }
    
    func push(module: Module) {
        navigationController?.pushViewController(module,
                                                 animated: true)
    }
    
    func pop(modules: Int = 1) {
        guard let viewControllers = navigationController?.viewControllers else {
            return
        }
        
        let count = viewControllers.count
        
        guard count > 0 else {
            return
        }
        
        let targetIndex = max(0, count - modules - 1)
        let targetViewController = viewControllers[targetIndex]
        
        navigationController?.popToViewController(targetViewController,
                                                  animated: true)
    }
    
    func popToRootModule() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}

extension NavigationLayer {
    
    private var tabBarController: UITabBarController? {
        startModule as? UITabBarController
    }
    
    func changeModuleTab(_ tabIndex: Int) {
        tabBarController?.selectedIndex = tabIndex
    }
    
}

extension NavigationLayer {
    
    func present(module: Module) {
        startModule?.present(module,
                             animated: true)
    }
    
    func dismissModule() {
        startModule?.dismiss(animated: true)
    }
    
}

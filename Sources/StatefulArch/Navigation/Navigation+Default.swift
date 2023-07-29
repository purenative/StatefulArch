//
// Navigation+Default.swift
// StatefulArch
//
// MIT License
//
// Copyright (c) 2022 Pure Native
//

import Foundation
import UIKit

public final class RootNavigation: Navigation {
    
    public func navigate(module: Module?, in rootViewController: RootViewController, animated: Bool) {
        guard let module = module else {
            return
        }
        rootViewController.change(rootModule: module)
    }
    
}

public extension NavigationService {
    
    static func setRoot(using builder: ModuleBuilder) {
        use(
            navigation: RootNavigation(),
            with: builder,
            animated: true
        )
    }
    
}

public final class PushNavigation: Navigation {
    
    public func navigate(module: Module?, in rootViewController: RootViewController, animated: Bool) {
        guard let module = module else {
            return
        }
        getVisibleNavigationController(in: rootViewController)?.pushViewController(module, animated: animated)
    }
    
}

public extension NavigationService {
    
    static func push(using builder: ModuleBuilder, animated: Bool = true) {
        use(
            navigation: PushNavigation(),
            with: builder,
            animated: animated
        )
    }
    
}

public final class PopNavigation: Navigation {
    
    let count: Int
    
    init(count: Int = 1) {
        self.count = count
    }
    
    public func navigate(module: Module?, in rootViewController: RootViewController, animated: Bool) {
        guard let navigationController = getVisibleNavigationController(in: rootViewController) else {
            return
        }
        
        switch count {
        case 1:
            navigationController.popViewController(animated: animated)
            
        case .max:
            navigationController.popToRootViewController(animated: animated)
            
        default:
            guard navigationController.viewControllers.count > 0 else {
                return
            }
            let targetIndex = max(0, navigationController.viewControllers.count - count - 1)
            let targetViewController = navigationController.viewControllers[targetIndex]
            navigationController.popToViewController(targetViewController, animated: animated)
        }
    }
    
}

public extension NavigationService {
    
    static func pop(modules: Int = 1, animated: Bool = true) {
        use(
            navigation: PopNavigation(count: modules),
            with: nil,
            animated: animated
        )
    }
    
    static func popToRootModule(animated: Bool = true) {
        use(
            navigation: PopNavigation(count: .max),
            with: nil,
            animated: animated
        )
    }
    
}

final class ReplaceNavigation: Navigation {
    
    func navigate(module: Module?, in rootViewController: RootViewController, animated: Bool) {
        guard let module = module else {
            return
        }
        guard let navigationController = getVisibleNavigationController(in: rootViewController) else {
            return
        }
        var viewControllers = navigationController.viewControllers
        viewControllers.removeLast()
        viewControllers.append(module)
        navigationController.setViewControllers(viewControllers, animated: animated)
    }
    
}

public extension NavigationService {
    
    static func replace(using builder: ModuleBuilder, animated: Bool = true) {
        use(
            navigation: ReplaceNavigation(),
            with: builder,
            animated: animated
        )
    }
    
}

final class PresentNavigation: Navigation {
    
    func navigate(module: Module?, in rootViewController: RootViewController, animated: Bool) {
        guard let module = module else {
            return
        }
        let visibleController = rootViewController.getVisibleViewController()
        visibleController.present(module, animated: animated, completion: nil)
    }
    
}

public extension NavigationService {
    
    static func present(using builder: ModuleBuilder, animated: Bool = true) {
        use(
            navigation: PresentNavigation(),
            with: builder,
            animated: animated
        )
    }
    
}

final class DismissNavigation: Navigation {
 
    func navigate(module: Module?, in rootViewController: RootViewController, animated: Bool) {
        let visibleController = rootViewController.getVisibleViewController()
        
        rootViewController.viewWillAppear(animated)
        
        visibleController.dismiss(animated: animated) {
            rootViewController.viewDidAppear(animated)
        }
    }
    
}

public extension NavigationService {
    
    static func dismiss(animated: Bool = true) {
        use(
            navigation: DismissNavigation(),
            with: nil,
            animated: animated
        )
    }
    
}

final class SelectTabNavigation: Navigation {
    
    let selectedIndex: Int
    
    init(selectedIndex: Int) {
        self.selectedIndex = selectedIndex
    }
    
    func navigate(module: Module?, in rootViewController: RootViewController, animated: Bool) {
        getVisibleTabBarController(in: rootViewController)?.selectedIndex = selectedIndex
    }
    
}

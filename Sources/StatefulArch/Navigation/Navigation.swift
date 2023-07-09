//
// Navigation.swift
// StatefulArch
//
// MIT License
//
// Copyright (c) 2022 Pure Native
//

import Foundation
import UIKit

public protocol Navigation {
    
    func navigate(module: Module?, in rootViewController: RootViewController, animated: Bool)
    
}

public extension Navigation {
    
    func getVisibleNavigationController(in rootViewController: RootViewController) -> UINavigationController? {
        let visibleViewController = rootViewController.getVisibleViewController()
        return visibleViewController as? UINavigationController ?? visibleViewController.navigationController
    }
    
    func getVisibleTabBarController(in rootViewController: RootViewController) -> UITabBarController? {
        let visibleViewController = rootViewController.getVisibleViewController()
        return visibleViewController as? UITabBarController ?? visibleViewController.tabBarController ?? visibleViewController.navigationController?.tabBarController
    }
    
}


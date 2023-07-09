//
// Module+ModuleConvertible.swift
// StatefulArch
//
// MIT License
//
// Copyright (c) 2022 Pure Native
//

import Foundation
import UIKit
import SwiftUI
import Combine

public protocol Module: UIViewController {

}

public protocol ModuleConvertible {
    
    func asModule() -> Module
    
}

extension UIViewController: Module, ModuleConvertible {
    
    public func asModule() -> Module {
        self
    }
    
}

public extension PageView where Interceptor: BasePageInterceptor {
    
    func asModule(modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
                  modalPresentationStyle: UIModalPresentationStyle = .overFullScreen,
                  statusBarStyle: UIStatusBarStyle = .default,
                  hidesBottomBarWhenPushed: Bool = false) -> Module {
        
        let controller = PageViewHostingController(rootView: self)
        
        controller.modalTransitionStyle = modalTransitionStyle
        controller.modalPresentationStyle = modalPresentationStyle
        controller.modalPresentationCapturesStatusBarAppearance = true
        controller.statusBarStyle = statusBarStyle
        controller.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        
        return controller
    }
    
}

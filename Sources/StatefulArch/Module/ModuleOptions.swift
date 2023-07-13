//
// ModuleOptions.swift
// StatefulArch
//
// MIT License
//
// Copyright (c) 2022 Pure Native
//

import Foundation
import UIKit

public struct ModuleOptions {
    
    let modalTransitionStyle: UIModalTransitionStyle
    let modalPresentationStyle: UIModalPresentationStyle
    let statusBarStyle: UIStatusBarStyle
    let hidesBottomBarWhenPushed: Bool
    
    public init(modalTransitionStyle: UIModalTransitionStyle = .coverVertical, modalPresentationStyle: UIModalPresentationStyle = .automatic, statusBarStyle: UIStatusBarStyle = .lightContent, hidesBottomBarWhenPushed: Bool = false) {
        self.modalTransitionStyle = modalTransitionStyle
        self.modalPresentationStyle = modalPresentationStyle
        self.statusBarStyle = statusBarStyle
        self.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
    }
    
    static let `default` = ModuleOptions()
    
}

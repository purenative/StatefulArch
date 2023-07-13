import UIKit
import SwiftUI

public protocol Module: UIViewController { }

public protocol ModuleConvertible {
    
    func asModule(withOptions moduleOptions: ModuleOptions) -> Module
    
}

public extension ModuleConvertible {
    
    func asModule() -> Module {
        asModule(withOptions: .default)
    }
    
}

extension UIViewController: Module, ModuleConvertible {
    
    public func asModule(withOptions moduleOptions: ModuleOptions) -> Module {
        self.modalTransitionStyle = moduleOptions.modalTransitionStyle
        self.modalPresentationStyle = moduleOptions.modalPresentationStyle
        self.hidesBottomBarWhenPushed = moduleOptions.hidesBottomBarWhenPushed
        return self
    }
    
}

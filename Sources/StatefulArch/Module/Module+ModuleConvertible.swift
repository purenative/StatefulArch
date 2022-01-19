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
    
    func asModule() -> Module {
        PageViewHostingController(rootView: self)
    }
    
}

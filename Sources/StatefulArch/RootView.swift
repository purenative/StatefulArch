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

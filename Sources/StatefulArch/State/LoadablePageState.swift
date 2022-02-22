import SwiftUI

@available(iOS 14.5, *)
open class LoadablePageState: PageState {
    
    @Published
    public var loading = false
    
}

@available(iOS 14.5, *)
public extension LoadablePageState {
    
    func startLoading() {
        loading = true
    }
    
    func stopLoading() {
        loading = false
    }
    
}

import SwiftUI

open class LoadablePageState: PageState {
    
    @Published
    public var loading = false
    
}

public extension LoadablePageState {
    
    func startLoading() {
        loading = true
    }
    
    func stopLoading() {
        loading = false
    }
    
}

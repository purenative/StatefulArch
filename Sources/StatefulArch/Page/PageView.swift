import SwiftUI

public protocol PageView: View {
    
    associatedtype State
    associatedtype Interceptor
    
    var interceptor: Interceptor { get }
    
    init(state: State,
         interceptor: Interceptor)
    
}

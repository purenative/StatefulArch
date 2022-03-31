import UIKit

open class CustomModule<Result>: NSObject, CustomModuleConvertible {
    
    deinit {
        #if DEBUG
        print("CustomModule deinited")
        #endif
    }
        
    private var viewController: UIViewController?
    
    public func setViewController(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    private var continuation: CheckedContinuation<Result, Error>!

    private func setContinuation(_ continuation: CheckedContinuation<Result, Error>) {
        self.continuation = continuation
    }
    
    public func asModule() -> Module {
        guard let viewController = viewController else {
            fatalError("CustomModule needs to implement " + #function)
        }
        return viewController
    }
    
    public func waitResult() async throws -> Result {
        try await withCheckedThrowingContinuation { [weak self] in
            self?.setContinuation($0)
            self?.startProcess()
        }
    }
    
    
    // Override if needed additional actions on start
    open func startProcess() {
        
    }
    
    public func completeWithResult(_ result: Result) {
        continuation?.resume(returning: result)
    }
    
    public func completeWithError(_ error: Error) {
        continuation?.resume(throwing: error)
    }
    
}

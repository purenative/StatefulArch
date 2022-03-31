public protocol CustomModuleConvertible: ModuleConvertible {
    
    associatedtype Result = Void
    func waitResult() async throws -> Result
    
}

public extension CustomModuleConvertible where Result == Void {
    
    func waitResult() async throws -> Result {
        ()
    }
    
}

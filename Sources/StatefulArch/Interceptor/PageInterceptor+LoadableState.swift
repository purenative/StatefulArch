public extension PageInterceptor where State: LoadablePageState {
    
    func runLoadable(action: (State) async -> Void) async {
        guard let state = self.state, !state.loading else {
            return
        }
        
        state.startLoading()
        await action(state)
        state.stopLoading()
    }
    
    func runLoadable(action: () async -> Void) async {
        guard let state = self.state, !state.loading else {
            return
        }
        
        state.startLoading()
        await action()
        state.stopLoading()
    }
    
}

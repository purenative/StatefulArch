//
// PageViewHostingController.swift
// StatefulArch
//
// MIT License
//
// Copyright (c) 2022 Pure Native
//

import Foundation
import SwiftUI

public class PageViewHostingController<Page: PageView, Interceptor: BasePageInterceptor>:
    UIHostingController<Page> where Interceptor == Page.Interceptor {
    
    private weak var interceptor: Interceptor?
    
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        statusBarStyle
    }
    
    override init(rootView: Page) {
        super.init(rootView: rootView)
        
        interceptor = rootView.interceptor
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        interceptor?.notify(lifeCycleEvent: .didLoad)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interceptor?.notify(lifeCycleEvent: .willAppear)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        interceptor?.notify(lifeCycleEvent: .didAppear)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        interceptor?.notify(lifeCycleEvent: .willDisappear)
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        interceptor?.notify(lifeCycleEvent: .didDisappear)
    }
}

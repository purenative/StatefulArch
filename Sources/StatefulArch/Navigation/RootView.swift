//
// RootView.swift
// StatefulArch
//
// MIT License
//
// Copyright (c) 2022 Pure Native
//

import Foundation
import UIKit
import SwiftUI

public struct RootView: UIViewControllerRepresentable {
    
    static let rootViewController = RootViewController()
    
    public init() { }
    
    public func makeUIViewController(context: Context) -> RootViewController {
        RootView.rootViewController
    }
    
    public func updateUIViewController(_ rootViewController: RootViewController, context: Context) { }
    
}

//
// PageViewController+Bindings.swift
// StatefulArch
//
// MIT License
//
// Copyright (c) 2022 Pure Native
//

import Foundation
import UIKit

public extension PageViewController {
    
    func bind(_ stringPublisher: Published<String>.Publisher,
              to label: UILabel) {
        
        stringPublisher.bindText(to: label)
            .store(in: &cancellables)
    }
    
}

//
// Binding+PublishedString.swift
// StatefulArch
//
// MIT License
//
// Copyright (c) 2022 Pure Native
//

import Foundation
import UIKit
import Combine

extension Publisher where Output == String {
    
    func bindText(to label: UILabel) -> AnyCancellable {
        removeDuplicates()
            .sink { _ in
                
            } receiveValue: { [weak label] newValue in
                DispatchQueue.main.async {
                    label?.text = newValue
                }
            }
    }
    
}

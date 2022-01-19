import UIKit

public extension PageViewController {
    
    func bind(_ stringPublisher: Published<String>.Publisher,
              to label: UILabel) {
        
        stringPublisher.bindText(to: label)
            .store(in: &cancellables)
    }
    
}

import UIKit

public extension PageViewController {
    
    func bind(_ stringPublisher: Published<String>.Publisher, to label: UILabel) {
        stringPublisher.sink { [weak label] newString in
            label?.text = newString
        }
        .store(in: &cancellables)
    }
    
}

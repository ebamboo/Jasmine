//
//  ObservedTextView.swift
//  Jasmine
//
//  Created by ebamboo on 2023/11/3.
//

import UIKit

open class ObservedTextView: UITextView {
    
    var onDidSetText: ((ObservedTextView) -> Void)?
    
    var onTextChanged: ((ObservedTextView) -> Void)? {
        didSet {
            if let observation = observation {
                NotificationCenter.default.removeObserver(observation)
            }
            observation = NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification,
                                                              object: nil,
                                                              queue: .main) { [weak self] notification in
                guard let strongself = self else { return }
                if notification.object as? ObservedTextView === strongself {
                    strongself.onTextChanged?(strongself)
                }
            }
        }
    }
    
    open override var text: String? {
        didSet {
            onDidSetText?(self)
            onTextChanged?(self)
        }
    }
    
    private weak var observation: NSObjectProtocol?
    deinit {
        if let observation = observation {
            NotificationCenter.default.removeObserver(observation)
        }
    }
    
}

//
//  ObservedTextField.swift
//  Jasmine
//
//  Created by ebamboo on 2023/11/3.
//

import UIKit

open class ObservedTextField: UITextField {
    
    var onDidSetText: ((ObservedTextField) -> Void)?
    
    var onTextChanged: ((ObservedTextField) -> Void)? {
        didSet {
            addTarget(self, action: #selector(editingChangedAction), for: .editingChanged)
        }
    }
    
    open override var text: String? {
        didSet {
            onDidSetText?(self)
            onTextChanged?(self)
        }
    }
    
    @objc
    private func editingChangedAction() {
        onTextChanged?(self)
    }
    
}

//
//  ObservedTextField.swift
//  Jasmine
//
//  Created by ebamboo on 2023/11/3.
//

import UIKit

open class ObservedTextField: UITextField {
    
    /// setter
    var onDidSetText: ((ObservedTextField) -> Void)?
    
    /// editing changed
    var onEditingChanged: ((ObservedTextField) -> Void)? {
        didSet {
            addTarget(self, action: #selector(editingChangedAction), for: .editingChanged)
        }
    }
    
    /// setter or editing changed
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
        onEditingChanged?(self)
        onTextChanged?(self)
    }
    
}

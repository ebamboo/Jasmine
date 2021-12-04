//
//  Stepper.swift
//  Jasmine
//
//  Created by ebamboo on 2021/12/3.
//

import UIKit

///
/// 该控件是下单时购买商品数量编辑控件
///
/// 可以通过加减按钮修改数量，也可以通过输入修改数量
/// 临近 [minValue, maxValue] 边界时对应边界的按钮不可用
/// 数量通过按钮和输入变化时会进行回调
/// 输入方式对内容进行了限定：输入结果只能是 [minValue, maxValue] 的数字
///
public class Stepper: UIView, UITextFieldDelegate {
    
    // MARK: - public
    
    ///
    /// 布局设置
    ///
    @IBInspectable var itemSpacing: CGFloat = 8
    @IBInspectable var crementSize: CGSize = CGSize(width: 22, height: 22)
    @IBInspectable var decrementNormalImage: UIImage? {
        get {
            decrementBtn.image(for: .normal)
        }
        set {
            decrementBtn.setImage(newValue, for: .normal)
        }
    }
    @IBInspectable var decrementDisableImage: UIImage? {
        get {
            decrementBtn.image(for: .disabled)
        }
        set {
            decrementBtn.setImage(newValue, for: .disabled)
        }
    }
    @IBInspectable var incrementNormalImage: UIImage? {
        get {
            incrementBtn.image(for: .normal)
        }
        set {
            incrementBtn.setImage(newValue, for: .normal)
        }
    }
    @IBInspectable var incrementDisableImage: UIImage? {
        get {
            incrementBtn.image(for: .disabled)
        }
        set {
            incrementBtn.setImage(newValue, for: .disabled)
        }
    }
    
    ///
    /// 值变化回调
    ///
    private var valueDidChangeHandler: ((_ value: Int) -> Void)?
    func valueDidChangeHandler(handler: @escaping ((_ value: Int) -> Void)) {
        valueDidChangeHandler = handler
    }
    
    /// 是否可以输入修改数量，默认可以编辑
    @IBInspectable var inputable: Bool {
        get {
            return valueField.isEnabled
        }
        set {
            valueField.isEnabled = newValue
        }
    }
    
    ///
    /// 核心功能
    ///
    @IBInspectable var minValue: Int = 1 {
        didSet {
            if value < minValue {
                value = minValue
            }
        }
    }
    @IBInspectable var maxValue: Int = 99 {
        didSet {
            if value > maxValue {
                value = maxValue
            }
        }
    }
    var value: Int {
        get {
            let numberString = valueField.text! as NSString
            return numberString.integerValue
        }
        set {
            var tempValue = newValue
            if newValue < minValue {
                tempValue = minValue
            }
            if newValue > maxValue {
                tempValue = maxValue
            }
            valueField.text = "\(tempValue)"
            decrementBtn.isEnabled = tempValue > minValue
            incrementBtn.isEnabled = tempValue < maxValue
        }
    }
    
    // MARK: - life circle
    
    private var decrementBtn: UIButton!
    private var incrementBtn: UIButton!
    private var valueField: UITextField!
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        decrementBtn = UIButton(type: .custom)
        decrementBtn.addTarget(self, action: #selector(decrementAction), for: .touchUpInside)
        addSubview(decrementBtn)
        incrementBtn = UIButton(type: .custom)
        incrementBtn.addTarget(self, action: #selector(incrementAction), for: .touchUpInside)
        addSubview(incrementBtn)
        valueField = UITextField()
        valueField.delegate = self
        valueField.textAlignment = .center
        valueField.keyboardType = .numberPad
        addSubview(valueField)
        value = minValue 
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        decrementBtn.frame = CGRect(x: 0, y: 0, width: crementSize.width, height: crementSize.height)
        decrementBtn.center = CGPoint(x: itemSpacing + crementSize.width / 2, y: bounds.size.height / 2)
        incrementBtn.frame = CGRect(x: 0, y: 0, width: crementSize.width, height: crementSize.height)
        incrementBtn.center = CGPoint(x: bounds.size.width - itemSpacing - crementSize.width / 2, y: bounds.size.height / 2)
        valueField.frame = CGRect(
            x: itemSpacing + crementSize.width + itemSpacing,
            y: 0,
            width: bounds.size.width - (itemSpacing + crementSize.width + itemSpacing) * 2,
            height: bounds.size.height
        )
    }
    
    // MARK: - 值变化处理
    
    @objc private func decrementAction() {
        value -= 1
        valueDidChangeHandler?(value)
    }
    
    @objc private func incrementAction() {
        value += 1
        valueDidChangeHandler?(value)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let willString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
        // 是否是数字
        let rules = "^[0-9]+$"
        let predicate = NSPredicate(format: "SELF matches %@", rules)
        guard predicate.evaluate(with: willString) else { return false }
        // 是否在 [minValue, maxValue] 范围
        let number = willString.integerValue
        guard minValue <= number, number <= maxValue else { return false}
        // "输入"合法，允许本次输入并回调值变化
        // 通过修改 value 值来修改 textField 值，因为其中控制了加减按钮的可用属性
        // 所以返回 true/false 不影响
        value = number
        valueDidChangeHandler?(number)
        return false
    }
    
}

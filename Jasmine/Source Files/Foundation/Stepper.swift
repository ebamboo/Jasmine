//
//  Stepper.swift
//  Jasmine
//
//  Created by ebamboo on 2021/12/3.
//

import UIKit

///
/// 数量编辑控件
///
/// 注意：
/// 设置 value、minValue、maxValue 时，内部已保证 minValue 小于等于 value，value  小于等于 maxValue。
/// 具体规则和实现请查看相关属性 didset 方法
///
public class Stepper: UIView {
    
    // MARK: - 布局属性
    
    /// decrementBtn--valueLabel--incrementBtn 之间间距
    @IBInspectable var itemSpacing: CGFloat = 8 {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    /// decrementBtn 和 incrementBtn 的尺寸
    @IBInspectable var crementSize: CGSize = CGSize(width: 22, height: 22) {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    /// decrementBtn 可用状态图片
    @IBInspectable var decrementNormalImage: UIImage? = nil {
        didSet {
            decrementBtn.setImage(decrementNormalImage, for: .normal)
        }
    }
    
    /// decrementBtn 禁用状态图片
    @IBInspectable var decrementDisableImage: UIImage? = nil {
        didSet {
            decrementBtn.setImage(decrementDisableImage, for: .disabled)
        }
    }
    
    /// incrementBtn 可用状态图片
    @IBInspectable var incrementNormalImage: UIImage? = nil {
        didSet {
            incrementBtn.setImage(incrementNormalImage, for: .normal)
        }
    }
    
    /// incrementBtn 禁用状态图片
    @IBInspectable var incrementDisableImage: UIImage? = nil {
        didSet {
            incrementBtn.setImage(incrementDisableImage, for: .disabled)
        }
    }
    
    // MARK: - 控制属性
    
    /// value == minValue 时，是否禁用 decrementBtn
    @IBInspectable var disableWhenMin: Bool = true {
        didSet {
            value += 0
        }
    }
    
    /// value == maxValue 时，是否禁用 incrementBtn
    @IBInspectable var disableWhenMax: Bool = true {
        didSet {
            value += 0
        }
    }
    
    // MARK: - 响应事件
    
    ///
    /// disableWhenMin == false 且 value == minValue ，点击 decrementBtn 时调用
    ///
    var onClickDecrementWhenMin: ((_ value: Int) -> Void)?
    func onClickDecrementWhenMin(handler: @escaping ((_ value: Int) -> Void)) {
        onClickDecrementWhenMin = handler
    }
    
    ///
    /// disableWhenMax == false 且 value == maxValue ，点击 incrementBtn 时调用
    ///
    var onClickIncrementWhenMax: ((_ value: Int) -> Void)?
    func onClickIncrementWhenMax(handler: @escaping ((_ value: Int) -> Void)) {
        onClickIncrementWhenMax = handler
    }
    
    ///
    /// 通过按钮修改 value 时响应事件
    /// minValue 小于 value 且 value 小于 maxValue，点击 decrementBtn 或者 incrementBtn 时调用
    ///
    var onValueDidChangeHandler: ((_ value: Int) -> Void)?
    func onValueDidChangeHandler(handler: @escaping ((_ value: Int) -> Void)) {
        onValueDidChangeHandler = handler
    }

    // MARK: - 核心功能
    
    @IBInspectable var minValue: Int = 0 {
        didSet {
            if minValue > maxValue {
                maxValue = minValue
            }
            if minValue > value {
                value = minValue
            }
            if disableWhenMin {
                decrementBtn.isEnabled = value > minValue
            } else {
                decrementBtn.isEnabled = true
            }
            if disableWhenMax {
                incrementBtn.isEnabled = value < maxValue
            } else {
                incrementBtn.isEnabled = true
            }
            valueLabel.text = "\(value)"
        }
    }
    
    @IBInspectable var maxValue: Int = 99 {
        didSet {
            if maxValue < minValue {
                minValue = maxValue
            }
            if maxValue < value {
                value = maxValue
            }
            if disableWhenMin {
                decrementBtn.isEnabled = value > minValue
            } else {
                decrementBtn.isEnabled = true
            }
            if disableWhenMax {
                incrementBtn.isEnabled = value < maxValue
            } else {
                incrementBtn.isEnabled = true
            }
            valueLabel.text = "\(value)"
        }
    }
    
    @IBInspectable var value: Int = 1 {
        didSet {
            if value < minValue {
                minValue = value
            }
            if value > maxValue {
                maxValue = value
            }
            if disableWhenMin {
                decrementBtn.isEnabled = value > minValue
            } else {
                decrementBtn.isEnabled = true
            }
            if disableWhenMax {
                incrementBtn.isEnabled = value < maxValue
            } else {
                incrementBtn.isEnabled = true
            }
            valueLabel.text = "\(value)"
        }
    }
    
    // MARK: - 私有属性
    
    private lazy var decrementBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(decrementNormalImage, for: .normal)
        btn.setImage(decrementDisableImage, for: .disabled)
        btn.addTarget(self, action: #selector(decrementAction), for: .touchUpInside)
        addSubview(btn)
        return btn
    }()
    
    private lazy var incrementBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(incrementNormalImage, for: .normal)
        btn.setImage(incrementDisableImage, for: .disabled)
        btn.addTarget(self, action: #selector(incrementAction), for: .touchUpInside)
        addSubview(btn)
        return btn
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.text = "\(value)"
        label.textAlignment = .center
        addSubview(label)
        return label
    }()
    
}

public extension Stepper {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        decrementBtn.frame = CGRect(x: 0, y: 0, width: crementSize.width, height: crementSize.height)
        decrementBtn.center = CGPoint(x: itemSpacing + crementSize.width / 2, y: bounds.size.height / 2)
        incrementBtn.frame = CGRect(x: 0, y: 0, width: crementSize.width, height: crementSize.height)
        incrementBtn.center = CGPoint(x: bounds.size.width - itemSpacing - crementSize.width / 2, y: bounds.size.height / 2)
        valueLabel.frame = CGRect(
            x: itemSpacing + crementSize.width + itemSpacing,
            y: 0,
            width: bounds.size.width - (itemSpacing + crementSize.width + itemSpacing) * 2,
            height: bounds.size.height
        )
    }
    
    @objc private func decrementAction() {
        if value > minValue {
            value -= 1
            onValueDidChangeHandler?(value)
        } else { // 说明 disableWhenMin == false 且 value == minValue
            onClickDecrementWhenMin?(value)
        }
    }
    
    @objc private func incrementAction() {
        if value < maxValue {
            value += 1
            onValueDidChangeHandler?(value)
        } else { // 说明 disableWhenMax == false 且 value == maxValue
            onClickIncrementWhenMax?(value)
        }
    }
    
}

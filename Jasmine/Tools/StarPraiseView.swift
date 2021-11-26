//
//  StarPraiseView.swift
//  Jasmine
//
//  Created by ebamboo on 2021/11/24.
//

import UIKit

/// 通过 ⭐️ 来评分或展示评分
public class StarPraiseView: UIStackView {
    
    ///
    /// 未评分 ⭐️ 图片和已评分 ⭐️ 图片
    ///
    @IBInspectable var unseletedImage: UIImage? {
        didSet {
            arrangedSubviews.forEach { star in
                (star as! UIButton).setImage(unseletedImage, for: .normal)
            }
        }
    }
    @IBInspectable var seletedImage: UIImage? {
        didSet {
            arrangedSubviews.forEach { star in
                (star as! UIButton).setImage(seletedImage, for: .selected)
            }
        }
    }

    ///
    /// 评分最大值范围为：[1, 100]
    ///
    @IBInspectable var maxValue: Int {
        get {
            return storeMaxValue
        }
        set {
            guard newValue != storeMaxValue, 1 <= newValue, newValue <= 100 else { return }
            storeMaxValue = newValue
            value = value // 每次修改 maxValue 都必须刷新 value 值
        }
    }
    private var storeMaxValue = 5 {
        didSet {
            if storeMaxValue > oldValue {
                let add = storeMaxValue - oldValue
                (1...add).forEach { _ in
                    let star = UIButton(type: .custom)
                    star.setImage(unseletedImage, for: .normal)
                    star.setImage(seletedImage, for: .selected)
                    star.isUserInteractionEnabled = false
                    addArrangedSubview(star)
                }
                return
            }
            if storeMaxValue < oldValue {
                let remove = oldValue - storeMaxValue
                (1...remove).forEach { _ in
                    let star = arrangedSubviews.last!
                    removeArrangedSubview(star)
                    star.removeFromSuperview()
                }
            }
        }
    }
    
    ///
    /// 当前评分值范围为：[0, maxValue]
    /// 0 表示还没有评分
    ///
    @IBInspectable var value: Int {
        get {
            return storeValue
        }
        set {
            // 必须要纠正一些异常数据，如果不处理异常数据保持当前
            // 数值可能会出错。比如修改 maxValue 为一个更小值时
            // 可能会出现当前 value 比 maxValue 大
            var tempValue = newValue
            if newValue < 0 { tempValue = 0 }
            if newValue > maxValue { tempValue = maxValue }
            storeValue = tempValue
        }
    }
    private var storeValue = 0 {
        didSet {
            arrangedSubviews.forEach { star in
                let starIndex = arrangedSubviews.firstIndex(of: star)!
                (star as! UIButton).isSelected = starIndex < storeValue
            }
        }
    }
    
    ///
    /// 评分值变化时的回调
    /// 通过 setter 修改评分值不会回调
    ///
    private var valueDidChangedHandler: ((_ value: Int) -> Void)?
    func valueDidChangedHandler(handler: @escaping (_ value: Int) -> Void) {
        valueDidChangedHandler = handler
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        axis = .horizontal
        distribution = .fillEqually
        spacing = CGFloat.leastNormalMagnitude
        
        (1...maxValue).forEach { _ in
            let star = UIButton(type: .custom)
            star.setImage(unseletedImage, for: .normal)
            star.setImage(seletedImage, for: .selected)
            star.isUserInteractionEnabled = false
            addArrangedSubview(star)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(gestureAction(_:)))
        addGestureRecognizer(tap)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(gestureAction(_:)))
        addGestureRecognizer(pan)
    }
    
    @objc private func gestureAction(_ gesture: UIGestureRecognizer) {
        var selectedStar: UIButton?
        for star in arrangedSubviews {
            if star.bounds.contains(gesture.location(in: star)) {
                selectedStar = star as? UIButton
                break
            }
        }
        if selectedStar == nil { return }
        let selectedStarIndex = arrangedSubviews.firstIndex(of: selectedStar!)!
        value = selectedStarIndex + 1
        valueDidChangedHandler?(value)
    }
    
}

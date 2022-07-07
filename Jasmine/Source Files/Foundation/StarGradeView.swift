//
//  StarGradeView.swift
//  Jasmine
//
//  Created by ebamboo on 2021/11/24.
//

import UIKit

///
/// 评分控件
/// 通过 ⭐️ 来评分或展示评分
/// 常用于电商项目
///
/// 设置 isUserInteractionEnabled = false 禁止修改评分
///
public extension StarGradeView {
    
    /// 已评分 ⭐️ 图片
    @IBInspectable var seletedImage: UIImage? {
        get {
            return seletedImageStore
        }
        set {
            seletedImageStore = newValue
            contentView.arrangedSubviews.forEach { star in
                (star as! UIButton).setImage(newValue, for: .selected)
            }
        }
    }
    
    /// 未评分 ⭐️ 图片
    @IBInspectable var unseletedImage: UIImage? {
        get {
            return unseletedImageStore
        }
        set {
            unseletedImageStore = newValue
            contentView.arrangedSubviews.forEach { star in
                (star as! UIButton).setImage(newValue, for: .normal)
            }
        }
    }
    
    /// ⭐️ 之间间距 [0.0, ∞)
    @IBInspectable var itemSpacing: CGFloat {
        get {
            return itemSpacingStore
        }
        set {
            guard newValue >= 0.0 else { return }
            itemSpacingStore = newValue
            contentView.spacing = newValue
        }
    }
    
    /// 评分最大值范围为：[1, ∞)
    @IBInspectable var maxValue: Int {
        get {
            return maxValueStore
        }
        set {
            guard newValue != maxValueStore else { return }
            guard newValue >= 1 else { return }
            let oldValue = maxValueStore
            maxValueStore = newValue
            if newValue > oldValue {
                let addCount = newValue - oldValue
                (1...addCount).forEach { _ in
                    let star = UIButton(type: .custom)
                    star.setImage(unseletedImageStore, for: .normal)
                    star.setImage(seletedImageStore, for: .selected)
                    star.isUserInteractionEnabled = false
                    contentView.addArrangedSubview(star)
                }
                return
            }
            if newValue < oldValue {
                let removeCount = oldValue - newValue
                (1...removeCount).forEach { _ in
                    let star = contentView.arrangedSubviews.last!
                    contentView.removeArrangedSubview(star)
                    star.removeFromSuperview()
                }
                if value > newValue {
                    value = newValue
                }
                return
            }
        }
    }
    
    /// 当前评分值范围为：[0, ∞)
    /// 0 表示还没有评分
    @IBInspectable var value: Int {
        get {
            return valueStore
        }
        set {
            guard newValue != valueStore else { return }
            guard newValue >= 0 else { return }
            valueStore = newValue
            if newValue > maxValue {
                maxValue = newValue
            }
            contentView.arrangedSubviews.forEach { star in
                let starIndex = contentView.arrangedSubviews.firstIndex(of: star)!
                (star as! UIButton).isSelected = starIndex < newValue
            }
        }
    }
    
    /// 通过手势修改评分时回调
    func onValueDidChangedHandler(handler: @escaping (_ value: Int) -> Void) {
        onValueDidChangedHandler = handler
    }
    
}

public class StarGradeView: UIView {
    
    private var itemSpacingStore: CGFloat = 2
    private var maxValueStore: Int = 5
    private var unseletedImageStore: UIImage? = nil
    private var seletedImageStore: UIImage? = nil
    private var valueStore: Int = 0
    
    private var onValueDidChangedHandler: ((_ value: Int) -> Void)?
    
    private lazy var contentView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = itemSpacingStore
        
        (1...maxValueStore).forEach { _ in
            let star = UIButton(type: .custom)
            star.setImage(unseletedImageStore, for: .normal)
            star.setImage(seletedImageStore, for: .selected)
            star.isUserInteractionEnabled = false
            view.addArrangedSubview(star)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(gestureAction(_:)))
        view.addGestureRecognizer(tap)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(gestureAction(_:)))
        view.addGestureRecognizer(pan)

        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    @objc private func gestureAction(_ gesture: UIGestureRecognizer) {
        for (index, star) in contentView.arrangedSubviews.enumerated() {
            if star.bounds.contains(gesture.location(in: star)) {
                // ===== 找到具体评分
                valueStore = index + 1
                contentView.arrangedSubviews.enumerated().forEach { itemIndex, itemStar in
                    (itemStar as! UIButton).isSelected = itemIndex < valueStore
                }
                onValueDidChangedHandler?(valueStore)
                // ===== 找到具体评分
                return
            }
        }
    }
    
}

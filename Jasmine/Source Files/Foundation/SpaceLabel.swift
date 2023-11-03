//
//  SpaceLabel.swift
//  Jasmine
//
//  Created by ebamboo on 2023/4/14.
//

import UIKit

///
/// 自由控制 UILabel 字间距和行间距
/// 默认状态等效为 UILabel
/// 每次设置 wordSpace 或者 lineSpace 之后赋值字符串给 text 才会生效
///
open class SpaceLabel: UILabel {
 
    @IBInspectable var wordSpace: CGFloat = 0
    @IBInspectable var lineSpace: CGFloat = 0
    
    open override var text: String? {
        didSet {
            guard let string = text, !string.isEmpty else { return }
            let attributedString = NSMutableAttributedString(string: string)
            attributedString.addAttribute(.kern,
                                          value: wordSpace,
                                          range: NSRange(location: 0, length: string.count))
            attributedString.addAttribute(.paragraphStyle,
                                          value: {
                                                    let style = NSMutableParagraphStyle()
                                                    style.lineSpacing = lineSpace
                                                    return style
                                                 }(),
                                          range: NSRange(location: 0, length: string.count))
            attributedText = attributedString
        }
    }
    
}

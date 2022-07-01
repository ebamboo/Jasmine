//
//  String+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/22.
//

import UIKit

public extension String {
    
    /// 给定 font 和 width 计算多行字符串所占用尺寸的高度
    func height(font: UIFont, width: CGFloat) -> CGFloat {
        let text = self as NSString
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesLineFragmentOrigin
        let attributes = [NSAttributedString.Key.font: font]
        let rect = text.boundingRect(with: size, options: options, attributes: attributes, context: nil)
        return rect.size.height + 1
    }
    
    /// 给定 font 计算单行字符串所占用尺寸的宽度
    func width(font: UIFont) -> CGFloat {
        let text = self as NSString
        let size = text.size(withAttributes: [NSAttributedString.Key.font: font])
        return size.width + 1
    }
    
    /// 打电话
    func call() {
        if let url = URL(string: "telprompt://\(self)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /// 把字符串中汉字转换为拼音（小写字母）
    /// 注意：返回结果已去除了其中的 " " 字符串
    /// 举例：
    /// "你好".pinyin 结果为 "nihao"
    /// "1a《混合".pinyin 结果为 "1a《hunhe"
    /// "".pinyin 结果为 ""
    var pinyin: String {
        guard let temp = self.applyingTransform(.mandarinToLatin, reverse: false) else { return "" }
        guard let temp = temp.applyingTransform(.stripDiacritics, reverse: false) else { return "" }
        return temp.replacingOccurrences(of: " ", with: "")
    }
    
    /// 把字符串转为 query of URL
    /// 形如： "id=35&name=小明&address=杭州滨江海兴雅苑"  的字符串可用
    var queryable: String {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
}

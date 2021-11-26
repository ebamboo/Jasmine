//
//  UIImage+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/25.
//

import UIKit

// MARK: - 翻转和旋转

public extension UIImage {
    
    /// 翻转方向
    enum FlipDirection {
        case horizontal
        case vertical
    }
    
    /// 旋转角度
    enum RotateOption {
        case option0
        case option90
        case option180
        case option270
    }
    
    /// 获取翻转 image
    func flippedImage(direction: FlipDirection) -> UIImage? {
        guard let tempImage = cgImage else { return nil }
        switch direction {
        case .horizontal:
            return UIImage(cgImage: tempImage, scale: 1.0, orientation: .upMirrored)
        case .vertical:
            return UIImage(cgImage: tempImage, scale: 1.0, orientation: .downMirrored)
        }
    }
    
    /// 获取旋转 image
    func rotatedImage(option: RotateOption) -> UIImage? {
        guard let tempImage = cgImage else { return nil }
        switch option {
        case .option0:
            return self
        case .option90:
            return UIImage(cgImage: tempImage, scale: 1.0, orientation: .right)
        case .option180:
            return UIImage(cgImage: tempImage, scale: 1.0, orientation: .down)
        case .option270:
            return UIImage(cgImage: tempImage, scale: 1.0, orientation: .left)
        }
    }
    
    /// 获取旋转 image
    /// - Parameter angle: 旋转的任意弧度
    /// - Returns: image？
    func rotatedImage(angle: CGFloat) -> UIImage? {
        // 计算旋转之后 rotatedSize
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let tempTransform = CGAffineTransform(rotationAngle: angle)
        tempView.transform = tempTransform
        let rotatedSize = tempView.frame.size
        // 创建位图 bitmap
        UIGraphicsBeginImageContextWithOptions(rotatedSize, false, 0.0)
        let bitmap = UIGraphicsGetCurrentContext()
        // 操作
        bitmap?.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        bitmap?.rotate(by: angle)
        // 绘制位图
        draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        // 获取结果图
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage;
    }
    
}

// MARK: - 压缩图片

public extension UIImage {
    
    func compressedImage(size: CGSize) -> UIImage? {
        if size == self.size {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage;
    }
    
    func compressedImage(scale: CGFloat) -> UIImage? {
        if scale == 1.0 {
            return self
        }
        let tempSize = CGSize(width: self.size.width * scale, height: self.size.height * scale)
        return compressedImage(size: tempSize)
    }
    
}

// MARK: - 图片转换

public extension UIImage {
    
    ///
    /// 图片与 base64 互转
    ///
    func base64(quality: CGFloat = 1.0) -> String? {
        return jpegData(compressionQuality: quality)?.base64EncodedString(options: .lineLength64Characters)
    }
    convenience init?(base64: String) {
        guard let imageData = Data(base64Encoded: base64, options: .ignoreUnknownCharacters) else { return nil }
        self.init(data: imageData)
    }
    
    /// 颜色转图片
    convenience init?(color: UIColor) {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let contex = UIGraphicsGetCurrentContext()
        contex?.setFillColor(color.cgColor)
        contex?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let tempImage = newImage?.cgImage else { return nil }
        self.init(cgImage: tempImage)
    }
    
    /// UIView 转图片
    convenience init?(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0)
        guard let contex = UIGraphicsGetCurrentContext() else { return nil }
        view.layer.render(in: contex)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let tempImage = newImage?.cgImage else { return nil }
        self.init(cgImage: tempImage)
    }
    
    /// 字符串转二维码图片
    convenience init?(link: String, side: CGFloat) {
        // 1. 创建一个二维码滤镜实例(CIFilter)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        // 滤镜恢复默认设置
        filter?.setDefaults()
        
        // 2. 给滤镜添加数据
        let tempData = link.data(using: .utf8)
        // 使用KVC的方式给filter赋值
        filter?.setValue(tempData, forKey: "inputMessage")
        //设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
        filter?.setValue("H", forKey: "inputCorrectionLevel")
        
        // 3. 生成二维码
        guard let tempCGImage = filter?.outputImage else { return nil }
        let tempRect = tempCGImage.extent.integral
        let tempScale = min(side/tempRect.size.width, side/tempRect.size.height)
        
        // 4.创建bitmap
        let tempWidth = Int(tempRect.size.width * tempScale)
        let tempHeight = Int(tempRect.size.height * tempScale)
        let cs = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: tempWidth, height: tempHeight, bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: 0)
        let context = CIContext(options: nil)
        guard let bitmapImage = context.createCGImage(tempCGImage, from: tempRect) else { return nil}
        bitmapRef?.interpolationQuality = .none
        bitmapRef?.scaleBy(x: tempScale, y: tempScale)
        bitmapRef?.draw(bitmapImage, in: tempRect)
        
        // 5.保存bitmap到图片
        guard let resultImage = bitmapRef?.makeImage() else { return nil }
        self.init(cgImage: resultImage)
    }
    
}

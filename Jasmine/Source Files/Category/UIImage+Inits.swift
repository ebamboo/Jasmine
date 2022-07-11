//
//  UIImage+Inits.swift
//  Jasmine
//
//  Created by ebamboo on 2022/7/3.
//

import UIKit

public extension UIImage {
    
    /// base64 转为 UIImage
    convenience init?(base64: String) {
        guard let imageData = Data(base64Encoded: base64, options: .ignoreUnknownCharacters) else { return nil }
        self.init(data: imageData)
    }
    
    /// 字符串转为二维码图片
    convenience init?(qr: String, side: CGFloat = 300) {
        // 二维码滤镜名称固定写法 "CIQRCodeGenerator"
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        filter.setDefaults()
        // 设置输入数据
        filter.setValue(qr.data(using: .utf8), forKey: "inputMessage")
        // 设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
        filter.setValue("H", forKey: "inputCorrectionLevel")
        
        guard let ciImage = filter.outputImage else { return nil }
        guard let cgImage = UIImage.transferToCGImage(from: ciImage, side: side) else { return nil }
        self.init(cgImage: cgImage)
    }
    
    /// 颜色转为 UIImage
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1.0, height: 1.0)) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: .zero, size: size))
        guard let cgImage  = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    /// UIView 转为 UIImage
    convenience init?(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        view.layer.render(in: context)
        guard let cgImage  = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
}

private extension UIImage {
    
    /// 把不清晰的 ciImage 转为清晰的 cgImage
    static func transferToCGImage(from ciImage: CIImage, side: CGFloat = 300) -> CGImage? {
        // 1.
        let extent = ciImage.extent
        guard let cgImage = CIContext(options: nil).createCGImage(ciImage, from: extent) else { return nil }
        
        // 2.
        let scale = min(side/extent.size.width, side/extent.size.height) * UIScreen.main.scale
        let context_width = Int(extent.size.width * scale)
        let context_height = Int(extent.size.height * scale)
        
        // 3.
        guard let context = CGContext(data: nil, width: context_width, height: context_height, bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceGray(), bitmapInfo: 0) else { return nil }
        context.interpolationQuality = .none
        context.scaleBy(x: scale, y: scale)
        context.draw(cgImage, in: extent)
        
        // 4.
        return context.makeImage()
    }
    
}

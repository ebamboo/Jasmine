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
    
    ///
    /// 苹果提供的图片压缩处理，极大地降低了内存使用
    /// https://developer.apple.com/videos/play/wwdc2018/219/?time=26
    ///
    static func downsample(image data: Data, to pointSize: CGSize, scale: CGFloat) -> UIImage {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions)!
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary
        let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions)!
        return UIImage(cgImage: downsampledImage)
    }
    static func downsample(image url: URL, to pointSize: CGSize, scale: CGFloat) -> UIImage {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        let imageSource = CGImageSourceCreateWithURL(url as CFURL, imageSourceOptions)!
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary
        let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions)!
        return UIImage(cgImage: downsampledImage)
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
    
 
    
   
    
}

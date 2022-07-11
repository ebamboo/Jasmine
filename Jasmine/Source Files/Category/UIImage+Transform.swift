//
//  UIImage+Transform.swift
//  Jasmine
//
//  Created by ebamboo on 2022/7/3.
//

import UIKit

public extension UIImage {
    
    enum Transform {
        /// 水平方向翻转（镜像）
        case horizontalMirrored
        /// 垂直方向翻转（镜像）
        case verticalMirrored
        
        /// 本身 -- 返回 self
        case upRotated
        /// 旋转到底部（顺时针旋转180度）
        case downRotated
        /// 旋转到左边（顺时针旋转-90度）
        case leftRotated
        /// 旋转到右边（顺时针旋转90度）
        case rightRotated
        
        /// 顺时针旋转任意角度
        case rotated(radian: Double)
    }
    
    func transfering(_ transform: Transform) -> UIImage? {
        switch transform {
        case .horizontalMirrored:
            guard let tempCGImage = cgImage else { return nil }
            return UIImage(cgImage: tempCGImage, scale: scale, orientation: .upMirrored)
        case .verticalMirrored:
            guard let tempCGImage = cgImage else { return nil }
            return UIImage(cgImage: tempCGImage, scale: scale, orientation: .downMirrored)
        case .upRotated:
            return self
        case .downRotated:
            guard let tempCGImage = cgImage else { return nil }
            return UIImage(cgImage: tempCGImage, scale: scale, orientation: .down)
        case .leftRotated:
            guard let tempCGImage = cgImage else { return nil }
            return UIImage(cgImage: tempCGImage, scale: scale, orientation: .left)
        case .rightRotated:
            guard let tempCGImage = cgImage else { return nil }
            return UIImage(cgImage: tempCGImage, scale: scale, orientation: .right)
        case .rotated(let radian):
            // 计算旋转之后 rotatedSize
            let tempView = UIView(frame: CGRect(origin: .zero, size: size))
            tempView.transform = CGAffineTransform(rotationAngle: radian)
            let rotatedSize = tempView.frame.size
            // 根据 rotatedSize 创建位图上下文
            UIGraphicsBeginImageContextWithOptions(rotatedSize, false, scale)
            defer { UIGraphicsEndImageContext() }
            guard let context = UIGraphicsGetCurrentContext() else { return nil }
            // 坐标系先平移操作，再旋转操作
            context.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
            context.rotate(by: radian)
            // 绘制位图
            draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
            // 获取图片
            guard let tempImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
            return tempImage;
        }
    }
    
}

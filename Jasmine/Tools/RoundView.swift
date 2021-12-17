//
//  RoundView.swift
//  Jasmine
//
//  Created by ebamboo on 2021/12/10.
//

import UIKit

///
/// 完全自定义 UIView 每个圆角的是否圆角以及该圆角的大小
///
public class RoundView: UIView {

    @IBInspectable var topLeftRadius: CGFloat = 0.0
    @IBInspectable var topRightRadius: CGFloat = 0.0
    @IBInspectable var bottomRightRadius: CGFloat = 0.0
    @IBInspectable var bottomLeftRadius: CGFloat = 0.0
    
    public override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        if topLeftRadius > 0.0 {
            path.addArc(withCenter: CGPoint(x: topLeftRadius, y: topLeftRadius), radius: topLeftRadius, startAngle: -Double.pi, endAngle: -Double.pi/2, clockwise: true)
        } else {
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width/2, y: 0))
        }
        
        if topRightRadius > 0.0 {
            path.addArc(withCenter: CGPoint(x: rect.width-topRightRadius, y: topRightRadius), radius: topRightRadius, startAngle: -Double.pi/2, endAngle: 0, clockwise: true)
        } else {
            path.addLine(to: CGPoint(x: rect.width, y: 0))
        }
        
        if bottomRightRadius > 0.0 {
            path.addArc(withCenter: CGPoint(x: rect.width-bottomRightRadius, y: rect.height-bottomRightRadius), radius: bottomRightRadius, startAngle: 0, endAngle: Double.pi/2, clockwise: true)
        } else {
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        }
        
        if bottomLeftRadius > 0.0 {
            path.addArc(withCenter: CGPoint(x: bottomLeftRadius, y: rect.height-bottomLeftRadius), radius: bottomLeftRadius, startAngle: Double.pi/2, endAngle: Double.pi, clockwise: true)
        } else {
            path.addLine(to: CGPoint(x: 0, y: rect.height))
        }
        
        path.close()
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }

}

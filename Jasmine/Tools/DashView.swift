//
//  DashView.swift
//  Jasmine
//
//  Created by ebamboo on 2021/12/8.
//

import UIKit

///
/// 自定义虚线视图
/// 虚线宽度等于视图高度（水平方向）或者视图宽度（垂直方向）
/// 使用时要设置 backgroundColor = .clear
///
/// 注意：布局变化时调用 setNeedsDisplay() 方法从而主动引起 draw() 调用
///
public class DashView: UIView {

    /// 0：水平方向
    /// 非0：垂直方向
    @IBInspectable var direction: Int = 0
    /// 虚线颜色
    @IBInspectable var strokeColor: UIColor = .gray
    /// 每个虚线单元长度
    @IBInspectable var lineUnitLength: CGFloat = 10
    /// 虚线单元之间间隔
    @IBInspectable var lineUnitSpacing: CGFloat = 4
    
    public override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        if direction == 0 {
            path.move(to: CGPoint(x: 0, y: rect.size.height/2))
            path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height/2))
            path.lineWidth = rect.size.height
        } else {
            path.move(to: CGPoint(x: rect.size.width/2, y: 0))
            path.addLine(to: CGPoint(x: rect.size.width/2, y: rect.size.height))
            path.lineWidth = rect.size.width
        }
        
        path.setLineDash([lineUnitLength, lineUnitSpacing], count: 2, phase: 0)
        strokeColor.setStroke()
        path.stroke()
    }

}

//
//  ModelAnimator.swift
//  Jasmine
//
//  Created by ebamboo on 2021/11/28.
//

import UIKit

///
/// 自定义模态动画
/// 目前仅支持四个方向的动画
/// 只需要把需要自定义模态动画的 vc 的属性 transitioningDelegate
/// 设置为 TransitioningDelegate 实例即可
/// 注意 TransitioningDelegate 实例的生命周期
///
public class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    enum TransitionStyle {
        case leftToRight
        case rightToLeft
        case topToBottom
        case bottomToTop
    }
    
    private let presentStyle: TransitionStyle
    private let presentDuration: TimeInterval
    private let dismissStyle: TransitionStyle
    private let dismissDuration: TimeInterval
    
    init(
        presentStyle: TransitionStyle = .rightToLeft,
        presentDuration: TimeInterval = 0.3,
        dismissStyle: TransitionStyle = .leftToRight,
        dismissDuration: TimeInterval = 0.3
    ) {
        self.presentStyle = presentStyle
        self.presentDuration = presentDuration
        self.dismissStyle = dismissStyle
        self.dismissDuration = dismissDuration
    }
    
}

public extension TransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModelAnimator(style: presentStyle, duration: presentDuration)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModelAnimator(style: dismissStyle, duration: dismissDuration)
    }
    
}

private class ModelAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let style: TransitioningDelegate.TransitionStyle
    let duration: TimeInterval
    init(style: TransitioningDelegate.TransitionStyle, duration: TimeInterval = 0.4) {
        self.style = style
        self.duration = duration
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // MARK: - 第一步：获取相关视图和视图控制器
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        let fromView = transitionContext.view(forKey: .from) ?? fromVC.view!
        let toView = transitionContext.view(forKey: .to) ?? toVC.view!
        
        // MARK: - 第二步：判断当前转场发生的具体形式
        let present = toVC.presentingViewController == fromVC
        let dismiss = fromVC.presentingViewController == toVC
        
        // MARK: - 第三步：根据不同场景执行不同动画
        ///
        /// !!!!!!一定要理解视图层次!!!!!!
        /// UIViewController --> UIView --> Transition View --> Wrapper View
        /// UIWindowScene、UITabBarController、UINavigationController
        /// 除了以上三种控制器会生成 Transition View
        /// 模态时也会生成 Transition View，并且 Transition View 直接在 window 上
        /// presentedView 直接在 Transition View
        ///
        /// 做动画时注意 custom 和 fullScreen 的视图的层次结构
        /// 一般设置成 custom
        ///
        if present {
            let containerFrame = transitionContext.initialFrame(for: fromVC)
            let beginFrame: CGRect!
            switch style {
            case .leftToRight:
                beginFrame = containerFrame.offsetBy(dx: -containerFrame.size.width, dy: 0)
            case .rightToLeft:
                beginFrame = containerFrame.offsetBy(dx: containerFrame.size.width, dy: 0)
            case .topToBottom:
                beginFrame = containerFrame.offsetBy(dx: 0, dy: -containerFrame.size.height)
            case .bottomToTop:
                beginFrame = containerFrame.offsetBy(dx: 0, dy: containerFrame.size.height)
            }
            let endFrame = containerFrame
            
            // 发生 present 转场时 toView 还么有在 containerView，需要添加 toView 到 containerView
            toView.frame = beginFrame
            transitionContext.containerView.addSubview(toView)
            UIView.animate(withDuration: duration) {
                toView.frame = endFrame
            } completion: { finished in
                // 上报转场结束并且是否成功情况，否则会认为还在转场 无法交互
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                if transitionContext.transitionWasCancelled {
                    // 取消时把要加入的 toView 移除
                    toView.removeFromSuperview()
                }
            }
            return
        }
        if dismiss {
            let containerFrame = transitionContext.initialFrame(for: fromVC)
            let endFrame: CGRect!
            switch style {
            case .leftToRight:
                endFrame = containerFrame.offsetBy(dx: containerFrame.size.width, dy: 0)
            case .rightToLeft:
                endFrame = containerFrame.offsetBy(dx: -containerFrame.size.width, dy: 0)
            case .topToBottom:
                endFrame = containerFrame.offsetBy(dx: 0, dy: containerFrame.size.height)
            case .bottomToTop:
                endFrame = containerFrame.offsetBy(dx: 0, dy: -containerFrame.size.height)
            }
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {
                fromView.frame = endFrame
            } completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
            return
        }
    }
    
}

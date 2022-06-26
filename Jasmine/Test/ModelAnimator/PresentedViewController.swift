//
//  PresentedViewController.swift
//  Jasmine
//
//  Created by ebamboo on 2021/11/28.
//

import UIKit

class PresentedViewController: UIViewController {
    
    let animator = TransitioningDelegate(presentStyle: .rightToLeft, presentDuration: 1.2, dismissStyle: .leftToRight, dismissDuration: 1.2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // 只要实现 UIViewControllerTransitioningDelegate 的对象都可以
        transitioningDelegate = animator
        // 注意设置为 custom 和 fullScreen 异同点，防止出现黑屏相关的问题(参见视图层次关系)
        modalPresentationStyle = .custom
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func test(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

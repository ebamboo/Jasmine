//
//  ViewController.swift
//  Jasmine
//
//  Created by ebamboo on 2021/11/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let titles = [
        "Keychain", "ModelAnimator", "TableView高度缓存",
        "自定义虚线视图DashView", "自定义UIView每个圆角大小RoundView", "自定义UICollectionViewFlowLayout",
        "UIImage+Transform 测试", "自定义 Stepper", "自定义评分控件",
        "标签样式CollectionViewTagLayout", "ScrollView简单嵌套"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Jasmine"
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        cell?.textLabel?.text = titles[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row == 0 {
            navigationController?.pushViewController(KeychainViewController(), animated: true)
            return
        }
        if indexPath.row == 1 {
            navigationController?.pushViewController(PresentingViewController(), animated: true)
            return
        }
        if indexPath.row == 2 {
            navigationController?.pushViewController(CacheHeightViewController(), animated: true)
            return
        }
        if indexPath.row == 3 {
            navigationController?.pushViewController(DashTestViewController(), animated: true)
            return
        }
        if indexPath.row == 4 {
            navigationController?.pushViewController(RoundViewTestViewController(), animated: true)
            return
        }
        if indexPath.row == 5 {
            navigationController?.pushViewController(FlowLayoutTestViewController(), animated: true)
            return
        }
        if indexPath.row == 6 {
            navigationController?.pushViewController(UIImageTransformTestViewController(), animated: true)
            return
        }
        if indexPath.row == 7 {
            navigationController?.pushViewController(StepperTestViewController(), animated: true)
            return
        }
        if indexPath.row == 8 {
            navigationController?.pushViewController(GradeTestViewController(), animated: true)
            return
        }
        if indexPath.row == 9 {
            navigationController?.pushViewController(TagLayoutTestViewController(), animated: true)
            return
        }
        if indexPath.row == 10 {
            navigationController?.pushViewController(NestedScrollViewTestViewController(), animated: true)
            return
        }
    }
    
}

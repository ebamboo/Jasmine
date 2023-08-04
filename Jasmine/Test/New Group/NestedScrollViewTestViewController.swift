//
//  NestedScrollViewTestViewController.swift
//  Jasmine
//
//  Created by ebamboo on 2023/8/4.
//

import UIKit

class NestedScrollViewTestViewController: UIViewController {

    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var subStackView: UIStackView!
    
    @IBOutlet weak var subTableView: NestTableView!

}

extension NestedScrollViewTestViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    ///
    /// 核心代码
    ///
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView === mainScrollView {
            
            if subTableView.contentOffset.y > 0 {
                mainScrollView.contentOffset = CGPoint(x: 0, y: subStackView.bounds.height)
            }
            
            if (mainScrollView.contentOffset.y < subStackView.bounds.height) {
                subTableView.contentOffset = .zero
            }
            
            return
        }
        
        if scrollView === subTableView {
            
            if mainScrollView.contentOffset.y < subStackView.bounds.height {
                subTableView.contentOffset = .zero
                subTableView.showsVerticalScrollIndicator = false
            }
            
            else {
                mainScrollView.contentOffset = CGPoint(x: 0, y: subStackView.bounds.height)
                subTableView.showsVerticalScrollIndicator = true
            }
            
            return
        }
        
    }
    
}

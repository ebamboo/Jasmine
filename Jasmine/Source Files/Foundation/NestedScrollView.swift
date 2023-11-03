//
//  NestedScrollView.swift
//  Jasmine
//
//  Created by ebamboo on 2023/8/4.
//

import UIKit

private let ___nested_main_scroll_view_tag___ = 3141592653


///
/// ！！！注意 ！！！
/// 1. 设置主 ScrollView Tag 为 ___nested_main_scroll_view_tag___ （为了美观设置showsVerticalScrollIndicator为false）
/// 2. 设置子 ScrollView 类型为 NestedScrollView/NestedTableView/NestedCollectionView
/// 3. 在主 ScrollView 和 子 ScrollView 滚动回调中 scrollViewDidScroll(_:) 作处理（参考如下）
///


//
//func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//    if scrollView === mainScrollView {
//
//        if subTableView.contentOffset.y > 0 {
//            mainScrollView.contentOffset = CGPoint(x: 0, y: subStackView.bounds.height)
//        }
//
//        if (mainScrollView.contentOffset.y < subStackView.bounds.height) {
//            subTableView.contentOffset = .zero
//        }
//
//        return
//    }
//
//    if scrollView === subTableView {
//
//        if mainScrollView.contentOffset.y < subStackView.bounds.height {
//            subTableView.contentOffset = .zero
//            subTableView.showsVerticalScrollIndicator = false
//        }
//
//        else {
//            mainScrollView.contentOffset = CGPoint(x: 0, y: subStackView.bounds.height)
//            subTableView.showsVerticalScrollIndicator = true
//        }
//
//        return
//    }
//
//}
//


public class NestedScrollView: UIScrollView, UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) &&
        otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self) &&
        otherGestureRecognizer.view?.tag == ___nested_main_scroll_view_tag___
    }
    
}

public class NestedTableView: UITableView, UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) &&
        otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self) &&
        otherGestureRecognizer.view?.tag == ___nested_main_scroll_view_tag___
    }
    
}

public class NestedCollectionView: UICollectionView, UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) &&
        otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self) &&
        otherGestureRecognizer.view?.tag == ___nested_main_scroll_view_tag___
    }
    
}

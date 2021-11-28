//
//  PresentingViewController.swift
//  Jasmine
//
//  Created by ebamboo on 2021/11/28.
//

import UIKit

class PresentingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func test(_ sender: Any) {
        let vc = PresentedViewController()
        present(vc, animated: true, completion: nil)
    }

}

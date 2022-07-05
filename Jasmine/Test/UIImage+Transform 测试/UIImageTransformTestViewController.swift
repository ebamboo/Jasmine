//
//  UIImageTransformTestViewController.swift
//  Jasmine
//
//  Created by ebamboo on 2022/7/5.
//

import UIKit

class UIImageTransformTestViewController: UIViewController {
    
    @IBOutlet weak var originImageView: UIImageView!
    @IBOutlet weak var testImageView01: UIImageView!
    @IBOutlet weak var testImageView02: UIImageView!
    
    let testImage = UIImage(named: "02")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "UIImage+Transform 测试"
        originImageView.image = testImage
        testImageView01.image = testImage
        testImageView02.image = testImage
    }

    static var i = 1
    @IBAction func testAction01(_ sender: Any) {
        switch Self.i % 4 {
        case 0:
            testImageView01.image = testImage.transfering(.upRotated)
        case 1:
            testImageView01.image = testImage.transfering(.rightRotated)
        case 2:
            testImageView01.image = testImage.transfering(.downRotated)
        case 3:
            testImageView01.image = testImage.transfering(.leftRotated)
        default:
            break
        }
        Self.i += 1
    }
    
    @IBAction func testAction02(_ sender: Any) {
        testImageView02.image = testImage.transfering(.rotated(radian: Double.pi/9))
    }
    
    @IBAction func restartAction(_ sender: Any) {
        testImageView01.image = testImage
        testImageView02.image = testImage
    }
    
}

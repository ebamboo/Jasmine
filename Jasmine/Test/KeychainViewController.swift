//
//  KeychainViewController.swift
//  Jasmine
//
//  Created by ebamboo on 2021/11/27.
//

import UIKit

class KeychainViewController: UIViewController {

    let identifier = "item01"
    let service = "com.beizhu.demo01"
    let accessGroup: String? = nil
    
    var keychain: Keychain!
    
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "key chain"
        keychain = Keychain(identifier: identifier, service: service, accessGroup: accessGroup)
    }

    @IBAction func saveAction(_ sender: Any) {
        guard let account = accountField.text, account.count > 0,
              let password = passwordField.text, password.count > 0 else { return }
        let success = keychain.storeAccountAndPassword(account: account, password: password.data(using: .utf8)!)
        if success {
            print("store success")
        } else {
            print("store failure")
        }
    }
    
    @IBAction func queryAction(_ sender: Any) {
        guard let result = keychain.queryAccountAndPassword() else {
            print("query failure")
            accountLabel.text = ""
            passwordLabel.text = ""
            return
        }
        accountLabel.text = result.account
        passwordLabel.text = String(data: result.password, encoding: .utf8)!
    }
    
    @IBAction func clearAction(_ sender: Any) {
        let success = keychain.reset()
        if success {
            print("reset success")
        } else {
            print("reset failure")
        }
    }
    
}

//
//  KeychainViewController.swift
//  Jasmine
//
//  Created by ebamboo on 2021/11/27.
//

import UIKit

class KeychainViewController: UIViewController {

    let service = "com.beizhu.demo01"
    
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "key chain"
    }

    @IBAction func saveAction(_ sender: Any) {
        let account = accountField.text ?? ""
        let password = passwordField.text ?? ""
        if let _ = try? Keychain.saveData(password.data(using: .utf8)!, for: account, service: service) {
            print("save ========== success")
        } else {
            print("save ========== failure")
        }
    }
    
    @IBAction func queryAction(_ sender: Any) {
        let account = accountField.text ?? ""
        if let data = try? Keychain.readData(for: account, service: service) {
            passwordLabel.text = String(data: data, encoding: .utf8)
            print("read ========== \(String(data: data, encoding: .utf8) ?? "成功空值")")
        } else {
            print("read ========== failure")
        }
    }
    
    @IBAction func clearAction(_ sender: Any) {
        let account = accountField.text ?? ""
        if let _ = try? Keychain.clearData(for: account, service: service) {
            print("clear ========== success")
        } else {
            print("clear ========== failure")
        }
    }
    
    
    @IBAction func queryAllAccountsAction(_ sender: Any) {
        if let list = try? Keychain.readAccounts(service: service) {
            accountLabel.text = list.reduce("\n", { partialResult, item in
                return partialResult + item + "\n"
            })
            print("read all accounts ========== \(list)")
        } else {
            print("read all accounts ========== failure")
        }
    }
    
    @IBAction func clearAllDataAction(_ sender: Any) {
        if let _ = try? Keychain.clearData(for: nil, service: service) {
            print("clear all data ========== success")
        } else {
            print("clear all data ========== failure")
        }
    }
    
}

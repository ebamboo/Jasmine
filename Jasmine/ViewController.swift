//
//  ViewController.swift
//  Jasmine
//
//  Created by ebamboo on 2021/11/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let titles = ["Keychain"]
    
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
    }
    
}

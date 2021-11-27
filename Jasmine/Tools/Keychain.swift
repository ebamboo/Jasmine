//
//  KeychainWrapper.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/18.
//

import Foundation

/// 使用钥匙串管理账号密码
public struct Keychain {
    
    ///
    /// 通常 service 使用 bundle identifier 来标明一个 App 在 keychain 唯一标识
    /// 但是，一个 App 又可能有多个数据存储在 keychain 中，因此需要 identifier 来唯一表明一个 item
    /// identifier 和 service 可以认为是主键
    /// accessGroup 使用要注意和开发者账号前缀有关，要使用全称
    ///
    let identifier: String
    let service: String
    let accessGroup: String?
    
    private var baseQuery: [String: Any] {
        var query = [String: Any]()
        query[kSecClass as String] = kSecClassGenericPassword as String
        query[kSecAttrGeneric as String] = identifier
        query[kSecAttrService as String] = service
        #if !targetEnvironment(simulator)
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup
        }
        #endif
        query[kSecAttrAccessible as String] = kSecAttrAccessibleWhenUnlocked as String
        return query
    }
    
}

public extension Keychain {
    
    /// 查询 account 和 password
    func queryAccountAndPassword() -> (account: String, password: Data)? {
        var query = baseQuery
        query[kSecMatchLimit as String] = kSecMatchLimitOne as String
        query[kSecReturnData as String] = true
        query[kSecReturnAttributes as String] = true
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess, let dic = result as? [String: Any] else { return nil }
        guard let account = dic[kSecAttrAccount as String] as? String,
              let password = dic[kSecValueData as String] as? Data else { return nil }
        return (account, password)
    }

    /// 存储  account 和 password
    /// 如果已存在则更新数据
    /// 如果不存在则增加新的纪录
    func storeAccountAndPassword(account: String, password: Data) -> Bool {
        var query = baseQuery
        query[kSecMatchLimit as String] = kSecMatchLimitOne as String
        query[kSecReturnAttributes as String] = true
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        // 查询已有数据并且成功返回数据，则更新数据
        if status == errSecSuccess, var updateItem = result as? [String: Any] {
            updateItem[kSecClass as String] = kSecClassGenericPassword as String
            let attributes: [String : Any] = [
                kSecAttrAccount as String: account,
                kSecValueData as String: password
            ]
            return SecItemUpdate(updateItem as CFDictionary, attributes as CFDictionary) == errSecSuccess
        } else { // 查询失败或者没有返回数据，则增加新的纪录
            var addItem = baseQuery
            addItem[kSecAttrAccount as String] = account
            addItem[kSecValueData as String] = password
            return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
        }
    }
    
    /// 删除该纪录
    func reset() -> Bool {
        return SecItemDelete(baseQuery as CFDictionary) == errSecSuccess
    }
    
}

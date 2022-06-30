//
//  Keychain.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/18.
//

import Foundation

///
/// 使用钥匙串管理账号和密码数据
/// 密码数据不仅仅指一个简单的字符串，还可以是一些其他敏感数据
/// 通常 service 使用 bundle identifier 来标明应用在 Keychain 唯一标识
///
/// Apple 关于 Keychain 的文档
/// https://developer.apple.com/documentation/security/keychain_services
///
/// 注意一：
/// 1. For generic passwords, the primary keys include kSecAttrAccount and kSecAttrService.
/// 对于 kSecClassGenericPassword 密码数据，主键包含 kSecAttrAccount 和 kSecAttrService
/// 2. You can’t combine the kSecReturnData and kSecMatchLimitAll options when copying password items, because copying each password item could require additional authentication. Instead, request a reference or persistent reference to the items, then request the data for only the specific passwords that you actually require.
/// 查询时不能同时使用 kSecReturnData 和 kSecMatchLimitAll，所以不能同时读取所有的 kSecAttrAccount 和 kSecValueData。基于此，可以先获取所有 accounts，再按需使用 account 读取密码数据（kSecValueData）
///
/// 注意二：
/// 调用 SecItemAdd 时， 不设置 kSecAttrAccount 或者设置 kSecAttrAccount 为 "" 等效 ------ Keychain 中存储为 ""
/// 调用 SecItemCopyMatching 或者 SecItemDelete 时，
/// 不设置 kSecAttrAccount 则操作对象为所有 kSecAttrService 为 service 的 items
/// 设置 kSecAttrAccount 为 "" 则操作对象为所有 kSecAttrService 为 service 且 kSecAttrAccount 为 "" 的 items
///
public struct Keychain {
    
    enum KeychainError: Error {
        case unexpectedData
        case unhandledError(status: OSStatus)
    }
    
    /// 删除数据
    /// 若 account 为 nil，删除 kSecAttrService 为 service 的 items
    /// 若 account 存在，删除  kSecAttrService 为 service 且 kSecAttrAccount 为 account 的 items
    static func clearData(for account: String? = nil, service: String) throws {
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service
        ]
        if let account = account {
            query[kSecAttrAccount as String] = account
        }
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecItemNotFound || status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    /// 读取所有账号
    /// 若返回的列表为空，可能 errSecItemNotFound 或者 itemList.compactMap 结果为空
    /// 空的含义：调用 isEmpty 返回 true
    static func readAccounts(service: String) throws -> [String] {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecMatchLimit as String: kSecMatchLimitAll, // 必须明确设置为 kSecMatchLimitAll，否则返回的 items 不为 [[String: Any]]
            kSecReturnAttributes as String: true
        ]
        var items: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &items)
        
        if status == errSecItemNotFound { return [] }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        guard let itemList = items as? [[String: Any]] else { throw KeychainError.unexpectedData }
        return itemList.compactMap { $0[kSecAttrAccount as String] as? String }
    }
    
    /// 读取数据
    /// 若返回的数据为空，可能 errSecItemNotFound 或者 data 为空
    /// 空的含义：调用 isEmpty 返回 true
    static func readData(for account: String, service: String) throws -> Data {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecMatchLimit as String: kSecMatchLimitOne, // 主键为 service+account 因此最多存在一个（如果 Keychain 中已存在则无法再次添加）
            kSecReturnAttributes as String: true, // 必须明确设置为 true，否则返回的 item 不为 [String : Any]
            kSecReturnData as String: true
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecItemNotFound { return Data() }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        guard let existingItem = item as? [String : Any], let data = existingItem[kSecValueData as String] as? Data else {
            throw KeychainError.unexpectedData
        }
        return data
    }
    
    /// 保存数据
    static func saveData(_ data: Data, for account: String, service: String) throws {
        try clearData(for: account, service: service)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
    
}

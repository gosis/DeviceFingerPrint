//
//  DAKeychain.swift
//  DAKeychain
//
//  Created by Dejan on 28/02/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//
import Foundation

open class DAKeychain {
    
    private init() {}
    
    public class func delete(key:String) {
        let query = keychainQuery(withKey: key)
        
        if SecItemCopyMatching(query, nil) == noErr {
            let status = SecItemDelete(query)
            NSLog("Delete status: %i", status)
        }
    }
    
    public class func save(_ string: String?, forKey key: String) {
        let query = keychainQuery(withKey: key)
        let objectData: Data? = string?.data(using: .utf8, allowLossyConversion: false)
        
        if SecItemCopyMatching(query, nil) == noErr {
            if let dictData = objectData {
                let status = SecItemUpdate(query, NSDictionary(dictionary: [kSecValueData: dictData]))
                NSLog("Update status: %i", status)
            } else {
                let status = SecItemDelete(query)
                NSLog("Delete status: %i", status)
            }
        } else {
            if let dictData = objectData {
                query.setValue(dictData, forKey: kSecValueData as String)
                let status = SecItemAdd(query, nil)
                NSLog("Update status: %i", status)
            }
        }
    }
    
    public class func load(withKey key: String) -> String? {
        let query = keychainQuery(withKey: key)
        query.setValue(kCFBooleanTrue, forKey: kSecReturnData as String)
        query.setValue(kCFBooleanTrue, forKey: kSecReturnAttributes as String)
        
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query, &result)
        
        guard
            let resultsDict = result as? NSDictionary,
            let resultsData = resultsDict.value(forKey: kSecValueData as String) as? Data,
            status == noErr
            else {
                NSLog("Load status: %i", status)
                return nil
        }
        return String(data: resultsData, encoding: .utf8)
    }

    private class func keychainQuery(withKey key: String) -> NSMutableDictionary {
        let result = NSMutableDictionary()
        result.setValue(kSecClassGenericPassword, forKey: kSecClass as String)
        result.setValue(key, forKey: kSecAttrService as String)
        result.setValue(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly, forKey: kSecAttrAccessible as String)
        return result
    }
}

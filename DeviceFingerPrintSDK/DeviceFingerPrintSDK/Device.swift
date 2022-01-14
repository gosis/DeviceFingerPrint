//
//  Device.swift
//  DeviceFingerPrintSDK
//
//  Created by Gints Osis on 14/01/2022.
//

import Foundation

// Class managing properties regarding users Device
public class Device {
    
    private static let deviceIdKey = "deviceId"
    
    /// Returns deviceId from keychain if exists
    /// If no deviceId is found it will be generated and stored in keychain before returning
    ///
    /// - Parameter forceReplace: true will force new deviceId to be generated and stored regardless of existing deviceId
    /// - Returns: Unique deviceId string
    public static func deviceId(forceReplace: Bool) -> String {
        if let existingDeviceId = existingDeviceId(),
            !forceReplace {
            return existingDeviceId
        } else {
            return generateAndSaveNewDeviceId()
        }
    }
    
    private static func existingDeviceId() -> String? {
        return DAKeychain.load(withKey: deviceIdKey)
    }
    
    private static func generateAndSaveNewDeviceId() -> String {
        let uuid = UUID().uuidString
        DAKeychain.save(uuid, forKey: deviceIdKey)
        return uuid
    }
}

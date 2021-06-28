//
//  LocalStorage.swift
//  BiofourmisAssignment
//
//  Created by Pushpender on 26/06/21.
//

import Foundation

protocol LocalStorageType {
    func setUserLoginStatusFor(value: Bool)
    func getUserLoginStatusFor() -> Bool
}

class UserDefaultsLocalStorage: LocalStorageType {
    func setUserLoginStatusFor(value: Bool) {
        UserDefaults.standard.set(value, forKey: UserDefaultKeys.loginStatus)
    }
    
    func getUserLoginStatusFor() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultKeys.loginStatus)
    }
}

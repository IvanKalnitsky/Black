//
//  TopResult.swift
//  BlackJack
//
//  Created by macbookp on 08.08.2021.
//

import Foundation

final class TopResults {

    private enum SettingsKeys: String {
        case result
        case array
        case nameArray
        case theme
    }

    static var choosedTheme: Int! {
        get {
            return UserDefaults.standard.integer(forKey: SettingsKeys.theme.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.theme.rawValue
            if let newResult = newValue {
                defaults.setValue(newResult, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }

    static var topResult: Int! {
        get {
            return UserDefaults.standard.integer(forKey: SettingsKeys.result.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.result.rawValue
            if let newResult = newValue {
                defaults.setValue(newResult, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }

    static var resultsArray: [Any]! {
        get {
            return UserDefaults.standard.array(forKey: SettingsKeys.array.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.array.rawValue
            if let newResult = newValue {
                defaults.setValue(newResult, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var namesArray: [Any]! {
        get {
            return UserDefaults.standard.array(forKey: SettingsKeys.nameArray.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.nameArray.rawValue
            if let newResult = newValue {
                defaults.setValue(newResult, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }

}

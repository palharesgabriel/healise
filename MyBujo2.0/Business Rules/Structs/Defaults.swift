//
//  Defaults.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 17/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//
import UIKit

struct Defaults {
    static var name: String? {
        
        get {
            guard let name = UserDefaults.standard.value(forKey: "name") else { return nil }
            return name as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "name")
        }
    }
    static var login: Bool? {
        get {
        guard let login = UserDefaults.standard.value(forKey: "login") else { return nil }
        return login as? Bool
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "login")
        }}
}

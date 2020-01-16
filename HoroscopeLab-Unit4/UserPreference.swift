//
//  UserPreference.swift
//  HoroscopeLab-Unit4
//
//  Created by Jaheed Haynes on 1/15/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import Foundation

// MARK: User Preference/Settings (Persistance)

struct UserPreferenceKey {
    static let userName = "Jaheed"
    static let sign = "Leo"
    static let listName = "list"
}

class UserPreference {
    private init() {
    }
    static let shared = UserPreference()
    
}

//
//  Model.swift
//  HoroscopeLab-Unit4
//
//  Created by Jaheed Haynes on 1/13/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import Foundation

// MARK: - Element
struct Element: Codable {
    let sunsign: String
    let date: String
    let horoscope: String
    let meta: Meta
}

struct Meta: Codable {
    let mood, keywords, intensity: String
}

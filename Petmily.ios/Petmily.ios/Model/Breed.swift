//
//  Breed.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

enum Breed: String {
    case cat
    case dog
    case etc // 기타 등등
    
    var name: String { rawValue }
}

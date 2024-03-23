//
//  CreateShareInfoSection.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

enum CreateShareInfoSection: Int, CaseIterable {
    case hashtag
    case photo
}

enum CreateShareInfoItem: Hashable {
    case hashtag(String)
    case photo(SelectPhoto)
}

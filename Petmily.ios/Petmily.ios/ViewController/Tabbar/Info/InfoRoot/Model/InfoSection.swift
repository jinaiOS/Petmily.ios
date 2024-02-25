//
//  InfoSection.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

enum InfoSection: Int, CaseIterable {
    case spacer
    case popular
    case share
}

enum InfoItem: Hashable {
    case spacer
    case popular(PopularInfo)
    case share(ShareInfo)
}

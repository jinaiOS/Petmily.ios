//
//  InfoSearchSection.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

enum InfoSearchSection: Int, CaseIterable {
    case category
    case topic
}

enum infoSearchItem: Hashable {
    case category(String)
    case topic(TopicInfo)
}

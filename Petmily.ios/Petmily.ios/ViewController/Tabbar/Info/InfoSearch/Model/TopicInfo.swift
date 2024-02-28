//
//  TopicInfo.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

struct TopicInfo: Hashable {
    let topicID: UUID
    let title: String
    let profileUrl: String
    let content: String
    let contentUrl: String
    let author: String
    let date: Date
}

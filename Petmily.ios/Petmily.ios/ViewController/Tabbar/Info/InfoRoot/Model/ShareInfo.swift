//
//  ShareInfo.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

struct ShareInfo: Codable, Hashable {
    let shareID: UUID
    let title: String
    let content: String
    let author: String
    let hashtag: String
    let profileUrl: String
    let contentImageUrl: String
    var createTime = Date() // Firestore에 Create(작성) 되는 시각이므로 따로 시각 설정하지 않기
    var like: [String] = []
}

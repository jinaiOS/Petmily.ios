//
//  ShareInfo.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

struct ShareInfo: Codable, Hashable {
    let shareID: UUID // 고유 번호 자동 생성
    let title: String
    let content: String
    let author: String
    let hashtag: [String]
    let profileUrl: String
    let contentImageUrl: String
    let createTime: Date // Firestore에 Create(작성) 되는 시각이므로 따로 시각 설정하지 않기
    var like: [String]
    var likeCount: Int
    
    init(title: String, content: String, author: String, hashtag: [String],
         profileUrl: String, contentImageUrl: String) {
        self.shareID = UUID()
        self.title = title
        self.content = content
        self.author = author
        self.hashtag = hashtag
        self.profileUrl = profileUrl
        self.contentImageUrl = contentImageUrl
        self.createTime = Date()
        self.like = []
        self.likeCount = 0
    }
}

//
//  ShareDaily.swift
//  Petmily.ios
//
//  Created by 김지은 on 3/4/24.
//

import Foundation

struct ShareDaily: Codable, Hashable {
    let shareID: UUID // 고유 번호 자동 생성
    let title: String
    let content: String
    let author: String
    let hashtag: [String]
    let profileUrl: String
    var contentVideoUrl: URL
    let createTime: Date // Firestore에 Create(작성) 되는 시각이므로 따로 시각 설정하지 않기
    var like: [String]
    var likeCount: Int
    
    init(title: String, content: String, author: String, hashtag: [String], profileUrl: String, contentVideoUrl: URL) {
        self.shareID = UUID()
        self.title = title
        self.content = content
        self.author = author
        self.hashtag = hashtag
        self.profileUrl = profileUrl
        self.contentVideoUrl = contentVideoUrl
        self.createTime = Date()
        self.like = []
        self.likeCount = 0
    }
}

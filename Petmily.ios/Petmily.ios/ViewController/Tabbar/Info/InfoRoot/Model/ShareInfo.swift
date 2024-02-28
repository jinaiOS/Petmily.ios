//
//  ShareInfo.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

struct ShareInfo: Hashable {
    let shareID: UUID
    let title: String
    let content: String
    let author: String
    let hashtag: String
    let profileUrl: String
    let contentImageUrl: String
}

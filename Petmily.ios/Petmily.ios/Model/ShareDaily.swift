//
//  ShareDaily.swift
//  Petmily.ios
//
//  Created by 김지은 on 3/4/24.
//

import Foundation

struct ShareDaily: Hashable {
    let postID: UUID
    let content: String
    let userID: String
    let contentVideoUrl: String
    let hashtag: String
    let date: Date
    let like: [String]
    let location: String
    let petID: [String]?
}

//
//  InfoDetailViewModel.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

final class InfoDetailViewModel: ObservableObject {
    private(set) var shareInfo: ShareInfo
    
    struct CommentViewModel {
        var commentList: [Comment] = []
    }
    
    @Published private(set) var commentViewModel = CommentViewModel()
    
    init(shareInfo: ShareInfo) {
        self.shareInfo = shareInfo
    }
}

extension InfoDetailViewModel {
    @MainActor
    func setDummyData() async {
        commentViewModel.commentList = [
            Comment(
                state: "BEST1",
                author: "김아무개",
                comment: "사랑스러운 강아지 보고 힘이나요."),
            Comment(
                state: "BEST2",
                author: "홍길동",
                comment: """
                사랑스러운 강아지 보고 힘이나요.
                사랑스러운 강아지 보고 힘이나요.
                사랑스러운 강아지 보고 힘이나요.
                사랑스러운 강아지 보고 힘이나요.
                사랑스러운 강아지 보고 힘이나요.
                """),
            Comment(
                state: "BEST3",
                author: "익명",
                comment: "사랑스러운 강아지 보고 힘이나요."),
            Comment(
                state: "BEST4",
                author: "스티브잡스",
                comment: "사랑스러운 강아지 보고 힘이나요."),
            Comment(
                state: "BEST5",
                author: "팀쿡",
                comment: "사랑스러운 강아지 보고 힘이나요.")
        ]
    }
}

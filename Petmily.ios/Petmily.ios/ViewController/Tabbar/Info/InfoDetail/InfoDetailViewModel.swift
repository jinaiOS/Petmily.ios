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
    }
    
    @Published private(set) var commentViewModel = CommentViewModel()
    let baseHeaderTitle = "반려in"
    
    init(shareInfo: ShareInfo) {
        self.shareInfo = shareInfo
    }
}

extension InfoDetailViewModel {
    @MainActor
    func setDummyData() async {
    }
}

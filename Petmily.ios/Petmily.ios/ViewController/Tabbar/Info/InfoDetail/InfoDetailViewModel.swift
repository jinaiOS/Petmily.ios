//
//  InfoDetailViewModel.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

final class InfoDetailViewModel: ObservableObject {
    private(set) var shareInfo: ShareInfo
    private let shareInfoManager = ShareInfoManager.shared
    private let storageManager = StorageManager.shared
    private let breed: Breed
    
    struct CommentViewModel {
    }
    
    @Published private(set) var commentViewModel = CommentViewModel()
    let baseHeaderTitle = "반려in"
    
    init(shareInfo: ShareInfo, breed: Breed) {
        self.shareInfo = shareInfo
        self.breed = breed
    }
    
    deinit {
        print("deinit - InfoDetailVM")
    }
}

extension InfoDetailViewModel {
    func menuButtonAction(_ button: MenuButtonType) {
        switch button {
        case .edit:
            return
            
        case .delete:
            removeInfo()
            return
            
        case .report:
            return
            
        case .cancel:
            return
        }
    }
    
    func socialButtonAction(_ button: SocialButtonType) {
        switch button {
        case .like:
            return
        case .comment:
            return
        }
    }
}

private extension InfoDetailViewModel {
    func removeInfo() {
        Task {
            do {
                let _ = try await storageManager.deleteContentImage(storageRefName: storageManager.shareInfoPath,
                                                                    spaceRefName: shareInfo.shareID.uuidString)
                let result = await shareInfoManager.removeShareInfo(breed: breed, id: shareInfo.shareID)
                switch result {
                case .success(_):
                    print("Remove ShareInfo: Success")
                    
                case .failure(let error):
                    print("Failure remove ShareInfo: \(error)")
                }
            } catch {
                print("Failure remove ShareInfo: \(error)")
            }
        }
    }
}

extension InfoDetailViewModel {
    @MainActor
    func setDummyData() async {
    }
}

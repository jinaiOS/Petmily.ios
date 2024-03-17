//
//  InfoDetailViewModel.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import Foundation

final class InfoDetailViewModel: ObservableObject {
    private let shareInfoManager = ShareInfoManager.shared
    private let storageManager = StorageManager.shared
    
    struct DetailViewModel {
        var shareInfo: ShareInfo
        var breed: Breed
    }
    
    @Published private(set) var detailViewModel: DetailViewModel
    private let updateSubject: PassthroughSubject<ShareInfo?, Never>
    let baseHeaderTitle = "반려in"
    
    init(shareInfo: ShareInfo, breed: Breed, updateSubject: PassthroughSubject<ShareInfo?, Never>) {
        detailViewModel = DetailViewModel(shareInfo: shareInfo, breed: breed)
        self.updateSubject = updateSubject
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
        case .like(let state):
            switch state {
            case .like:
                print("like")
                
            case .unlike:
                print("unlike")
            }
            return
            
        case .comment:
            print("comment")
            return
        }
    }
}

private extension InfoDetailViewModel {
    func removeInfo() {
        Task {
            do {
                let _ = try await storageManager.deleteContentImage(storageRefName: StorageManager.ImagePath.shareInfoPath,
                                                                    spaceRefName: detailViewModel.shareInfo.shareID.uuidString)
                let result = await shareInfoManager.removeShareInfo(breed: detailViewModel.breed,
                                                                    id: detailViewModel.shareInfo.shareID)
                switch result {
                case .success(_):
                    updateSubject.send(nil)
                    
                case .failure(let error):
                    print("Failure remove ShareInfo: \(error)")
                }
            } catch {
                print("Failure remove ShareInfo: \(error)")
            }
        }
    }
}

//
//  InfoViewModel.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

final class InfoViewModel: ObservableObject {
    struct CollectionViewModels {
        var popularItems: [InfoItem] = []
        var shareItems: [InfoItem] = []
    }
    
    enum HeaderTitle: String {
        case popular = "🥇지금 인기 있는 콘텐츠"
        case share = "정보공유"
        
        var title: String { rawValue }
    }
    
    @Published private(set) var collectionViewModels = CollectionViewModels()
    private let shareInfoManager = ShareInfoManager.shared
    var currentBreed: Breed = .dog
    private let display = 15
    let remainCount = 5
}

extension InfoViewModel {
    func infoItemToShareInfo(item: InfoItem) -> ShareInfo? {
        switch item {
        case .spacer:
            return nil
            
        case .popular(let shareInfo), .share(let shareInfo):
            return shareInfo
        }
    }
}

extension InfoViewModel {
    func createShareInfo(breed: Breed, shareInfo: ShareInfo) async {
        let result = await shareInfoManager.createShareInfo(breed, shareInfo)
        
        switch result {
        case .success(_):
            print("Create ShareInfo: Success")
            
        case .failure(let error):
            print("Failure Create ShareInfo: \(error)")
        }
    }
    
    func fetchShareInfoList(breed: Breed, lastData: ShareInfo?) async {
        let createTime = lastData?.createTime ?? Date()
        let result = await shareInfoManager.getShareInfoList(breed, createTime, display)
        
        switch result {
        case .success(let shareInfoList):
            let newList = shareInfoList.map {
                InfoItem.share($0)
            }
            let uniqueItems = newList.filter { !collectionViewModels.shareItems.contains($0) }
            collectionViewModels.shareItems += uniqueItems
            
        case .failure(let error):
            print("Failure fetch ShareInfoList: \(error)")
        }
    }
}

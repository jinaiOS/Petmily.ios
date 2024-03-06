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
    private let popularSectionDisplay = 9
    private let shareSectionDisplay = 15
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
            print("Failure create ShareInfo: \(error)")
        }
    }
    
    func fetchInfoSectionData(section: InfoSection, breed: Breed, lastData: ShareInfo?) async {
        let createTime = lastData?.createTime ?? Date()
        
        switch section {
        case .spacer: return
            
        case .popular:
            let result = await shareInfoManager.getPopularSectionData(breed, createTime, popularSectionDisplay)
            await resultProcess(section: .popular, result: result)
            
        case .share:
            let result = await shareInfoManager.getShareSectionData(breed, createTime, shareSectionDisplay)
            await resultProcess(section: .share, result: result)
        }
    }
}

private extension InfoViewModel {
    @MainActor
    func resultProcess(section: InfoSection, result: Result<[ShareInfo], FireStoreError>) async {
        switch result {
        case .success(let shareInfoList):
            switch section {
            case .spacer: return
                
            case .popular:
                let newList = shareInfoList.map {
                    InfoItem.popular($0)
                }
                let uniqueItems = newList.filter { !collectionViewModels.popularItems.contains($0) }
                collectionViewModels.popularItems += uniqueItems
                
            case .share:
                let newList = shareInfoList.map {
                    InfoItem.share($0)
                }
                let uniqueItems = newList.filter { !collectionViewModels.shareItems.contains($0) }
                collectionViewModels.shareItems += uniqueItems
            }
            
        case .failure(let error):
            print("Failure fetch ShareInfo \(error)")
        }
    }
}

//
//  InfoViewModel.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import UIKit
import Kingfisher

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
    private let storageManager = StorageManager.shared
    
    let baseHeaderTitle = "반려in"
    private(set) var currentBreed: Breed = .dog
    var tapIndex = IndexPath()
    
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
    
    func resetAllData() {
        collectionViewModels.popularItems.removeAll()
        collectionViewModels.shareItems.removeAll()
    }
    
    func updateData(info: ShareInfo?) {
        switch InfoSection(rawValue: tapIndex.section) {
        case .spacer, .none: return
            
        case .popular:
            guard let info else {
                collectionViewModels.popularItems.remove(at: tapIndex.item)
                return
            }
            // TODO: - 사진 업데이트라면 캐시 메모리에서 사진 초기화 시키기
            collectionViewModels.popularItems[tapIndex.item] = InfoItem.popular(info)
            
        case .share:
            guard let info else {
                collectionViewModels.shareItems.remove(at: tapIndex.item)
                return
            }
            // TODO: - 사진 업데이트라면 캐시 메모리에서 사진 초기화 시키기
            collectionViewModels.shareItems[tapIndex.item] = InfoItem.share(info)
        }
    }
}

extension InfoViewModel {
    func createShareInfo(contentImage: UIImage, breed: Breed, shareInfo: ShareInfo) async {
        var data = shareInfo
        
        do {
            let imageResult = try await storageManager
                .createContentImage(storageRefName: StorageManager.ImagePath.shareInfoPath,
                                    spaceRefName: data.shareID.uuidString,
                                    contentImage: contentImage)
            data.contentImageUrl = imageResult
            let result = await shareInfoManager.createShareInfo(breed: breed, data: data)
            switch result {
            case .success(_):
                print("Create ShareInfo: Success")
                
            case .failure(let error):
                print("Failure create ShareInfo: \(error)")
            }
        } catch {
            print("Failure create contentImage: \(error)")
        }
    }
    
    func fetchInfoSectionData(section: InfoSection, breed: Breed, lastData: ShareInfo?) async {
        let createTime = lastData?.createTime ?? Date()
        
        switch section {
        case .spacer: return
            
        case .popular:
            let result = await shareInfoManager.getPopularSectionData(breed: breed,
                                                                      createTime: createTime,
                                                                      limitCount: popularSectionDisplay)
            await resultProcess(section: .popular, result: result)
            
        case .share:
            let result = await shareInfoManager.getShareSectionData(breed: breed,
                                                                    createTime: createTime,
                                                                    limitCount: shareSectionDisplay)
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

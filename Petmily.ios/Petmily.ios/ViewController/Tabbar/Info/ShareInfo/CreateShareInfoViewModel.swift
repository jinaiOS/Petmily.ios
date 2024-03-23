//
//  CreateShareInfoViewModel.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import UIKit

final class CreateShareInfoViewModel: ObservableObject {
    struct CollectionViewModels {
        var hashtagItems: [CreateShareInfoItem] = []
        var photoItems: [CreateShareInfoItem] = []
    }
    
    @Published private(set) var collectionViewModels = CollectionViewModels()
    @Published var titleStr = ""
    @Published var contentStr = ""
    
    let baseHeaderTitle = "정보 공유 글쓰기"
    let textViewPlaceholder = "반려동물에 관련된 질문이나 이야기를 해보세요."
    
    private(set) lazy var isFormValidPublisher: AnyPublisher<Bool, Never> = Publishers.CombineLatest3($collectionViewModels, $titleStr, $contentStr)
        .map { collectionVM, title, content in
            if collectionVM.hashtagItems.isEmpty || title == "" || content == "" {
                return false
            }
            return true
        }.eraseToAnyPublisher()
    private(set) var readOnlyCurrentSections: (() -> [CreateShareInfoSection])?
    
    init() {
        readOnlyCurrentSections = { [weak self] in
            guard let self else { return [] }
            return getCurrentSections()
        }
    }
    
    deinit {
        print("deinit - CreateShareInfoVM")
    }
}

extension CreateShareInfoViewModel {
    /// - Returns: Scroll 필요 유무, collectionView 높이
    /// - Warning: Cell의 Section이 변경되면 현재 메서드의 Size 변경해 줘야 함
    func getCollectionViewHeight() -> (Bool, CGFloat) {
        let hashtagItems = collectionViewModels.hashtagItems
        let photoItems = collectionViewModels.photoItems
        
        let hashTagSectionHeight = hashtagItems.isEmpty == true ? 0 : Constants.Size.size30 + Constants.Size.size16
        let photoSectionHeight = photoItems.isEmpty == true ? 0 : Constants.Size.size80 + Constants.Size.size16
        let needToScroll: Bool = photoSectionHeight == 0 ? false : true
        return (needToScroll, hashTagSectionHeight + photoSectionHeight)
    }
    
    func removeItem(indexPath: IndexPath) {
        let currentSections = getCurrentSections()
        switch currentSections[indexPath.section] {
        case .hashtag:
            collectionViewModels.hashtagItems.remove(at: indexPath.item)
            
        case .photo:
            collectionViewModels.photoItems.remove(at: indexPath.item)
        }
    }
}

extension CreateShareInfoViewModel {
    func inputHashTagItem(hashtagStr: String) {
        let newStr = replacingString(hashtagStr)
        if checkDuplication(newStr) == false && checkEmpty(newStr) == false {
            Task {
                await resultProcess(item: .hashtag(newStr))
            }
        }
    }
    
    func inputPhotoItem(photo: UIImage) {
        let selectPhoto = SelectPhoto(image: photo)
        Task {
            await resultProcess(item: .photo(selectPhoto))
        }
    }
}

private extension CreateShareInfoViewModel {
    func replacingString(_ str: String) -> String {
        let newStr = str.replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "#", with: "")
            .lowercased()
        return newStr
    }
    
    func checkEmpty(_ str: String) -> Bool {
        if str == "" {
            return true
        }
        return false
    }
    
    func checkDuplication(_ checkStr: String) -> Bool {
        return collectionViewModels.hashtagItems.contains { item in
            switch item {
            case .hashtag(let string):
                if string == checkStr { return true }
                return false
                
            case .photo(_):
                return false
            }
        }
    }
    
    func getCurrentSections() -> [CreateShareInfoSection] {
        var currentSection: [CreateShareInfoSection] = []
        
        if collectionViewModels.hashtagItems.isEmpty != true {
            currentSection.append(.hashtag)
        }
        if collectionViewModels.photoItems.isEmpty != true {
            currentSection.append(.photo)
        }
        return currentSection
    }
}

private extension CreateShareInfoViewModel {
    @MainActor
    func resultProcess(item: CreateShareInfoItem) async {
        switch item {
        case .hashtag(let str):
            let hashtagItem = CreateShareInfoItem.hashtag(str)
            collectionViewModels.hashtagItems.append(hashtagItem)
            
        case .photo(let photo):
            let photoItem = CreateShareInfoItem.photo(photo)
            collectionViewModels.photoItems.append(photoItem)
        }
    }
}

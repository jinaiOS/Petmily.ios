//
//  CreateShareInfoViewModel.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import Foundation

final class CreateShareInfoViewModel: ObservableObject {
    struct CollectionViewModels {
        var hashtagItems: [CreateShareInfoItem] = []
    }
    
    @Published private(set) var collectionViewModels = CollectionViewModels()
    @Published var titleStr = ""
    @Published var contentStr = ""
    
    let baseHeaderTitle = "정보 공유 글쓰기"
    let textViewPlaceholder = "반려동물에 관련된 질문이나 이야기를 해보세요."
    
    private(set) lazy var textFieldOutput: AnyPublisher<Bool, Never> = Publishers.CombineLatest3($collectionViewModels, $titleStr, $contentStr)
        .map { collectionVM, title, content in
            if collectionVM.hashtagItems.isEmpty || title == "" || content == "" {
                return false
            }
            return true
        }.eraseToAnyPublisher()
    
    deinit {
        print("deinit - CreateShareInfoVM")
    }
}

extension CreateShareInfoViewModel {
    func inputHashTag(hashtagStr: String) {
        let newStr = replacingString(hashtagStr)
        let isDuplicate = checkDuplication(newStr)
        let isEmpty = checkEmpty(newStr)
        
        if isDuplicate == false && isEmpty == false {
            Task {
                await makeItem(newStr)
            }
        }
    }
    
    func removeHashTag(index: Int) {
        collectionViewModels.hashtagItems.remove(at: index)
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
            }
        }
    }
    
    @MainActor
    func makeItem(_ str: String) async {
        let item = CreateShareInfoItem.hashtag(str)
        collectionViewModels.hashtagItems.append(item)
    }
}

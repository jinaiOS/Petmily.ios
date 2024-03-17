//
//  InfoSearchViewModel.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import Foundation

final class InfoSearchViewModel: ObservableObject {
    struct CollectionViewModels {
        var categoryItems: [infoSearchItem]?
        var topicItems: [infoSearchItem]?
    }
    
    enum HeaderTitle {
        case category
        case topic(Topic)
        
        enum Topic {
            case main
            case sub
        }
        
        var title: String {
            switch self {
            case .category:
                return "추천 검색어"
                
            case .topic(let topic):
                switch topic {
                case .main:
                    return "반려인은 전부 봤다"
                case .sub:
                    return "운영자 작성 글"
                }
            }
        }
    }
    
    private var loadDataTask: Task<Void, Never>?
    @Published private(set) var collectionViewModels = CollectionViewModels()
    @Published var searchInput: String = "" {
        didSet {
            searchData(text: searchInput)
        }
    }
    @Published var categoryValue: String = ""
    
    deinit {
        loadDataTask?.cancel()
        print("deinit - InfoSearchVM")
    }
}

private extension InfoSearchViewModel {
    func searchData(text: String) {
        loadDataTask = Task {
            print("검색 단어: \(text)")
        }
    }
}

extension InfoSearchViewModel {
    @MainActor
    func setDummyData() async {
        collectionViewModels.categoryItems = [
            infoSearchItem.category("Petmily"),
            infoSearchItem.category("Apple"),
            infoSearchItem.category("강아지"),
            infoSearchItem.category("고양이"),
            infoSearchItem.category("반려동물"),
            infoSearchItem.category("산책"),
            infoSearchItem.category("귀여움"),
            infoSearchItem.category("추천 검색어")
        ]
        
        collectionViewModels.topicItems = [
            infoSearchItem.topic(TopicInfo(
                topicID: UUID(),
                title: "'강아지도 탈모에 걸려요'... 미리 예방하는 강아지 탈모1",
                profileUrl: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEyMTRfMTk5%2FMDAxNzAyNTE2ODg1MDkx.7zAbqYD-eDfIWbTRVmiztfU1Wh2IxmEDGO62kw-SDYUg.uJDQvGRKlcIB-g146enootJ1Xe_NN2lWg2t2SdDGqyQg.JPEG.pnyceo%2Fa3.jpg&type=sc960_832",
                content: "내용1",
                contentUrl: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjA1MDJfMjIg%2FMDAxNjUxNDc3MTU5MTU0.BQQR3PFi0eJYNkhRPC3PzABTlLyAENutlYuhLDWk31cg.-W6vJ5N0It1wLi_wUFmxjou1fbGud-LP_st50OEYBEkg.JPEG.rhythmico%2FRYTM1621-1.jpg&type=sc960_832",
                author: "운영자1",
                date: Date())
            ),
            infoSearchItem.topic(TopicInfo(
                topicID: UUID(),
                title: "'강아지도 탈모에 걸려요'... 미리 예방하는 강아지 탈모2",
                profileUrl: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEyMTRfMTk5%2FMDAxNzAyNTE2ODg1MDkx.7zAbqYD-eDfIWbTRVmiztfU1Wh2IxmEDGO62kw-SDYUg.uJDQvGRKlcIB-g146enootJ1Xe_NN2lWg2t2SdDGqyQg.JPEG.pnyceo%2Fa3.jpg&type=sc960_832",
                content: "내용2",
                contentUrl: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjA1MDJfMjIg%2FMDAxNjUxNDc3MTU5MTU0.BQQR3PFi0eJYNkhRPC3PzABTlLyAENutlYuhLDWk31cg.-W6vJ5N0It1wLi_wUFmxjou1fbGud-LP_st50OEYBEkg.JPEG.rhythmico%2FRYTM1621-1.jpg&type=sc960_832",
                author: "운영자2",
                date: Date())
            ),
            infoSearchItem.topic(TopicInfo(
                topicID: UUID(),
                title: "'강아지도 탈모에 걸려요'... 미리 예방하는 강아지 탈모3",
                profileUrl: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEyMTRfMTk5%2FMDAxNzAyNTE2ODg1MDkx.7zAbqYD-eDfIWbTRVmiztfU1Wh2IxmEDGO62kw-SDYUg.uJDQvGRKlcIB-g146enootJ1Xe_NN2lWg2t2SdDGqyQg.JPEG.pnyceo%2Fa3.jpg&type=sc960_832",
                content: "내용3",
                contentUrl: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjA1MDJfMjIg%2FMDAxNjUxNDc3MTU5MTU0.BQQR3PFi0eJYNkhRPC3PzABTlLyAENutlYuhLDWk31cg.-W6vJ5N0It1wLi_wUFmxjou1fbGud-LP_st50OEYBEkg.JPEG.rhythmico%2FRYTM1621-1.jpg&type=sc960_832",
                author: "운영자3",
                date: Date())
            ),
            infoSearchItem.topic(TopicInfo(
                topicID: UUID(),
                title: "'고양이도 탈모에 걸려요'... 미리 예방하는 고양이 탈모4",
                profileUrl: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEyMTRfMTk5%2FMDAxNzAyNTE2ODg1MDkx.7zAbqYD-eDfIWbTRVmiztfU1Wh2IxmEDGO62kw-SDYUg.uJDQvGRKlcIB-g146enootJ1Xe_NN2lWg2t2SdDGqyQg.JPEG.pnyceo%2Fa3.jpg&type=sc960_832",
                content: "내용4",
                contentUrl: "https://meeco.kr/files/attach/images/24268070/925/987/027/11b63f0d68eaa1cea44b1e394c92d9e6.jpg",
                author: "운영자4",
                date: Date())
            ),
            infoSearchItem.topic(TopicInfo(
                topicID: UUID(),
                title: "'고양이도 탈모에 걸려요'... 미리 예방하는 고양이 탈모5",
                profileUrl: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEyMTRfMTk5%2FMDAxNzAyNTE2ODg1MDkx.7zAbqYD-eDfIWbTRVmiztfU1Wh2IxmEDGO62kw-SDYUg.uJDQvGRKlcIB-g146enootJ1Xe_NN2lWg2t2SdDGqyQg.JPEG.pnyceo%2Fa3.jpg&type=sc960_832",
                content: "내용5",
                contentUrl: "https://meeco.kr/files/attach/images/24268070/925/987/027/11b63f0d68eaa1cea44b1e394c92d9e6.jpg",
                author: "운영자5",
                date: Date())
            ),
            infoSearchItem.topic(TopicInfo(
                topicID: UUID(),
                title: "'고양이도 탈모에 걸려요'... 미리 예방하는 고양이 탈모6",
                profileUrl: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEyMTRfMTk5%2FMDAxNzAyNTE2ODg1MDkx.7zAbqYD-eDfIWbTRVmiztfU1Wh2IxmEDGO62kw-SDYUg.uJDQvGRKlcIB-g146enootJ1Xe_NN2lWg2t2SdDGqyQg.JPEG.pnyceo%2Fa3.jpg&type=sc960_832",
                content: "내용6",
                contentUrl: "https://meeco.kr/files/attach/images/24268070/925/987/027/11b63f0d68eaa1cea44b1e394c92d9e6.jpg",
                author: "운영자6",
                date: Date())
            ),
            infoSearchItem.topic(TopicInfo(
                topicID: UUID(),
                title: "'고양이도 탈모에 걸려요'... 미리 예방하는 고양이 탈모7",
                profileUrl: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEyMTRfMTk5%2FMDAxNzAyNTE2ODg1MDkx.7zAbqYD-eDfIWbTRVmiztfU1Wh2IxmEDGO62kw-SDYUg.uJDQvGRKlcIB-g146enootJ1Xe_NN2lWg2t2SdDGqyQg.JPEG.pnyceo%2Fa3.jpg&type=sc960_832",
                content: "내용7",
                contentUrl: "https://meeco.kr/files/attach/images/24268070/925/987/027/11b63f0d68eaa1cea44b1e394c92d9e6.jpg",
                author: "운영자7",
                date: Date())
            ),
            infoSearchItem.topic(TopicInfo(
                topicID: UUID(),
                title: "'고양이도 탈모에 걸려요'... 미리 예방하는 고양이 탈모8",
                profileUrl: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEyMTRfMTk5%2FMDAxNzAyNTE2ODg1MDkx.7zAbqYD-eDfIWbTRVmiztfU1Wh2IxmEDGO62kw-SDYUg.uJDQvGRKlcIB-g146enootJ1Xe_NN2lWg2t2SdDGqyQg.JPEG.pnyceo%2Fa3.jpg&type=sc960_832",
                content: "내용8",
                contentUrl: "https://meeco.kr/files/attach/images/24268070/925/987/027/11b63f0d68eaa1cea44b1e394c92d9e6.jpg",
                author: "운영자8",
                date: Date())
            ),
            infoSearchItem.topic(TopicInfo(
                topicID: UUID(),
                title: "'고양이도 탈모에 걸려요'... 미리 예방하는 고양이 탈모9",
                profileUrl: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEyMTRfMTk5%2FMDAxNzAyNTE2ODg1MDkx.7zAbqYD-eDfIWbTRVmiztfU1Wh2IxmEDGO62kw-SDYUg.uJDQvGRKlcIB-g146enootJ1Xe_NN2lWg2t2SdDGqyQg.JPEG.pnyceo%2Fa3.jpg&type=sc960_832",
                content: "내용9",
                contentUrl: "https://meeco.kr/files/attach/images/24268070/925/987/027/11b63f0d68eaa1cea44b1e394c92d9e6.jpg",
                author: "운영자9",
                date: Date())
            ),
            infoSearchItem.topic(TopicInfo(
                topicID: UUID(),
                title: "'고양이도 탈모에 걸려요'... 미리 예방하는 고양이 탈모10",
                profileUrl: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEyMTRfMTk5%2FMDAxNzAyNTE2ODg1MDkx.7zAbqYD-eDfIWbTRVmiztfU1Wh2IxmEDGO62kw-SDYUg.uJDQvGRKlcIB-g146enootJ1Xe_NN2lWg2t2SdDGqyQg.JPEG.pnyceo%2Fa3.jpg&type=sc960_832",
                content: "내용10",
                contentUrl: "https://meeco.kr/files/attach/images/24268070/925/987/027/11b63f0d68eaa1cea44b1e394c92d9e6.jpg",
                author: "운영자10",
                date: Date())
            ),
            infoSearchItem.topic(TopicInfo(
                topicID: UUID(),
                title: "'고양이도 탈모에 걸려요'... 미리 예방하는 고양이 탈모11",
                profileUrl: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEyMTRfMTk5%2FMDAxNzAyNTE2ODg1MDkx.7zAbqYD-eDfIWbTRVmiztfU1Wh2IxmEDGO62kw-SDYUg.uJDQvGRKlcIB-g146enootJ1Xe_NN2lWg2t2SdDGqyQg.JPEG.pnyceo%2Fa3.jpg&type=sc960_832",
                content: "내용11",
                contentUrl: "https://meeco.kr/files/attach/images/24268070/925/987/027/11b63f0d68eaa1cea44b1e394c92d9e6.jpg",
                author: "운영자11",
                date: Date())
            ),
            infoSearchItem.topic(TopicInfo(
                topicID: UUID(),
                title: "'고양이도 탈모에 걸려요'... 미리 예방하는 고양이 탈모12",
                profileUrl: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEyMTRfMTk5%2FMDAxNzAyNTE2ODg1MDkx.7zAbqYD-eDfIWbTRVmiztfU1Wh2IxmEDGO62kw-SDYUg.uJDQvGRKlcIB-g146enootJ1Xe_NN2lWg2t2SdDGqyQg.JPEG.pnyceo%2Fa3.jpg&type=sc960_832",
                content: "내용12",
                contentUrl: "https://meeco.kr/files/attach/images/24268070/925/987/027/11b63f0d68eaa1cea44b1e394c92d9e6.jpg",
                author: "운영자12",
                date: Date())
            )
        ]
    }
}

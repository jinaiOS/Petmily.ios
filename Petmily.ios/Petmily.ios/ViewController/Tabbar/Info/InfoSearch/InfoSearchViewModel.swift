//
//  InfoSearchViewModel.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

final class InfoSearchViewModel: ObservableObject {
    struct CollectionViewModels {
        
        let category = ["Petmily", "Apple", "강아지", "고양이", "반려동물", "산책", "귀여움", "추천 검색어"]
        
        let title = "'강아지도 탈모에 걸려요'... 미리 예방하는 강아지 탈모"
        let profileUrl = "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEyMTRfMTk5%2FMDAxNzAyNTE2ODg1MDkx.7zAbqYD-eDfIWbTRVmiztfU1Wh2IxmEDGO62kw-SDYUg.uJDQvGRKlcIB-g146enootJ1Xe_NN2lWg2t2SdDGqyQg.JPEG.pnyceo%2Fa3.jpg&type=sc960_832"
        let author = "운영자"
        let date = "2월 23일"
        let contentImageUrl = "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjA1MDJfMjIg%2FMDAxNjUxNDc3MTU5MTU0.BQQR3PFi0eJYNkhRPC3PzABTlLyAENutlYuhLDWk31cg.-W6vJ5N0It1wLi_wUFmxjou1fbGud-LP_st50OEYBEkg.JPEG.rhythmico%2FRYTM1621-1.jpg&type=sc960_832"
        
        let headerTitle = "반려인은 전부 봤다"
        let subTitle = "운영자 작성 글"
    }
    
    @Published private(set) var collectionViewModels = CollectionViewModels()
}

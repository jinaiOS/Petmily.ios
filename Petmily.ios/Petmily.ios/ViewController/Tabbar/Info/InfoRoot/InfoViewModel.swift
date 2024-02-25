//
//  InfoViewModel.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

final class InfoViewModel: ObservableObject {
    struct CollectionViewModels {
        var popularItems: [InfoItem]?
        var shareItems: [InfoItem]?
    }
    
    enum HeaderTitle: String {
        case popular = "🥇지금 인기 있는 콘텐츠"
        case share = "정보공유"
        
        var title: String { rawValue }
    }
    
    @Published private(set) var collectionViewModels = CollectionViewModels()
}

extension InfoViewModel {
    var makeShareInfo: [ShareInfo] {
        if let items = collectionViewModels.shareItems {
            return items.compactMap { infoItem -> ShareInfo? in
                switch infoItem {
                case .spacer:
                    return nil
                    
                case .popular(_):
                    return nil
                    
                case .share(let shareInfo):
                    return shareInfo
                }
            }
        }
        return []
    }
}

extension InfoViewModel {
    @MainActor
    func setDummyData() async {
        collectionViewModels.popularItems = [
            InfoItem.popular(
                PopularInfo(thumbnailUrl: "https://mblogthumb-phinf.pstatic.net/MjAxNzA0MDNfMzQg/MDAxNDkxMTg4NzEyMDYz.8F6HI-zibQXRsxR_Sy0nQFRRBY1h4XkhUFFmUUkD7Bkg.B5xEZHBHwyBdtynCQUHND8C5CPH3cHhM093JEkROJpsg.JPEG.truthy2000/10.jpg?type=w800",
                            profileUrl: "https://thumb.mt.co.kr/06/2021/07/2021070813140171986_3.jpg/dims/optimize/",
                            hashtag: "#강아지 #애견샵")
            ),
            InfoItem.popular(
                PopularInfo(thumbnailUrl: "https://mblogthumb-phinf.pstatic.net/MjAxNzA0MDNfMzQg/MDAxNDkxMTg4NzEyMDYz.8F6HI-zibQXRsxR_Sy0nQFRRBY1h4XkhUFFmUUkD7Bkg.B5xEZHBHwyBdtynCQUHND8C5CPH3cHhM093JEkROJpsg.JPEG.truthy2000/10.jpg?type=w800",
                            profileUrl: "https://thumb.mt.co.kr/06/2021/07/2021070813140171986_3.jpg/dims/optimize/",
                            hashtag: "#강아지 #팬션")
            ),
            InfoItem.popular(
                PopularInfo(thumbnailUrl: "https://mblogthumb-phinf.pstatic.net/MjAxNzA0MDNfMzQg/MDAxNDkxMTg4NzEyMDYz.8F6HI-zibQXRsxR_Sy0nQFRRBY1h4XkhUFFmUUkD7Bkg.B5xEZHBHwyBdtynCQUHND8C5CPH3cHhM093JEkROJpsg.JPEG.truthy2000/10.jpg?type=w800",
                            profileUrl: "https://thumb.mt.co.kr/06/2021/07/2021070813140171986_3.jpg/dims/optimize/",
                            hashtag: "#강아지 #사료")
            ),
            InfoItem.popular(
                PopularInfo(thumbnailUrl: "https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202306/25/488f9638-800c-4bac-ad65-82877fbff79b.jpg",
                            profileUrl: "https://thumb.mt.co.kr/06/2021/07/2021070813140171986_3.jpg/dims/optimize/",
                            hashtag: "#강아지 #병원")
            ),
            InfoItem.popular(
                PopularInfo(thumbnailUrl: "https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202306/25/488f9638-800c-4bac-ad65-82877fbff79b.jpg",
                            profileUrl: "https://thumb.mt.co.kr/06/2021/07/2021070813140171986_3.jpg/dims/optimize/",
                            hashtag: "#고양이 #자랑")
            )
        ]
        
        collectionViewModels.shareItems = [
            InfoItem.share(
                ShareInfo(
                    title: "우리집 강아지를 자랑합니다.",
                    content: "귀여운 강아지 봐주세요~",
                    author: "작성자: 홍길동",
                    hashtag: "#강아지 #자유로운 #귀여운",
                    profileUrl: "https://www.handmk.com/news/photo/202306/16714_40371_5250.jpg",
                    contentImageUrl: "https://d1bg8rd1h4dvdb.cloudfront.net/upload/imgServer/storypick/editor/2019052111361692611.jpg")
            ),
            InfoItem.share(
                ShareInfo(
                    title: "강아지 자랑!!!",
                    content: "우리집 강아지 봐주세요~",
                    author: "작성자: 김개똥",
                    hashtag: "#강아지 #자유로운 #사랑스러운",
                    profileUrl: "https://www.handmk.com/news/photo/202306/16714_40371_5250.jpg",
                    contentImageUrl: "https://d1bg8rd1h4dvdb.cloudfront.net/upload/imgServer/storypick/editor/2019052111361692611.jpg")
            ),
            InfoItem.share(
                ShareInfo(
                    title: "강아지를 자랑",
                    content: "강아지보고 힐링하고 가세요~",
                    author: "작성자: 익명",
                    hashtag: "#강아지 #힐링 #귀여운 #자랑",
                    profileUrl: "https://www.handmk.com/news/photo/202306/16714_40371_5250.jpg",
                    contentImageUrl: "https://d1bg8rd1h4dvdb.cloudfront.net/upload/imgServer/storypick/editor/2019052111361692611.jpg")
            ),
            InfoItem.share(
                ShareInfo(
                    title: "우리집 고양이 자랑",
                    content: "사랑스러운 고양이 봐주세요~",
                    author: "작성자: 이루리",
                    hashtag: "#고양이 #사랑스러운 #귀여운",
                    profileUrl: "https://www.handmk.com/news/photo/202306/16714_40371_5250.jpg",
                    contentImageUrl: "https://cat-lab.co.kr/data/editor/2203/4fea39b9ee8ab23e62522153035041fc_1646215721_8448.jpg")
            ),
            InfoItem.share(
                ShareInfo(
                    title: "우리집 고양이를 자랑합니다.",
                    content: "귀여운 고양이 봐주세요~",
                    author: "작성자: 아무나",
                    hashtag: "#고양이 #자유로운 #귀여운",
                    profileUrl: "https://www.handmk.com/news/photo/202306/16714_40371_5250.jpg",
                    contentImageUrl: "https://cat-lab.co.kr/data/editor/2203/4fea39b9ee8ab23e62522153035041fc_1646215721_8448.jpg")
            )
        ]
    }
}

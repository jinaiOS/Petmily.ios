//
//  InfoDetailViewController.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import SwiftUI
import UIKit

final class InfoDetailViewController: BaseHeaderViewController {
    private let infoDetailView: InfoDetailView
    private let infoDetailViewModel: InfoDetailViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(_ shareInfo: ShareInfo) {
        infoDetailViewModel = InfoDetailViewModel(shareInfo: shareInfo)
        infoDetailView = InfoDetailView(info: infoDetailViewModel.shareInfo)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = infoDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setBaseHeaderView()
        bindViewModel()
        Task {
            await infoDetailViewModel.setDummyData()
        }
    }
    
    deinit {
        print("deinit - InfoDetailVC")
    }
}

private extension InfoDetailViewController {
    func configure() {
        view.backgroundColor = .systemBackground
    }
    
    func setBaseHeaderView() {
        let title = NSMutableAttributedString(
            string: "반려in",
            attributes: [.font: ThemeFont.header])
        headerView.titleLabel.attributedText = title
    }
    
    func bindViewModel() {
        infoDetailViewModel.$commentViewModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
            }.store(in: &cancellables)
    }
}

// MARK: - Preview
struct InfoDetailVC_PreView: PreviewProvider {
    static var previews: some View {
        let dummyInfo = ShareInfo(
            title: "우리집 강쥐 자랑",
            content: """
                강아지 자랑 내용 첨부1
                강아지 자랑 내용 첨부2
                강아지 자랑 내용 첨부3
                강아지 자랑 내용 첨부4
                강아지 자랑 내용 첨부5
                강아지 자랑 내용 첨부6
                강아지 자랑 내용 첨부7
                강아지 자랑 내용 첨부8
                강아지 자랑 내용 첨부9
                강아지 자랑 내용 첨부10
                """,
            author: "아이언맨",
            hashtag: "#자유로운 #강아지 #매력 #자랑",
            profileUrl: "https://www.handmk.com/news/photo/202306/16714_40371_5250.jpg",
            contentImageUrl: "https://flexible.img.hani.co.kr/flexible/normal/850/567/imgdb/original/2023/0111/20230111503366.jpg")
        InfoDetailViewController(dummyInfo).toPreview()
    }
}

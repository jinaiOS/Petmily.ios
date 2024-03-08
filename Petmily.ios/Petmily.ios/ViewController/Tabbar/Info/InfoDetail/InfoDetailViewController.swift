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
    private let didTapMoreButton = PassthroughSubject<MenuButtonType, Never>()
    private let didTapSocialButton = PassthroughSubject<SocialButtonType, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init(_ shareInfo: ShareInfo, _ breed: Breed) {
        infoDetailViewModel = InfoDetailViewModel(shareInfo: shareInfo, breed: breed)
        infoDetailView = InfoDetailView(infoDetailViewModel.shareInfo,
                                        didTapMoreButton,
                                        didTapSocialButton)
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
        bindButton()
        bindViewModel()
        
        print("\(infoDetailViewModel.shareInfo)")
    }
    
    deinit {
        print("deinit - InfoDetailVC")
    }
}

private extension InfoDetailViewController {
    func configure() {
        view.backgroundColor = ThemeColor.systemBackground
    }
    
    func setBaseHeaderView() {
        let title = NSMutableAttributedString(
            string: infoDetailViewModel.baseHeaderTitle,
            attributes: [.font: ThemeFont.b24])
        headerView.titleLabel.attributedText = title
    }
}

private extension InfoDetailViewController {
    func bindButton() {
        didTapMoreButton
            .receive(on: DispatchQueue.main)
            .sink { [weak self] type in
                guard let self else { return }
                if type == .delete {
                    showAlert()
                    return
                }
                infoDetailViewModel.menuButtonAction(type)
                
            }.store(in: &cancellables)
        
        // TODO: - 좋아요는 debounce, throttle 적용, 댓글은 즉시 이벤트 처리하기
        didTapSocialButton
            .receive(on: DispatchQueue.main)
            .sink { [weak self] type in
                guard let self else { return }
                infoDetailViewModel.socialButtonAction(type)
            }.store(in: &cancellables)
    }
    
    func bindViewModel() {
        infoDetailViewModel.$commentViewModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
            }.store(in: &cancellables)
    }
}

private extension InfoDetailViewController {
    func showAlert() {
        let alert = AlertFactory.makeAlert(
            title: "삭제하시겠습니까?",
            message: "삭제하면 복구할 수 없습니다.",
            style: .alert,
            action1Title: "취소",
            action1Style: .cancel,
            action2Title: "삭제",
            action2Style: .destructive) {
                self.infoDetailViewModel.menuButtonAction(.delete)
                self.navigationPopViewController(animated: true, completion: nil)
            }
        present(alert, animated: true)
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
                """,
            author: "아이언맨",
            hashtag: ["강아지", "힐링", "귀여운", "자랑"],
            profileUrl: "https://www.handmk.com/news/photo/202306/16714_40371_5250.jpg")
        InfoDetailViewController(dummyInfo, .dog).toPreview()
    }
}

//
//  InfoDetailContentView.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import Kingfisher
import SnapKit
import UIKit

final class InfoDetailContentView: UIView {
    private var didTapMoreButton: PassthroughSubject<MenuButtonType, Never>
    private var didTapSocialButton: PassthroughSubject<SocialButtonType, Never>
    
    private let spacerView1 = UIView()
    private let spacerView2 = UIView()
    private let spacerView3 = UIView()
    private let spacerView4 = UIView()
    private let spacerView5 = UIView()
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.cornerRadius = Constants.Size.size50 / 2
        view.clipsToBounds = true
        
        view.snp.makeConstraints {
            $0.width.height.equalTo(Constants.Size.size50)
        }
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.b22
        label.textColor = ThemeColor.black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.r16
        label.textColor = ThemeColor.darkGray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var labelVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Constants.Spacing.spacing4
        
        [titleLabel, authorLabel].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var editAction = UIAction(title: "수정",
                                           image: PetmilyImage.pencil) { [weak self] _ in
        guard let self else { return }
        Task {
            await self.moreBtnAction(buttonType: .edit)
        }
    }
    
    private lazy var deleteAction = UIAction(title: "삭제",
                                             image: PetmilyImage.trashFill,
                                             attributes: .destructive) { [weak self] _ in
        guard let self else { return }
        Task {
            await self.moreBtnAction(buttonType: .delete)
        }
    }
    
    private lazy var reportAction = UIAction(title: "신고",
                                             image: PetmilyImage.lightBeacon,
                                             attributes: .hidden) { [weak self] _ in
        guard let self else { return }
        Task {
            await self.moreBtnAction(buttonType: .report)
        }
    }
    
    private lazy var cancelAction = UIAction(title: "취소") { [weak self] _ in
        guard let self else { return }
        Task {
            await self.moreBtnAction(buttonType: .cancel)
        }
    }
    
    private lazy var moreButton = UIMenu(title: "더보기",
                                         children: [editAction, deleteAction, reportAction, cancelAction])
    
    private lazy var moreButon: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(PetmilyImage.ellipsis, for: .normal)
        button.tintColor = ThemeColor.black
        button.contentHorizontalAlignment = .right
        button.menu = moreButton
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        
        [profileImageView, labelVStack, moreButon].forEach {
            stack.addArrangedSubview($0)
        }
        labelVStack.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(Constants.Size.size10)
            $0.trailing.equalTo(moreButon.snp.leading).offset(-Constants.Size.size10)
        }
        return stack
    }()
    
    private lazy var contentImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.cornerRadius = Constants.Radius.radius13
        return view
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = ThemeColor.black
        label.font = ThemeFont.m18
        return label
    }()
    
    private lazy var hashtagLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = ThemeColor.black
        label.textAlignment = .right
        label.font = ThemeFont.r14
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(PetmilyImage.like, for: .normal)
        button.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            Task {
                await self.socialBtnAction(buttonType: .like)
            }
        }), for: .touchUpInside)
        return button
    }()
    
    private lazy var showCommentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(PetmilyImage.union, for: .normal)
        button.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            Task {
                await self.socialBtnAction(buttonType: .comment)
            }
        }), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Constants.Spacing.spacing11
        
        [likeButton, showCommentButton, spacerView5].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        
        [hStack, spacerView1, contentImageView, spacerView2, contentLabel,
         spacerView3, hashtagLabel, spacerView4, buttonHStack].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    init(_ info: ShareInfo,
         _ menuBtnSubject: PassthroughSubject<MenuButtonType, Never>,
         _ socialBtnSubject: PassthroughSubject<SocialButtonType, Never>) {
        didTapMoreButton = menuBtnSubject
        didTapSocialButton = socialBtnSubject
        super.init(frame: .zero)
        
        setLayout()
        setViewModel(info: info)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension InfoDetailContentView {
    func setLayout() {
        addSubview(vStack)
        
        vStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Constants.Spacing.spacing24)
        }
        
        spacerView1.snp.makeConstraints {
            $0.height.equalTo(Constants.Size.size8)
        }
        
        spacerView2.snp.makeConstraints {
            $0.height.equalTo(Constants.Size.size20)
        }
        
        spacerView3.snp.makeConstraints {
            $0.height.equalTo(Constants.Size.size26)
        }
        
        spacerView4.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(Constants.Size.size26)
        }
        
        contentImageView.snp.makeConstraints {
            $0.height.equalTo(contentImageView.snp.width)
        }
        
        moreButon.snp.makeConstraints {
            $0.width.height.equalTo(Constants.Size.size50)
        }
        
        likeButton.snp.makeConstraints {
            $0.width.height.equalTo(Constants.Size.size40)
        }
        
        showCommentButton.snp.makeConstraints {
            $0.width.height.equalTo(Constants.Size.size40)
        }
    }
}

private extension InfoDetailContentView {
    func setViewModel(info: ShareInfo) {
        let profileUrl = URL(string: info.profileUrl)
        let contentImageUrl = URL(string: info.contentImageUrl)
        
        profileImageView.kf.setImage(with: profileUrl)
        contentImageView.kf.setImage(with: contentImageUrl)
        titleLabel.text = info.title
        authorLabel.text = info.author
        contentLabel.text = info.content
        hashtagLabel.text = "#" + info.hashtag.joined(separator: " #")
    }
}

private extension InfoDetailContentView {
    @MainActor
    func moreBtnAction(buttonType: MenuButtonType) async {
        switch buttonType {
        case .edit:
            moreButon.setImage(PetmilyImage.pencil, for: .normal)
            didTapMoreButton.send(.edit)
            
        case .delete:
            moreButon.setImage(PetmilyImage.trashFill, for: .normal)
            didTapMoreButton.send(.delete)
            
        case .report:
            moreButon.setImage(PetmilyImage.lightBeacon, for: .normal)
            didTapMoreButton.send(.report)
            
        case .cancel:
            moreButon.setImage(PetmilyImage.ellipsis, for: .normal)
            didTapMoreButton.send(.cancel)
        }
    }
    
    @MainActor
    func socialBtnAction(buttonType: SocialButtonType) async {
        switch buttonType {
        case .like:
            didTapSocialButton.send(.like)
            
        case .comment:
            didTapSocialButton.send(.comment)
        }
    }
}

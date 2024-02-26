//
//  InfoDetailContentView.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Kingfisher
import SnapKit
import UIKit

final class InfoDetailContentView: UIView {
    private let shareInfo: ShareInfo
    
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
        let profileUrl = URL(string: shareInfo.profileUrl)
        view.kf.setImage(with: profileUrl)
        
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
        label.text = shareInfo.title
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.r16
        label.textColor = ThemeColor.darkGray
        label.textAlignment = .left
        label.text = shareInfo.author
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
    
    private lazy var moreButon: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(PetmilyImage.ellipsis, for: .normal)
        button.tintColor = ThemeColor.black
        button.contentHorizontalAlignment = .right
        
        button.snp.makeConstraints {
            $0.width.height.equalTo(Constants.Size.size50)
        }
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
        let contentImageUrl = URL(string: shareInfo.contentImageUrl)
        view.kf.setImage(with: contentImageUrl)
        return view
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = ThemeColor.black
        label.font = ThemeFont.m18
        label.text = shareInfo.content
        return label
    }()
    
    private lazy var hashtagLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = ThemeColor.black
        label.textAlignment = .right
        label.font = ThemeFont.r14
        label.text = shareInfo.hashtag
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(PetmilyImage.like, for: .normal)
        
        button.snp.makeConstraints {
            $0.width.height.equalTo(Constants.Size.size42)
        }
        return button
    }()
    
    private lazy var showCommentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(PetmilyImage.union, for: .normal)
        
        button.snp.makeConstraints {
            $0.width.height.equalTo(Constants.Size.size42)
        }
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
    
    init(info: ShareInfo) {
        shareInfo = info
        super.init(frame: .zero)
        
        setLayout()
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
    }
}

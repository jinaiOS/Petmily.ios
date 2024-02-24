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
    
    private lazy var profileImageView: UIImageView = {
        let imageSize: CGFloat = 50
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.cornerRadius = imageSize / 2
        view.clipsToBounds = true
        let profileUrl = URL(string: shareInfo.profileUrl)
        view.kf.setImage(with: profileUrl)
        
        view.snp.makeConstraints {
            $0.width.height.equalTo(imageSize)
        }
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.text = shareInfo.title
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.text = shareInfo.author
        return label
    }()
    
    private lazy var labelVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 4
        
        [titleLabel, authorLabel].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var moreButon: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(PetmilyImage.ellipsis, for: .normal)
        button.tintColor = .black
        button.contentHorizontalAlignment = .right
        
        button.snp.makeConstraints {
            $0.width.height.equalTo(50)
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
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(moreButon.snp.leading).offset(-10)
        }
        return stack
    }()
    
    private lazy var contentImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.cornerRadius = 13
        let contentImageUrl = URL(string: shareInfo.contentImageUrl)
        view.kf.setImage(with: contentImageUrl)
        return view
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = shareInfo.content
        return label
    }()
    
    private lazy var hashtagLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = shareInfo.hashtag
        return label
    }()
    
    private lazy var commentTextField: UITextField = {
        let textField = UITextField()
        textField.cornerRadius = 17.5
        textField.borderStyle = .none
        textField.borderColor = .darkGray
        textField.borderWidth = 2
        textField.placeholder = "텍스트 입력"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width:50, height: 0))
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        return textField
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .darkGray
        
        button.imageView?.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return button
    }()
    
    private let emptyView1 = UIView()
    private let emptyView2 = UIView()
    private let emptyView3 = UIView()
    private let emptyView4 = UIView()
    private let emptyView5 = UIView()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        
        [hStack, emptyView1, contentImageView, emptyView2, contentLabel,
         emptyView3, hashtagLabel, emptyView4, commentTextField, emptyView5].forEach {
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
        let insetSpacing: CGFloat = 24
        
        [vStack, commentButton].forEach {
            addSubview($0)
        }
        
        vStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(insetSpacing)
        }
        
        emptyView1.snp.makeConstraints {
            $0.height.equalTo(8)
        }
        
        emptyView2.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        emptyView3.snp.makeConstraints {
            $0.height.equalTo(26)
        }
        
        emptyView4.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(26)
        }
        
        emptyView5.snp.makeConstraints {
            $0.height.equalTo(16)
        }
        
        contentImageView.snp.makeConstraints {
            $0.height.equalTo(contentImageView.snp.width)
        }
        
        commentTextField.snp.makeConstraints {
            $0.height.equalTo(35)
        }
        
        commentButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalTo(commentTextField)
            $0.trailing.equalTo(commentTextField.snp.trailing).inset(17)
        }
    }
}

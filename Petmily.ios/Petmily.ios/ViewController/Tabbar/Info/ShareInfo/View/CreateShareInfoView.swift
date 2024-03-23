//
//  CreateShareInfoView.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class CreateShareInfoView: UIView {
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = ThemeColor.black
        button.titleLabel?.font = ThemeFont.b20
        button.setTitle("완료", for: .normal)
        button.isEnabled = false
        return button
    }()
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    let hashtagTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.keyboardType = .default
        textField.font = ThemeFont.r16
        textField.textColor = ThemeColor.label
        textField.placeholder = "해시 태그를 입력해 주세요."
        return textField
    }()
    
    private let underLine: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.lightGray
        
        view.snp.makeConstraints {
            $0.height.equalTo(Constants.Size.size1)
        }
        return view
    }()
    
    let collectionView: DynamicCollectionView
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.keyboardType = .default
        textField.font = ThemeFont.b22
        textField.textColor = ThemeColor.label
        textField.placeholder = "제목을 입력해 주세요."
        return textField
    }()
    
    private lazy var vStack = StackFactory.makeStackView(spacing: Constants.Spacing.spacing16,
                                                         subViews: [hashtagTextField, underLine, collectionView, titleTextField])
    
    let contentTextView: UITextView = {
        let view = UITextView()
        view.keyboardType = .default
        view.keyboardDismissMode = .none
        view.returnKeyType = .next
        view.font = ThemeFont.r16
        view.textColor = ThemeColor.lightGray
        view.text = "반려동물에 관련된 질문이나 이야기를 해보세요."
        return view
    }()
    
    let photoButton: UIButton = {
        let buttton = UIButton(type: .system)
        buttton.setImage(PetmilyImage.photo, for: .normal)
        buttton.tintColor = ThemeColor.label
        return buttton
    }()
    
    private let photoLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.r16
        label.textColor = ThemeColor.label
        label.text = "사진"
        return label
    }()
    
    private lazy var photoSelectHStack = StackFactory.makeStackView(axis: .horizontal,
                                                                    spacing: Constants.Spacing.spacing8,
                                                                    subViews: [photoButton, photoLabel, UIView()])
    
    private let spacerView = UIView()
    
    init(_ readOnlyCurrentSections: (() -> [CreateShareInfoSection])?) {
        collectionView = DynamicCollectionView(readOnlyCurrentSections)
        super.init(frame: .zero)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CreateShareInfoView {
    @MainActor
    func remakeHashTagConstraints(collectionHeight: CGFloat) async {
        collectionView.snp.remakeConstraints {
            $0.height.equalTo(collectionHeight)
        }
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            layoutIfNeeded()
        }
    }
    
    @MainActor
    func remakeKeyboardConstraints(keyboardHight: CGFloat = 0) async {
        let spacerHeight = keyboardHight == 0 ? Constants.Size.size50 : Constants.Size.size16
        
        spacerView.snp.remakeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(keyboardHight + spacerHeight)
        }
    }
}

private extension CreateShareInfoView {
    func setLayout() {
        [scrollView, spacerView].forEach {
            addSubview($0)
        }
        
        scrollView.addSubview(containerView)
        
        [vStack, contentTextView, photoSelectHStack].forEach {
            containerView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(Constants.Size.size16)
        }
        
        containerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        vStack.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(vStack.snp.bottom).offset(Constants.Size.size16)
            $0.leading.trailing.equalToSuperview()
        }
        
        photoSelectHStack.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottom).offset(Constants.Size.size16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        spacerView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Constants.Size.size50)
        }
    }
}

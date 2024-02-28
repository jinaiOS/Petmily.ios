//
//  InfoSearchContentView.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoSearchContentView: UIView {
    lazy var searchTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.placeholder = "검색어를 입력해주세요"
        return field
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(PetmilyImage.search, for: .normal)
        
        button.snp.makeConstraints {
            $0.width.height.equalTo(Constants.Size.size33)
        }
        return button
    }()
    
    private let underLine: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.black
        
        view.snp.makeConstraints {
            $0.height.equalTo(Constants.Size.size2)
        }
        return view
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = Constants.Spacing.spacing5
        
        [searchTextField, searchButton].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Constants.Spacing.spacing6
        
        [hStack, underLine].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension InfoSearchContentView {
    func setLayout() {
        addSubview(vStack)
        
        vStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

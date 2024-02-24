//
//  MyPageSettingViewController.swift
//  Petmily.ios
//
//  Created by JINHUN CHOI on 2024/02/23.
//

import UIKit

import SnapKit

class MyPageSettingViewController: UIViewController {
    //MARK: Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let profileTitle: UILabel = {
       let label = UILabel()
        label.text = "프로필 설정"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var profileStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameStackView, ageStackView, breedStackView, completeButton])
        view.axis = .vertical
        view.spacing = 20
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "photo")
        return view
    }()
    
    private let profileNickName: UITextField = {
        let field = UITextField()
        field.placeholder = "닉네임을 입력해주세요."
        return field
    }()
    
    private let nameStackView = CustomStackView(text: "동물 이름", placeholder: "이름")
    private let ageStackView = CustomStackView(text: "동물 나이", placeholder: "나이")
    
    // 성별
    
    private let breedStackView = CustomStackView(text: "종", placeholder: "종류")
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.backgroundColor = .gray
        button.clipsToBounds = true
        button.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // 백버튼
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(profileTitle)
        contentView.addSubview(profileImageView)
        contentView.addSubview(profileNickName)
        contentView.addSubview(profileStackView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }

        profileTitle.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(profileTitle.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(100)
        }
        
        profileNickName.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        profileStackView.snp.makeConstraints {
            $0.top.equalTo(profileNickName.snp.bottom)
            $0.leading.trailing.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
    }
}

class CustomStackView: UIStackView {
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.textAlignment = .left
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: textField.frame.size.height))
        textField.leftViewMode = .always
        textField.borderStyle = .line
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.clipsToBounds = true
        return textField
    }()
    
    private func setupUI() {
        
        addSubview(label)
        addSubview(textField)
        
        label.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    init(text: String, placeholder: String) {
        super.init(frame: .zero)
        label.text = text
        textField.placeholder = placeholder
        setupUI()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
